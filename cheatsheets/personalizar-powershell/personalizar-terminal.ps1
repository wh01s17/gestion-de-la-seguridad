#Requires -Version 5.1
<#
.SYNOPSIS
    Post-instalacion de Windows Terminal + PowerShell (ver personalizar-terminal.md).

.DESCRIPTION
    - Instala Windows Terminal, PowerShell 7, Starship, zoxide y eza con winget y ofrece actualizarlos
    - Habilita la ejecucion de scripts (RemoteSigned) para el usuario si esta bloqueada
    - Instala una Nerd Font (Meslo) si no hay ninguna
    - Configura Windows Terminal: Snazzy, fuente, opacidad, acrilico y perfil predeterminado
    - Copia la configuracion de Starship de wh01s17/dotfiles (la misma que en Linux)
    - Crea o actualiza $PROFILE de PowerShell 7 y Windows PowerShell 5.1:
        * La configuracion gestionada va en un bloque marcado al final del perfil, con
          Starship y luego zoxide al final (zoxide envuelve el prompt de Starship);
          volver a ejecutar el script no duplica nada
        * Las lineas propias se conservan y lo que ya configuran (starship, zoxide, ls, ...)
          no se agrega al bloque
        * Si el perfil usa Oh My Posh, ofrece reemplazarlo por Starship y desinstalarlo

    Solo se pregunta por lo que falta; cada archivo se respalda antes de modificarlo.

.PARAMETER Yes
    Responder automaticamente con la opcion por defecto de cada pregunta.

.PARAMETER DryRun
    Mostrar lo que se haria sin instalar ni modificar nada.

.PARAMETER StarshipConfig
    URL o ruta del starship.toml que se copia (por defecto: el de wh01s17/dotfiles).

.PARAMETER SkipInstall
    No instalar ni actualizar programas con winget.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\personalizar-terminal.ps1

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\personalizar-terminal.ps1 -DryRun
#>
[CmdletBinding()]
param(
    [switch]$Yes,
    [switch]$DryRun,
    [string]$StarshipConfig = 'https://raw.githubusercontent.com/wh01s17/dotfiles/main/terminal/.config/starship.toml',
    [switch]$SkipInstall
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
# En Windows PowerShell 5.1 la barra de progreso hace muy lento Invoke-WebRequest.
$ProgressPreference = 'SilentlyContinue'

$BlockStart = '# >>> post-install-linux (gestionado por personalizar-terminal.ps1) >>>'
$BlockEnd = '# <<< post-install-linux <<<'
$MesloFace = 'MesloLGM Nerd Font'
$ListViewLine = 'Set-PSReadLineOption -PredictionViewStyle ListView'
# PSReadLine 2.0 (el de Windows PowerShell 5.1) no tiene -PredictionViewStyle.
$ListViewGuarded = "if ((Get-Module PSReadLine).Version -ge [version]'2.2.0') { $ListViewLine }"
$MenuCompleteLine = 'Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete'
$PwshTerminalSource = 'Windows.Terminal.PowershellCore'
# Accesos directos que se agregan junto con eza (nombre -> cuerpo de la funcion).
$EzaShortcuts = [ordered]@{
    l = 'eza --icons @args'
    ll = 'eza --icons -l @args'
    lla = 'eza --icons -la @args'
}
# Archivos de Meslo de una version fija de Nerd Fonts (el zip de la version completa pesa mas de 100 MB).
$MesloUrl = 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.5.1/patched-fonts/Meslo/M/MesloLGMNerdFont-{0}.ttf'
$MesloStyles = [ordered]@{ Regular = 'Regular'; Bold = 'Bold'; Italic = 'Italic'; BoldItalic = 'Bold Italic' }
$StarshipInitLine = 'Invoke-Expression (&starship init powershell)'
# starship.toml usa add_newline = false y en zsh la linea en blanco entre comandos la pone un hook
# precmd. Aqui se hace igual: el historial solo cambia si se ejecuto un comando, asi que no hay
# linea en blanco antes del primer prompt ni al presionar Enter sin escribir nada.
$StarshipPreCommand = @(
    'function Invoke-Starship-PreCommand {'
    '    $id = Get-History -Count 1 | ForEach-Object { $_.Id }'
    '    if ($id -and $id -ne $global:StarshipLastHistoryId) { Write-Host }'
    '    $global:StarshipLastHistoryId = $id'
    '}'
)
$PoshWingetId = 'JanDeDobbeleer.OhMyPosh'
# Codigos de salida de winget
$WingetNoUpdate = -1978335189            # no hay actualizaciones disponibles
$WingetTechnologyMismatch = -1978335090  # la version nueva usa otra tecnologia de instalacion

# Windows PowerShell 5.1 necesita TLS 1.2 y el proveedor NuGet para instalar desde PSGallery.
$GallerySetup51 = '[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; ' +
    'if (-not (Get-PackageProvider -ListAvailable -Name NuGet -ErrorAction SilentlyContinue)) { ' +
    'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Scope CurrentUser -Force | Out-Null }; '

$Tools = @(
    @{ Name = 'Windows Terminal'; Id = 'Microsoft.WindowsTerminal'; Command = 'wt' }
    @{ Name = 'PowerShell 7'; Id = 'Microsoft.PowerShell'; Command = 'pwsh' }
    @{ Name = 'Starship'; Id = 'Starship.Starship'; Command = 'starship' }
    @{ Name = 'zoxide'; Id = 'ajeetdsouza.zoxide'; Command = 'zoxide' }
    @{ Name = 'eza'; Id = 'eza-community.eza'; Command = 'eza' }
)

$TerminalSettingsPaths = @(
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
    "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"
)

$script:Interactive = $true
$script:Stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$script:Summary = New-Object System.Collections.Generic.List[string]
$script:FontFamilies = $null
# Algun perfil sigue cargando Oh My Posh despues de actualizar los perfiles.
$script:PoshInUse = $false

# --- Salida y preguntas ------------------------------------------------------

function Write-Step([string]$Message) {
    Write-Host ''
    Write-Host '==> ' -ForegroundColor Green -NoNewline
    Write-Host $Message
}

function Write-Info([string]$Message) { Write-Host "    $Message" }

function Write-Warn([string]$Message) {
    Write-Host '[!] ' -ForegroundColor Yellow -NoNewline
    Write-Host $Message
}

function Test-Interactive {
    if (-not [Environment]::UserInteractive) { return $false }
    if (@([Environment]::GetCommandLineArgs() | Where-Object { $_ -match '^-noni' }).Count) { return $false }
    try { return -not [Console]::IsInputRedirected } catch { return $true }
}

function Test-Automatic { $Yes -or -not $script:Interactive }

function Confirm-Choice([string]$Prompt, [bool]$Default = $true) {
    if (Test-Automatic) {
        Write-Info "$Prompt -> $(if ($Default) { 'si' } else { 'no' }) (automatico)"
        return $Default
    }
    $hint = if ($Default) { '[S/n]' } else { '[s/N]' }
    while ($true) {
        $answer = (Read-Host "    $Prompt $hint").Trim().ToLower()
        if (-not $answer) { return $Default }
        if ($answer -in 's', 'si', 'y', 'yes') { return $true }
        if ($answer -in 'n', 'no') { return $false }
    }
}

function Read-Value([string]$Prompt, [string]$Default) {
    if (Test-Automatic) {
        Write-Info "$Prompt -> $Default (automatico)"
        return $Default
    }
    $answer = Read-Host "    $Prompt [$Default]"
    if ([string]::IsNullOrWhiteSpace($answer)) { return $Default }
    $answer.Trim()
}

function Select-Option([string]$Prompt, [string[]]$Options, [int]$Default = 0) {
    Write-Info $Prompt
    for ($i = 0; $i -lt $Options.Count; $i++) { Write-Info "  $($i + 1)) $($Options[$i])" }
    if (Test-Automatic) {
        Write-Info "-> $($Options[$Default]) (automatico)"
        return $Default
    }
    while ($true) {
        $answer = Read-Host "    Opcion [$($Default + 1)]"
        if ([string]::IsNullOrWhiteSpace($answer)) { return $Default }
        $number = 0
        if ([int]::TryParse($answer, [ref]$number) -and $number -ge 1 -and $number -le $Options.Count) { return $number - 1 }
    }
}

# Ejecuta un cambio en el sistema (o solo lo describe con -DryRun) y lo anota en el resumen.
function Invoke-Change([string]$Description, [scriptblock]$Action) {
    $script:Summary.Add($Description)
    if ($DryRun) {
        Write-Info "[dry-run] $Description"
        return
    }
    Write-Info $Description
    $null = & $Action
}

# --- Utilidades --------------------------------------------------------------

function Test-Tool([string]$Name) {
    [bool](Get-Command $Name -CommandType Application -ErrorAction SilentlyContinue)
}

# Agrega al PATH de la sesion lo que winget haya registrado, sin quitar lo que ya habia
# (pwsh agrega su carpeta solo al PATH de su propio proceso).
function Update-SessionPath {
    $entries = @($env:Path -split ';') +
        @([Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';') +
        @([Environment]::GetEnvironmentVariable('Path', 'User') -split ';')
    $env:Path = @($entries | Where-Object { $_ } | Select-Object -Unique) -join ';'
}

function Find-Pwsh {
    if ($PSVersionTable.PSVersion.Major -ge 7) { return Join-Path $PSHOME 'pwsh.exe' }
    $command = Get-Command pwsh -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($command) { return $command.Source }
    foreach ($candidate in "$env:ProgramFiles\PowerShell\7\pwsh.exe", "$env:ProgramFiles\PowerShell\7-preview\pwsh.exe") {
        if (Test-Path -LiteralPath $candidate) { return $candidate }
    }
}

# Los comandos nativos se ejecutan con 'Continue' para que stderr no detenga el script en 5.1.
# Invoke-Native muestra la salida y devuelve el codigo; Get-NativeOutput devuelve la salida.
function Invoke-Native([string]$Exe, [string[]]$Arguments) {
    $ErrorActionPreference = 'Continue'
    & $Exe @Arguments | Out-Host
    $LASTEXITCODE
}

function Get-NativeOutput([string]$Exe, [string[]]$Arguments) {
    $ErrorActionPreference = 'Continue'
    @(& $Exe @Arguments 2>$null)
}

# -EncodedCommand evita los problemas de comillas al pasar codigo a otra version de PowerShell.
function Get-ShellArguments([string]$Command) {
    @('-NoProfile', '-NonInteractive', '-EncodedCommand', [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($Command)))
}

function Invoke-Shell([string]$Exe, [string]$Command) { Invoke-Native $Exe (Get-ShellArguments $Command) }

function Get-ShellOutput([string]$Exe, [string]$Command) { Get-NativeOutput $Exe (Get-ShellArguments $Command) }

# Respeta el BOM; sin BOM usa UTF-8 y, si no es valido, la pagina ANSI del sistema.
function Read-TextFile([string]$Path) {
    $bytes = [IO.File]::ReadAllBytes($Path)
    $prefix = ($bytes | Select-Object -First 3 | ForEach-Object { '{0:X2}' -f $_ }) -join ''
    if ($prefix -match '^(FFFE|FEFF|EFBBBF)') { return [IO.File]::ReadAllText($Path) }
    try {
        (New-Object Text.UTF8Encoding($false, $true)).GetString($bytes)
    } catch {
        [Text.Encoding]::GetEncoding([Globalization.CultureInfo]::CurrentCulture.TextInfo.ANSICodePage).GetString($bytes)
    }
}

function Write-TextFile([string]$Path, [string]$Content, [bool]$Bom) {
    $dir = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    [IO.File]::WriteAllText($Path, $Content, (New-Object Text.UTF8Encoding($Bom)))
}

function Backup-File([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return }
    $backup = "$Path.bak-$script:Stamp"
    Copy-Item -LiteralPath $Path -Destination $backup -Force
    Write-Info "Respaldo: $backup"
}

function Get-Prop($Object, [string]$Name) {
    if ($null -eq $Object) { return }
    $property = $Object.PSObject.Properties[$Name]
    if ($property) { $property.Value }
}

function Set-Prop($Object, [string]$Name, $Value) {
    $Object | Add-Member -NotePropertyName $Name -NotePropertyValue $Value -Force
}

# --- Programas ---------------------------------------------------------------

function Invoke-Winget([string]$Verb, $Tool) {
    $options = @('--id', $Tool.Id, '--exact', '--source', 'winget', '--accept-package-agreements', '--accept-source-agreements')
    $code = Invoke-Native 'winget' (@($Verb) + $options)
    if ($code -eq $WingetTechnologyMismatch) {
        # Pasa, por ejemplo, al cambiar del instalador clasico al paquete MSIX: winget no puede actualizar en el lugar.
        Write-Warn "La version nueva de $($Tool.Name) usa otra tecnologia de instalacion y winget pide desinstalar e instalar de nuevo."
        if (Confirm-Choice 'Desinstalar la version actual e instalar la ultima? (la configuracion del usuario no se modifica)' $true) {
            $code = Invoke-Native 'winget' @('uninstall', '--id', $Tool.Id, '--exact', '--source', 'winget')
            if ($code -eq 0) { $code = Invoke-Native 'winget' (@('install') + $options) }
        }
    }
    if ($code -ne 0 -and $code -ne $WingetNoUpdate) { Write-Warn "winget termino con codigo $code ($Verb $($Tool.Name))." }
}

function Install-Tools {
    Write-Step 'Programas'
    if (-not (Test-Tool 'winget')) {
        Write-Warn 'winget no esta disponible (instala "App Installer" desde Microsoft Store); se omite la instalacion.'
        return
    }

    $installed = @()
    foreach ($tool in $Tools) {
        $found = if ($tool.Command -eq 'pwsh') { [bool](Find-Pwsh) } else { Test-Tool $tool.Command }
        if ($found) {
            Write-Info "$($tool.Name): instalado"
            $installed += $tool
        } elseif (Confirm-Choice "$($tool.Name) no esta instalado. Instalarlo?" $true) {
            Invoke-Change "Instalar $($tool.Name) ($($tool.Id))" { Invoke-Winget 'install' $tool }
        }
    }
    Update-SessionPath

    if ($installed.Count -and (Confirm-Choice 'Buscar actualizaciones de los programas instalados?' $false)) {
        foreach ($tool in $installed) {
            Invoke-Change "Actualizar $($tool.Name) ($($tool.Id))" { Invoke-Winget 'upgrade' $tool }
        }
        Update-SessionPath
    }
}

# El resto se ejecuta en PowerShell 7 si esta disponible: maneja mejor JSON y UTF-8.
function Switch-ToPwsh {
    if ($PSVersionTable.PSVersion.Major -ge 7) { return }
    $pwsh = Find-Pwsh
    if (-not $pwsh) { return }

    Write-Step 'Continuando en PowerShell 7'
    $arguments = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $PSCommandPath, '-SkipInstall', '-StarshipConfig', $StarshipConfig)
    if ($Yes) { $arguments += '-Yes' }
    if ($DryRun) { $arguments += '-DryRun' }
    if ($script:Summary.Count) {
        Write-Info 'Cambios realizados hasta ahora:'
        foreach ($item in $script:Summary) { Write-Info "  - $item" }
    }
    & $pwsh @arguments
    exit $LASTEXITCODE
}

function Get-Shells {
    $docs = [Environment]::GetFolderPath('MyDocuments')
    $pwsh = Find-Pwsh
    if ($pwsh) {
        [pscustomobject]@{ Name = 'PowerShell 7'; Exe = $pwsh; Legacy = $false; Dir = Join-Path $docs 'PowerShell' }
    }
    [pscustomobject]@{
        Name = 'Windows PowerShell 5.1'; Exe = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"; Legacy = $true
        Dir = Join-Path $docs 'WindowsPowerShell'
    }
}

# --- Politica de ejecucion ---------------------------------------------------

# Se ignora el ambito Process: lo hereda este script (p. ej. -ExecutionPolicy Bypass).
function Get-EffectivePolicy([string]$Exe) {
    $map = @{}
    foreach ($line in Get-ShellOutput $Exe 'Get-ExecutionPolicy -List | ForEach-Object { "$($_.Scope)=$($_.ExecutionPolicy)" }') {
        $scope, $policy = "$line" -split '=', 2
        if ($policy) { $map[$scope] = $policy }
    }
    foreach ($scope in 'MachinePolicy', 'UserPolicy', 'CurrentUser', 'LocalMachine') {
        if ($map[$scope] -and $map[$scope] -ne 'Undefined') { return [pscustomobject]@{ Policy = $map[$scope]; Scope = $scope } }
    }
    [pscustomobject]@{ Policy = 'Restricted'; Scope = 'Default' }
}

function Set-ScriptPolicy($Shells) {
    Write-Step 'Politica de ejecucion de scripts'
    foreach ($shell in $Shells) {
        $policy = Get-EffectivePolicy $shell.Exe
        if ($policy.Policy -in 'RemoteSigned', 'Unrestricted', 'Bypass') {
            Write-Info "$($shell.Name): $($policy.Policy) (el perfil se puede cargar)"
            continue
        }
        if ($policy.Scope -in 'MachinePolicy', 'UserPolicy') {
            Write-Warn "$($shell.Name): '$($policy.Policy)' esta impuesta por una directiva de grupo y no se puede cambiar desde aqui."
            continue
        }
        # En 5.1 solo se propone por defecto si se usa (ya tiene perfil o no hay PowerShell 7).
        $default = (-not $shell.Legacy) -or (Test-Path -LiteralPath (Join-Path $shell.Dir 'Microsoft.PowerShell_profile.ps1')) -or -not (Find-Pwsh)
        if (Confirm-Choice "$($shell.Name) tiene la politica '$($policy.Policy)' y no cargara el perfil. Cambiar a RemoteSigned para el usuario actual?" $default) {
            Invoke-Change "$($shell.Name): Set-ExecutionPolicy RemoteSigned -Scope CurrentUser" {
                $code = Invoke-Shell $shell.Exe 'Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force'
                if ($code -ne 0) { Write-Warn "No se pudo cambiar la politica de $($shell.Name)." }
            }
        }
    }
}

# --- Fuente ------------------------------------------------------------------

function Get-InstalledFontFamilies {
    if ($null -eq $script:FontFamilies) {
        try {
            Add-Type -AssemblyName System.Drawing
            $script:FontFamilies = @((New-Object System.Drawing.Text.InstalledFontCollection).Families | ForEach-Object { $_.Name })
        } catch {
            $script:FontFamilies = @()
        }
    }
    $script:FontFamilies
}

function Get-NerdFontFamily {
    $families = @(Get-InstalledFontFamilies | Where-Object { $_ -match ' Nerd Font$' })
    if ($families -contains $MesloFace) { return $MesloFace }
    $families | Select-Object -First 1
}

# Instala la fuente solo para el usuario actual, sin permisos de administrador (igual que
# "Instalar" en el explorador): archivo en la carpeta de fuentes del usuario y entrada en HKCU.
function Install-MesloFont {
    $fontDir = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Fonts'
    $registry = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
    if (-not (Test-Path -LiteralPath $fontDir)) { New-Item -ItemType Directory -Path $fontDir -Force | Out-Null }
    if (-not (Test-Path -LiteralPath $registry)) { New-Item -Path $registry -Force | Out-Null }
    # AddFontResource la deja disponible sin cerrar sesion.
    Add-Type -Namespace PostInstall -Name Gdi -MemberDefinition '[DllImport("gdi32.dll", CharSet = CharSet.Unicode)] public static extern int AddFontResource(string file);'
    foreach ($style in $MesloStyles.Keys) {
        $path = Join-Path $fontDir "MesloLGMNerdFont-$style.ttf"
        Invoke-WebRequest -Uri ($MesloUrl -f $style) -OutFile $path -UseBasicParsing
        Set-ItemProperty -LiteralPath $registry -Name "$MesloFace $($MesloStyles[$style]) (TrueType)" -Value $path
        [void][PostInstall.Gdi]::AddFontResource($path)
    }
}

function Install-NerdFont {
    Write-Step 'Fuente'
    $nerd = Get-NerdFontFamily
    if ($nerd) {
        Write-Info "Nerd Font instalada: $nerd"
    } elseif (Confirm-Choice 'No hay ninguna Nerd Font instalada. Instalar Meslo (recomendada)?' $true) {
        Invoke-Change "Instalar fuente $MesloFace para el usuario actual" {
            try {
                Install-MesloFont
                # InstalledFontCollection no ve la fuente nueva en este proceso.
                $script:FontFamilies = @(Get-InstalledFontFamilies) + $MesloFace
            } catch {
                Write-Warn "No se pudo instalar la fuente: $($_.Exception.Message)"
            }
        }
    }
}

# --- Windows Terminal --------------------------------------------------------

function New-SnazzyScheme {
    [pscustomobject]@{
        name = 'Snazzy'; foreground = '#eff0eb'; background = '#282a36'
        selectionBackground = '#3e404a'; cursorColor = '#97979b'
        black = '#282a36'; red = '#ff5c57'; green = '#5af78e'; yellow = '#f3f99d'
        blue = '#57c7ff'; purple = '#ff6ac1'; cyan = '#9aedfe'; white = '#f1f1f0'
        brightBlack = '#686868'; brightRed = '#ff5c57'; brightGreen = '#5af78e'; brightYellow = '#f3f99d'
        brightBlue = '#57c7ff'; brightPurple = '#ff6ac1'; brightCyan = '#9aedfe'; brightWhite = '#eff0eb'
    }
}

# Agrega $Changes a la lista si el usuario acepta aplicar el valor que falta.
function Set-MissingSetting($Object, [string]$Name, $Value, [string]$Prompt, [string]$Label, $Changes) {
    if ($null -ne (Get-Prop $Object $Name)) {
        Write-Info "$($Label): configurado (se mantiene)"
    } elseif (Confirm-Choice $Prompt $true) {
        Set-Prop $Object $Name $Value
        $Changes.Add($Label)
    }
}

function Update-TerminalSettings {
    Write-Step 'Windows Terminal'
    $paths = @($TerminalSettingsPaths | Where-Object { Test-Path -LiteralPath $_ })
    if (-not $paths.Count) {
        Write-Warn 'No se encontro settings.json. Abre Windows Terminal una vez y vuelve a ejecutar el script.'
        return
    }

    foreach ($path in $paths) {
        Write-Info "Configuracion: $path"
        try {
            $settings = Read-TextFile $path | ConvertFrom-Json
        } catch {
            Write-Warn 'No se pudo leer settings.json (tiene comentarios o no es JSON valido). Aplica la configuracion a mano siguiendo personalizar-terminal.md.'
            continue
        }
        $profiles = Get-Prop $settings 'profiles'
        if ($null -eq $profiles -or $profiles -is [array]) {
            Write-Warn 'settings.json no tiene el formato actual de "profiles"; aplica la configuracion a mano.'
            continue
        }
        $defaults = Get-Prop $profiles 'defaults'
        if ($null -eq $defaults) {
            $defaults = New-Object PSObject
            Set-Prop $profiles 'defaults' $defaults
        }
        $list = @(Get-Prop $profiles 'list')
        $changes = New-Object System.Collections.Generic.List[string]

        # Combinacion de colores
        Set-MissingSetting $defaults 'colorScheme' 'Snazzy' 'Usar la combinacion de colores Snazzy por defecto?' 'combinacion de colores' $changes
        $schemes = @(@(Get-Prop $settings 'schemes') | Where-Object { $null -ne $_ })
        if ((Get-Prop $defaults 'colorScheme') -eq 'Snazzy' -and -not @($schemes | Where-Object { (Get-Prop $_ 'name') -eq 'Snazzy' }).Count) {
            Set-Prop $settings 'schemes' ($schemes + (New-SnazzyScheme))
            $changes.Add('esquema Snazzy agregado a "schemes"')
        }

        # Fuente
        $font = Get-Prop $defaults 'font'
        $face = Get-Prop $font 'face'
        if (-not $face) { $face = Get-Prop $defaults 'fontFace' }
        $nerd = Get-NerdFontFamily
        if ($face -and (Get-InstalledFontFamilies) -contains $face) {
            Write-Info "Fuente: $face (se mantiene)"
        } elseif (-not $nerd) {
            Write-Warn 'No hay una Nerd Font instalada; los iconos del prompt no se veran bien.'
        } elseif (Confirm-Choice $(if ($face) { "La fuente '$face' no esta instalada. Usar '$nerd'?" } else { "Usar la fuente '$nerd'?" }) $true) {
            if ($null -eq $font) {
                $font = New-Object PSObject
                Set-Prop $defaults 'font' $font
            }
            Set-Prop $font 'face' $nerd
            $changes.Add("fuente $nerd")
        }

        # Opacidad y acrilico
        if ($null -ne (Get-Prop $defaults 'acrylicOpacity')) {
            Write-Info 'Opacidad: configurada (se mantiene)'
        } else {
            Set-MissingSetting $defaults 'opacity' 95 'Opacidad del fondo al 95%?' 'opacidad' $changes
        }
        Set-MissingSetting $settings 'useAcrylicInTabRow' $true 'Usar material acrilico en la fila de pestanas?' 'acrilico en la fila de pestanas' $changes

        # Perfil predeterminado
        $pwshProfile = $list | Where-Object { (Get-Prop $_ 'source') -eq $PwshTerminalSource -and -not (Get-Prop $_ 'hidden') } | Select-Object -First 1
        if ($pwshProfile) {
            $guid = Get-Prop $pwshProfile 'guid'
            $current = Get-Prop $settings 'defaultProfile'
            if ($current -eq $guid) {
                Write-Info 'Perfil predeterminado: PowerShell 7'
            } else {
                $currentName = Get-Prop ($list | Where-Object { (Get-Prop $_ 'guid') -eq $current } | Select-Object -First 1) 'name'
                if (Confirm-Choice "Usar PowerShell 7 como perfil predeterminado (actual: $(if ($currentName) { $currentName } else { $current }))?" $true) {
                    Set-Prop $settings 'defaultProfile' $guid
                    $changes.Add('PowerShell 7 como perfil predeterminado')
                }
            }
        } elseif (Find-Pwsh) {
            Write-Warn 'Windows Terminal aun no muestra PowerShell 7. Cierralo, abrelo y vuelve a ejecutar el script para dejarlo como predeterminado.'
        }

        if (-not $changes.Count) {
            Write-Info 'Sin cambios en Windows Terminal.'
            continue
        }
        $json = $settings | ConvertTo-Json -Depth 64
        Invoke-Change "Windows Terminal: $($changes -join ', ')" {
            Backup-File $path
            Write-TextFile $path $json $false
        }
    }
}

# --- Starship ---------------------------------------------------------------

function Get-StarshipConfigPath {
    if ($env:STARSHIP_CONFIG) { return $env:STARSHIP_CONFIG }
    Join-Path $HOME '.config\starship.toml'
}

# Texto del starship.toml de origen (URL o archivo local); $null si no se pudo leer.
function Read-StarshipSource {
    try {
        if ($StarshipConfig -notmatch '^https?://') { return Read-TextFile $StarshipConfig }
        $temp = [IO.Path]::GetTempFileName()
        try {
            Invoke-WebRequest -Uri $StarshipConfig -OutFile $temp -UseBasicParsing
            Read-TextFile $temp
        } finally {
            Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue
        }
    } catch {
        Write-Warn "No se pudo leer ${StarshipConfig}: $($_.Exception.Message)"
    }
}

# Copia la misma configuracion que se usa en Linux; si la local es distinta, pregunta antes de reemplazarla.
function Update-StarshipConfig {
    Write-Step 'Configuracion de Starship'
    if (-not (Test-Tool 'starship')) {
        Write-Warn 'Starship no esta instalado; se omite su configuracion.'
        return
    }
    $target = Get-StarshipConfigPath
    Write-Info "Origen: $StarshipConfig"
    Write-Info "Destino: $target"
    $source = Read-StarshipSource
    if ($null -eq $source) { return }

    $exists = Test-Path -LiteralPath $target
    if ($exists -and ((Read-TextFile $target) -replace '\r\n', "`n") -eq ($source -replace '\r\n', "`n")) {
        Write-Info 'La configuracion ya es igual a la de origen.'
        return
    }
    $prompt = if ($exists) { 'La configuracion local es distinta de la de origen. Reemplazarla?' } else { 'Copiar la configuracion de Starship?' }
    if (Confirm-Choice $prompt $true) {
        # Sin BOM: es un archivo TOML.
        Invoke-Change "Copiar la configuracion de Starship a $target" {
            Backup-File $target
            Write-TextFile $target $source $false
        }
    }
}

# --- Perfil de PowerShell ----------------------------------------------------

# Separa el bloque gestionado de las lineas propias y detecta que configura cada parte.
function Read-ProfileState([string]$Text) {
    $user = New-Object System.Collections.Generic.List[string]
    $block = New-Object System.Collections.Generic.List[string]
    $inBlock = $false
    # El inicio se reconoce por el prefijo: el texto entre parentesis nombra el script y puede cambiar.
    foreach ($line in $Text -split '\r?\n') {
        if ($line.StartsWith('# >>> post-install-linux')) { $inBlock = $true }
        elseif ($line -eq $BlockEnd) { $inBlock = $false }
        elseif ($inBlock) { $block.Add($line) }
        else { $user.Add($line) }
    }
    $managed = $block -join "`n"
    $own = @($user | Where-Object { $_ -notmatch '^\s*#' }) -join "`n"
    $define = '(?m)^\s*(?:function\s+(?:global:)?|(?:Set|New)-Alias\s+(?:-Name\s+)?)'

    $state = [pscustomobject]@{
        UserLines = $user
        ListView = $managed -match 'PredictionViewStyle'
        MenuComplete = $managed -match 'MenuComplete'
        Zoxide = $managed -match 'zoxide init'
        ZoxideCd = $managed -match 'zoxide init powershell --cmd cd'
        Eza = $managed -match 'function ls \{ eza'
        TerminalIcons = $managed -match 'Terminal-Icons'
        Starship = $managed -match 'starship init'
        # Linea de Oh My Posh que dejaron versiones anteriores del script; se mantiene hasta pasar a Starship.
        PoshLine = $block | Where-Object { $_ -match '^\s*oh-my-posh init' } | Select-Object -First 1
        # Lo que ya configuran las lineas propias no se agrega al bloque.
        OwnListView = $own -match 'PredictionViewStyle'
        OwnMenuComplete = $own -match 'Set-PSReadLineKeyHandler\b.*\bTab\b'
        OwnZoxide = $own -match 'zoxide'
        OwnStarship = $own -match 'starship init'
        OwnPreCommand = $own -match 'Invoke-Starship-PreCommand'
        OwnPosh = $own -match 'oh-my-posh'
        OwnLs = ($own -match "$define(?:ls)\b") -or ($own -match 'Terminal-Icons')
        OwnCd = $own -match "$define(?:cd)\b"
        OwnShortcuts = @($EzaShortcuts.Keys | Where-Object { $own -match "$define$_\b" })
    }
    $state
}

function Test-UsesPosh([string]$Text) {
    [bool]@($Text -split '\r?\n' | Where-Object { $_ -match 'oh-my-posh' -and $_ -notmatch '^\s*#' }).Count
}

# Comenta las lineas propias que cargan Oh My Posh (es lo unico que el script cambia fuera del bloque).
function Disable-OwnPosh($State) {
    for ($i = 0; $i -lt $State.UserLines.Count; $i++) {
        if (Test-UsesPosh $State.UserLines[$i]) { $State.UserLines[$i] = "# $($State.UserLines[$i])" }
    }
    $State.OwnPosh = $false
}

# Pregunta solo por lo que el perfil aun no tiene.
function Complete-ProfileState($State) {
    $own = @(
        if ($State.OwnStarship) { 'Starship' }
        if ($State.OwnZoxide) { 'zoxide' }
        if ($State.OwnLs) { 'ls' }
        if ($State.OwnCd -and -not $State.OwnZoxide) { 'cd' }
        if ($State.OwnListView) { 'ListView' }
        if ($State.OwnMenuComplete) { 'Tab' }
    )
    if ($own.Count) { Write-Info "Configurado fuera del bloque gestionado (se mantiene): $($own -join ', ')" }

    if (-not ($State.ListView -or $State.OwnListView) -and
        (Confirm-Choice 'Mostrar el historial de comandos como lista (PSReadLine ListView)?' $true)) {
        $State.ListView = $true
    }

    if (-not ($State.MenuComplete -or $State.OwnMenuComplete) -and
        (Confirm-Choice 'Mostrar las opciones de autocompletado en un menu al presionar Tab (MenuComplete)?' $true)) {
        $State.MenuComplete = $true
    }

    if (-not ($State.Zoxide -or $State.OwnZoxide) -and (Test-Tool 'zoxide')) {
        $prompt = if ($State.OwnCd) { 'Agregar zoxide (comandos z y zi; cd ya esta personalizado)?' } else { 'Agregar zoxide (reemplaza cd y agrega cdi)?' }
        if (Confirm-Choice $prompt $true) {
            $State.Zoxide = $true
            $State.ZoxideCd = -not $State.OwnCd
        }
    }

    if (-not ($State.Eza -or $State.TerminalIcons -or $State.OwnLs)) {
        $options = @()
        if (Test-Tool 'eza') { $options += 'eza con iconos (reemplaza ls; agrega l, ll y lla)' }
        $options += 'Terminal-Icons (iconos en Get-ChildItem)', 'Sin iconos'
        $choice = $options[(Select-Option 'Iconos al listar archivos:' $options 0)]
        $State.Eza = $choice -like 'eza*'
        $State.TerminalIcons = $choice -like 'Terminal-Icons*'
    }

    if ($State.OwnStarship) { return }
    $posh = $State.PoshLine -or $State.OwnPosh
    if (-not $State.Starship) {
        if (-not (Test-Tool 'starship')) {
            Write-Warn $(if ($posh) { 'Starship no esta instalado; se mantiene Oh My Posh.' } else { 'Starship no esta instalado; no se agrega al perfil.' })
            return
        }
        if (-not (Confirm-Choice $(if ($posh) { 'El perfil usa Oh My Posh. Reemplazarlo por Starship?' } else { 'Agregar Starship al perfil?' }) $true)) { return }
        $State.Starship = $true
        $State.PoshLine = $null
    }
    if ($State.OwnPosh) {
        if (Confirm-Choice 'Las lineas propias del perfil cargan Oh My Posh. Comentarlas para usar solo Starship?' $true) {
            Disable-OwnPosh $State
        } else {
            Write-Warn 'Oh My Posh se seguira cargando antes del bloque: Starship reemplaza su prompt, pero la terminal tardara mas en abrir.'
        }
    }
    if ($State.OwnZoxide) {
        Write-Warn 'zoxide se inicializa fuera del bloque, antes de Starship, y no registrara directorios. Borra esa linea para que el script lo agregue al final.'
    }
}

function New-ProfileBlock($State, [bool]$Legacy) {
    if ($State.TerminalIcons) { 'Import-Module Terminal-Icons' }
    if ($State.ListView) { if ($Legacy) { $ListViewGuarded } else { $ListViewLine } }
    if ($State.MenuComplete) { $MenuCompleteLine }
    if ($State.Eza) {
        'Remove-Item Alias:ls -Force -ErrorAction Ignore'
        'function ls { eza --icons @args }'
        foreach ($name in $EzaShortcuts.Keys) {
            if ($State.OwnShortcuts -notcontains $name) { "function $name { $($EzaShortcuts[$name]) }" }
        }
    }
    if ($State.Starship) {
        if (-not $State.OwnPreCommand) { $StarshipPreCommand }
        $StarshipInitLine
    } elseif ($State.PoshLine) {
        $State.PoshLine
    }
    # zoxide registra los directorios envolviendo la funcion prompt, asi que va despues de
    # Starship: si no, Starship reemplaza el prompt y zoxide deja de aprender rutas.
    if ($State.Zoxide) { "Invoke-Expression (& { (zoxide init powershell$(if ($State.ZoxideCd) { ' --cmd cd' }) | Out-String) })" }
}

# Lineas propias tal cual (sin lineas vacias al final) y el bloque gestionado al final.
function New-ProfileContent($State, [string[]]$Block) {
    $lines = @($State.UserLines)
    $end = $lines.Count - 1
    while ($end -ge 0 -and [string]::IsNullOrWhiteSpace($lines[$end])) { $end-- }
    $lines = @(if ($end -ge 0) { $lines[0..$end] })
    if ($Block.Count) {
        if ($lines.Count) { $lines += '' }
        $lines += @($BlockStart) + $Block + @($BlockEnd)
    }
    if (-not $lines.Count) { return '' }
    ($lines -join "`r`n") + "`r`n"
}

function Update-ShellModules($Shell, $State) {
    $setup = if ($Shell.Legacy) { $GallerySetup51 } else { '' }

    if ($State.TerminalIcons -and
        (Get-ShellOutput $Shell.Exe "if (Get-Module -ListAvailable -Name Terminal-Icons) { 'ok' }") -notcontains 'ok' -and
        (Confirm-Choice "Terminal-Icons no esta instalado en $($Shell.Name). Instalarlo?" $true)) {
        Invoke-Change "Instalar Terminal-Icons en $($Shell.Name)" {
            $code = Invoke-Shell $Shell.Exe ($setup + 'Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force')
            if ($code -ne 0) { Write-Warn 'No se pudo instalar Terminal-Icons.' }
        }
    }

    if (-not ($Shell.Legacy -and ($State.ListView -or $State.OwnListView))) { return }
    $version = [version]'0.0'
    $output = Get-ShellOutput $Shell.Exe '(Get-Module -ListAvailable PSReadLine | Sort-Object Version -Descending | Select-Object -First 1).Version.ToString()'
    [void][version]::TryParse("$($output | Select-Object -Last 1)", [ref]$version)
    if ($version -ge [version]'2.2.0') { return }
    if (Confirm-Choice "PSReadLine $version no soporta la vista en lista (requiere 2.2+). Actualizarlo en $($Shell.Name)?" $true) {
        Invoke-Change "Actualizar PSReadLine en $($Shell.Name)" {
            $code = Invoke-Shell $Shell.Exe ($setup + 'Install-Module -Name PSReadLine -Repository PSGallery -Scope CurrentUser -Force -SkipPublisherCheck')
            if ($code -ne 0) { Write-Warn 'No se pudo actualizar PSReadLine.' }
        }
    } elseif ($State.ListView) {
        Write-Info 'El perfil comprueba la version, asi que seguira funcionando sin la vista en lista.'
    }
}

function Update-Profiles($Shells) {
    $hasPwsh = @($Shells | Where-Object { -not $_.Legacy }).Count -gt 0
    foreach ($shell in $Shells) {
        $profilePath = Join-Path $shell.Dir 'Microsoft.PowerShell_profile.ps1'
        Write-Step "Perfil de $($shell.Name)"
        Write-Info $profilePath

        $exists = Test-Path -LiteralPath $profilePath
        $original = ''
        if ($exists) {
            $original = Read-TextFile $profilePath
        } elseif (-not (Confirm-Choice 'El perfil no existe. Crearlo?' (-not ($shell.Legacy -and $hasPwsh)))) {
            continue
        }

        $allHosts = Join-Path $shell.Dir 'profile.ps1'
        if ((Test-Path -LiteralPath $allHosts) -and (Read-TextFile $allHosts) -match 'oh-my-posh|starship init') {
            Write-Warn "$allHosts tambien inicializa el prompt; revisalo para evitar duplicados."
        }

        $state = Read-ProfileState $original
        Complete-ProfileState $state
        $block = @(New-ProfileBlock $state $shell.Legacy)
        $content = New-ProfileContent $state $block
        $saved = $true
        if ($content -eq ($original -replace '\r?\n', "`r`n")) {
            Write-Info 'El perfil ya esta actualizado.'
        } else {
            Write-Info 'Bloque gestionado:'
            foreach ($line in $block) { Write-Host "      $line" -ForegroundColor DarkGray }
            $saved = Confirm-Choice 'Guardar el perfil?' $true
            if ($saved) {
                Invoke-Change "$(if ($exists) { 'Actualizar' } else { 'Crear' }) perfil de $($shell.Name)" {
                    Backup-File $profilePath
                    Write-TextFile $profilePath $content $true
                }
            }
        }
        if (Test-UsesPosh $(if ($saved) { $content } else { $original })) { $script:PoshInUse = $true }

        Update-ShellModules $shell $state
    }
}

# Ofrece desinstalar Oh My Posh cuando ya ningun perfil lo carga. Los temas guardados no se borran.
function Remove-OhMyPosh($Shells) {
    if (-not (Test-Tool 'oh-my-posh')) { return }
    Write-Step 'Oh My Posh'
    # Otros perfiles (todos los hosts, VS Code, ...) que este script no gestiona.
    $others = @(foreach ($shell in $Shells) {
        Get-ChildItem -LiteralPath $shell.Dir -Filter '*profile.ps1' -File -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -ne 'Microsoft.PowerShell_profile.ps1' -and (Test-UsesPosh (Read-TextFile $_.FullName)) } |
            ForEach-Object { $_.FullName }
    })
    if ($script:PoshInUse -or $others.Count) {
        Write-Info "Sigue en uso$(if ($others.Count) { " ($($others -join ', '))" }); no se desinstala."
        return
    }
    if (-not (Test-Tool 'winget')) {
        Write-Info 'Ya no se usa en los perfiles; se puede desinstalar desde Configuracion > Aplicaciones.'
    } elseif (Confirm-Choice 'Oh My Posh ya no se usa en los perfiles. Desinstalarlo?' $false) {
        Invoke-Change "Desinstalar Oh My Posh ($PoshWingetId)" {
            $code = Invoke-Native 'winget' @('uninstall', '--id', $PoshWingetId, '--exact', '--source', 'winget')
            if ($code -ne 0) { Write-Warn "winget termino con codigo $code al desinstalar Oh My Posh." }
        }
    }
    $themes = @(Get-ChildItem -LiteralPath $HOME -Filter '*.omp.*' -File -ErrorAction SilentlyContinue | ForEach-Object { $_.Name })
    if ($themes.Count) { Write-Info "Los temas guardados en $HOME no se borran: $($themes -join ', ')" }
}

# --- Principal ---------------------------------------------------------------

function Show-Summary {
    Write-Step $(if ($DryRun) { 'Resumen (simulacion: no se modifico nada)' } else { 'Resumen' })
    if (-not $script:Summary.Count) {
        Write-Info 'No hubo cambios.'
        return
    }
    foreach ($item in $script:Summary) { Write-Info "- $item" }
    if (-not $DryRun) { Write-Info 'Reinicia Windows Terminal (o ejecuta . $PROFILE) para ver los cambios.' }
}

function Main {
    $script:Interactive = Test-Interactive
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    # Ruta absoluta: [IO.File] y la instancia de PowerShell 7 no usan el directorio actual de esta sesion.
    if ($StarshipConfig -notmatch '^https?://' -and (Test-Path -LiteralPath $StarshipConfig)) {
        $script:StarshipConfig = (Resolve-Path -LiteralPath $StarshipConfig).ProviderPath
    }

    Write-Step "Configuracion de Windows Terminal y PowerShell $($PSVersionTable.PSVersion)"
    if ($DryRun) { Write-Warn 'Modo simulacion: no se instalara ni modificara nada.' }

    if (-not $SkipInstall) { Install-Tools }
    Update-SessionPath
    Switch-ToPwsh

    $shells = @(Get-Shells)
    Set-ScriptPolicy $shells
    Install-NerdFont
    Update-TerminalSettings
    Update-StarshipConfig
    Update-Profiles $shells
    Remove-OhMyPosh $shells
    Show-Summary
}

# Permite cargar las funciones con ". .\personalizar-terminal.ps1" sin ejecutar nada.
if ($MyInvocation.InvocationName -ne '.') { Main }
