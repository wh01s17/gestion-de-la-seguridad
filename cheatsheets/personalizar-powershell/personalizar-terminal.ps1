#Requires -Version 5.1
<#
.SYNOPSIS
    Post-instalacion de Windows Terminal + PowerShell (ver personalizar-terminal.md).

.DESCRIPTION
    - Instala Windows Terminal, PowerShell 7, Oh My Posh, zoxide y eza con winget y ofrece actualizarlos
    - Habilita la ejecucion de scripts (RemoteSigned) para el usuario si esta bloqueada
    - Instala una Nerd Font (Meslo) si no hay ninguna
    - Configura Windows Terminal: Snazzy, fuente, opacidad, acrilico y perfil predeterminado
    - Crea o actualiza $PROFILE de PowerShell 7 y Windows PowerShell 5.1:
        * La configuracion gestionada va en un bloque marcado al final del perfil, con
          Oh My Posh como ultima linea; volver a ejecutar el script no duplica nada
        * Las lineas propias se conservan y lo que ya configuran (oh-my-posh, zoxide, ls, ...)
          no se agrega al bloque

    Solo se pregunta por lo que falta; cada archivo se respalda antes de modificarlo.

.PARAMETER Yes
    Responder automaticamente con la opcion por defecto de cada pregunta.

.PARAMETER DryRun
    Mostrar lo que se haria sin instalar ni modificar nada.

.PARAMETER Theme
    Tema de Oh My Posh propuesto cuando el perfil aun no tiene uno (por defecto: pure).

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
    [string]$Theme = 'pure',
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
$ThemesZipUrl = 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip'
$ThemePageSize = 6
$PoshSchemaUrl = 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json'
$PoshReleasesApi = 'https://api.github.com/repos/JanDeDobbeleer/oh-my-posh/releases/latest'
$PoshWingetId = 'JanDeDobbeleer.OhMyPosh'
# Tema propio que extiende el elegido para agregar el venv de Python y Node.js (funciona con cualquier tema).
$PoshOverlayFile = Join-Path $HOME 'mi-tema.omp.json'
$PoshOverlayConfig = '$HOME\mi-tema.omp.json'
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
    @{ Name = 'Oh My Posh'; Id = $PoshWingetId; Command = 'oh-my-posh' }
    @{ Name = 'zoxide'; Id = 'ajeetdsouza.zoxide'; Command = 'zoxide' }
    @{ Name = 'eza'; Id = 'eza-community.eza'; Command = 'eza' }
)

$TerminalSettingsPaths = @(
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
    "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"
)

$script:Interactive = $true
$script:Ansi = $false
$script:Stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$script:Summary = New-Object System.Collections.Generic.List[string]
$script:FontFamilies = $null
$script:PoshVersion = $null
$script:PoshChoice = $null
$script:ThemeFiles = $null
$script:ThemeDir = $null

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

    foreach ($tool in @($installed | Where-Object { $_.Id -eq $PoshWingetId })) { Update-OhMyPosh $tool }
    $others = @($installed | Where-Object { $_.Id -ne $PoshWingetId })
    if ($others.Count -and (Confirm-Choice 'Buscar actualizaciones de los demas programas instalados?' $false)) {
        foreach ($tool in $others) {
            Invoke-Change "Actualizar $($tool.Name) ($($tool.Id))" { Invoke-Winget 'upgrade' $tool }
        }
        Update-SessionPath
    }
}

function Get-PoshVersion {
    if ($null -eq $script:PoshVersion) {
        $version = [version]'0.0'
        if (Test-Tool 'oh-my-posh') {
            [void][version]::TryParse("$(Get-NativeOutput 'oh-my-posh' @('version') | Select-Object -First 1)".Trim(), [ref]$version)
        }
        $script:PoshVersion = $version
    }
    $script:PoshVersion
}

# Un Oh My Posh desactualizado ignora sin avisar opciones de los temas actuales
# (por ejemplo, la clave 'options' de los segmentos antes de la version 28).
function Update-OhMyPosh($Tool) {
    $installed = Get-PoshVersion
    if ($installed.Major -eq 0) { return }
    try {
        $latest = [version](("$((Invoke-RestMethod -Uri $PoshReleasesApi -UseBasicParsing).tag_name)").TrimStart('v'))
    } catch {
        Write-Warn "No se pudo consultar la ultima version de Oh My Posh: $($_.Exception.Message)"
        return
    }
    if ($installed -ge $latest) {
        Write-Info "Oh My Posh $installed esta al dia."
        return
    }
    if ($installed.Major -lt $latest.Major) {
        Write-Warn "Oh My Posh $installed esta desactualizado (ultima: $latest); los temas actuales pueden no verse como se espera."
    }
    if (Confirm-Choice "Actualizar Oh My Posh $installed -> $($latest)?" $true) {
        Invoke-Change "Actualizar Oh My Posh $installed -> $latest" { Invoke-Winget 'upgrade' $Tool }
        Update-SessionPath
        $script:PoshVersion = $null
    }
}

# El resto se ejecuta en PowerShell 7 si esta disponible: maneja mejor JSON y UTF-8.
function Switch-ToPwsh {
    if ($PSVersionTable.PSVersion.Major -ge 7) { return }
    $pwsh = Find-Pwsh
    if (-not $pwsh) { return }

    Write-Step 'Continuando en PowerShell 7'
    $arguments = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $PSCommandPath, '-SkipInstall', '-Theme', $Theme)
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

function Install-NerdFont {
    Write-Step 'Fuente'
    $nerd = Get-NerdFontFamily
    if ($nerd) {
        Write-Info "Nerd Font instalada: $nerd"
    } elseif (-not (Test-Tool 'oh-my-posh')) {
        Write-Warn 'No hay ninguna Nerd Font y Oh My Posh no esta instalado para instalarla.'
    } elseif (Confirm-Choice 'No hay ninguna Nerd Font instalada. Instalar Meslo (recomendada)?' $true) {
        Invoke-Change 'Instalar fuente Meslo (oh-my-posh font install meslo)' {
            $code = Invoke-Native 'oh-my-posh' @('font', 'install', 'meslo')
            if ($code -ne 0) { Write-Warn "oh-my-posh termino con codigo $code al instalar la fuente." }
        }
        # InstalledFontCollection no ve la fuente nueva en este proceso.
        $script:FontFamilies = @(Get-InstalledFontFamilies) + $MesloFace
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

# --- Oh My Posh --------------------------------------------------------------

# Ruta local de un --config ('$HOME\tema.omp.json' o ruta absoluta); $null si es un nombre de tema o una URL.
function Resolve-PoshConfigPath([string]$Config) {
    if ($Config -notmatch '\.omp\.(json|ya?ml|toml)$' -or $Config -match '^https?://') { return $null }
    if ($Config.StartsWith('$HOME', [StringComparison]::OrdinalIgnoreCase)) { return $HOME + $Config.Substring(5) }
    $Config
}

function Format-PoshConfig([string]$Config) {
    if ($Config -match '\$') { return '"' + $Config + '"' }
    "'" + $Config + "'"
}

# Temas disponibles (nombre -> archivo local) para mostrar ejemplos. Descarga themes.zip de la
# ultima version; sin internet usa los temas que traen algunos instaladores (POSH_THEMES_PATH).
function Get-PoshThemeGallery {
    if ($null -ne $script:ThemeFiles) { return $script:ThemeFiles }
    $script:ThemeFiles = @{}
    $dir = Join-Path ([IO.Path]::GetTempPath()) "omp-themes-$PID"
    $zip = "$dir.zip"
    $source = $null
    try {
        Write-Info 'Descargando los temas de Oh My Posh...'
        Invoke-WebRequest -Uri $ThemesZipUrl -OutFile $zip -UseBasicParsing
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [IO.Compression.ZipFile]::ExtractToDirectory($zip, $dir)
        $script:ThemeDir = $dir
        $source = $dir
    } catch {
        Write-Warn "No se pudieron descargar los temas: $($_.Exception.Message)"
        if ($env:POSH_THEMES_PATH -and (Test-Path -LiteralPath $env:POSH_THEMES_PATH)) {
            $source = $env:POSH_THEMES_PATH
            Write-Info "Se usan los temas locales de $source"
        }
    } finally {
        Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue
    }
    if ($source) {
        foreach ($file in Get-ChildItem -LiteralPath $source -File | Where-Object { $_.Name -match '\.omp\.(json|ya?ml|toml)$' }) {
            $script:ThemeFiles[($file.Name -replace '\.omp\.(json|ya?ml|toml)$', '')] = $file.FullName
        }
    }
    $script:ThemeFiles
}

function Show-PoshThemePreview([string]$File) {
    $width = 100
    try { $width = [Math]::Max(40, $Host.UI.RawUI.WindowSize.Width - 8) } catch { }
    $arguments = @('print', 'primary', '--config', $File, '--shell', 'pwsh', '--pwd', $HOME, '--terminal-width', "$width")
    if (-not $script:Ansi) { $arguments += '--plain' }

    # oh-my-posh escribe UTF-8; sin esto los iconos de la Nerd Font se leen mal.
    $encoding = $null
    try {
        $encoding = [Console]::OutputEncoding
        [Console]::OutputEncoding = [Text.Encoding]::UTF8
    } catch { }
    $output = Get-NativeOutput 'oh-my-posh' $arguments
    if ($encoding) { try { [Console]::OutputEncoding = $encoding } catch { } }

    $esc = [char]27
    foreach ($line in $output) {
        # Se quitan las secuencias OSC (titulo de la ventana, etc.) para no alterar la terminal, y las
        # de guardar/restaurar cursor: el prompt derecho ya viene alineado con espacios.
        $clean = "$line" -replace "$esc\][^\a$esc]*(?:\a|$esc\\)", '' -replace "$esc[78]", ''
        Write-Host "        $clean$esc[0m"
    }
}

# Galeria paginada con un ejemplo del prompt de cada tema. Devuelve $null si no hay galeria.
function Select-PoshTheme([string]$Default) {
    $files = Get-PoshThemeGallery
    if (-not $files.Count) { return $null }
    $all = @($files.Keys | Sort-Object)
    $list = $all
    $filter = ''
    $page = 0

    while ($true) {
        $pages = [Math]::Max(1, [int][Math]::Ceiling($list.Count / $ThemePageSize))
        if ($page -ge $pages) { $page = 0 }
        if ($page -lt 0) { $page = $pages - 1 }
        $label = if ($filter) { ", busqueda '$filter'" } else { '' }
        $count = if ($list.Count -eq 1) { '1 tema' } else { "$($list.Count) temas" }
        Write-Host ''
        Write-Info "Temas de Oh My Posh - pagina $($page + 1)/$pages ($count$label)"

        $first = $page * $ThemePageSize
        $last = [Math]::Min($list.Count, $first + $ThemePageSize) - 1
        for ($i = $first; $i -le $last; $i++) {
            Write-Host ''
            Write-Host ('    {0,3}) {1}' -f ($i + 1), $list[$i]) -ForegroundColor Cyan
            Show-PoshThemePreview $files[$list[$i]]
        }

        Write-Host ''
        Write-Info "[numero] elegir  [Enter] siguiente  [a] anterior  [texto] buscar  [*] ver todos  [q] usar '$Default'"
        $answer = (Read-Host '    Tema').Trim()
        if (-not $answer) { $page++; continue }
        if ($answer -eq 'a') { $page--; continue }
        if ($answer -eq 'q') { return $Default }
        if ($answer -eq '*') {
            $list = $all
            $filter = ''
            $page = 0
            continue
        }
        $number = 0
        if ([int]::TryParse($answer, [ref]$number)) {
            if ($number -ge 1 -and $number -le $list.Count) { return $list[$number - 1] }
            Write-Warn "Numero fuera de rango (1-$($list.Count))."
            continue
        }
        $exact = @($all | Where-Object { $_ -eq $answer })
        if ($exact.Count) { return $exact[0] }
        $found = @($all | Where-Object { $_ -like "*$answer*" })
        if ($found.Count) {
            $list = $found
            $filter = $answer
            $page = 0
        } else {
            Write-Warn "Ningun tema contiene '$answer'."
        }
    }
}

function Export-PoshTheme([string]$Name, [string]$Path) {
    $code = Invoke-Native 'oh-my-posh' @('config', 'export', '--config', $Name, '--output', $Path)
    if ($code -ne 0) { Write-Warn "No se pudo exportar el tema '$Name'." }
}

# Muestra la galeria (o pide el nombre si no hay) y guarda la eleccion para el otro perfil.
function Get-PoshThemeChoice([string]$Default) {
    if (-not $Default) { $Default = $Theme }
    $name = if (-not (Test-Automatic)) { Select-PoshTheme $Default }
    # 'config export' devuelve el tema por defecto sin error si el nombre no existe,
    # asi que se valida contra la galeria (si no se pudo descargar, se acepta el nombre).
    while ($true) {
        if (-not $name) { $name = Read-Value 'Tema de Oh My Posh (https://ohmyposh.dev/docs/themes)' $Default }
        $files = Get-PoshThemeGallery
        if (-not $files.Count -or $name -match '^https?://' -or (Resolve-PoshConfigPath $name)) { break }
        $exact = @($files.Keys | Where-Object { $_ -eq $name })
        if ($exact.Count) {
            $name = $exact[0]
            break
        }
        Write-Warn "No se encontro el tema '$name'."
        if (Test-Automatic) { return $null }
        $name = $null
    }
    Write-Info "Tema elegido: $name"
    $config = $name
    if (Confirm-Choice 'Exportar el tema a un archivo local? (inicia mas rapido y funciona sin internet)' $false) {
        $target = Join-Path $HOME "$name.omp.json"
        Invoke-Change "Exportar tema '$name' a $target" { Export-PoshTheme $name $target }
        $config = "`$HOME\$name.omp.json"
    }
    $script:PoshChoice = $config
    $config
}

# --- Segmentos extra en el prompt (venv de Python, Node.js) ------------------

# Oh My Posh 28 renombro 'properties' a 'options' en los segmentos; las versiones
# anteriores ignoran 'options' sin mostrar error.
function New-PoshSegment([string]$Type, [string]$Foreground, [string]$Template, [hashtable]$Options) {
    $segment = [pscustomobject]@{ type = $Type; style = 'plain'; foreground = $Foreground; template = $Template }
    Set-Prop $segment $(if ((Get-PoshVersion).Major -ge 28) { 'options' } else { 'properties' }) ([pscustomobject]$Options)
    $segment
}

# Segmentos que se pueden agregar a cualquier tema. 'Pattern' indica cuando el tema ya lo muestra.
function Get-ExtraSegments {
    [pscustomobject]@{
        Type = 'python'; Label = 'Venv de Python'; Pattern = '\.Venv'
        Prompt = 'Mostrar el entorno virtual de Python (venv) en el prompt?'
        # Algunos temas ocultan el venv (fetch_virtual_env) o solo muestran python con archivos .py.
        New = { New-PoshSegment 'python' '#EBCB8B' " $([char]0xE235) {{ .Full }}{{ if .Venv }} ({{ .Venv }}){{ end }} " @{ display_mode = 'context'; fetch_virtual_env = $true } }
    }
    [pscustomobject]@{
        Type = 'node'; Label = 'Version de Node.js'; Pattern = ''
        Prompt = 'Mostrar la version de Node.js en proyectos JavaScript (package.json, .nvmrc, ...)?'
        # Usa el node activo en el PATH, asi que respeta la version elegida con nvm.
        New = { New-PoshSegment 'node' '#8CC265' " $([char]0xE718) {{ .Full }} " @{ display_mode = 'files' } }
    }
}

# Lee un tema JSON local referenciado por --config; $null si es un nombre, una URL o no existe.
function Read-PoshConfigFile([string]$Config) {
    $path = Resolve-PoshConfigPath $Config
    if (-not $path -or $path -notmatch '\.json$' -or -not (Test-Path -LiteralPath $path)) { return $null }
    try { $json = Read-TextFile $path | ConvertFrom-Json } catch { return $null }
    [pscustomobject]@{ Path = $path; Json = $json }
}

function Write-PoshConfigFile([string]$Path, $Json) {
    Backup-File $Path
    Write-TextFile $Path ($Json | ConvertTo-Json -Depth 32) $false
}

function Test-ShowsSegment($Json, [string]$Type, [string]$Pattern) {
    foreach ($block in @(Get-Prop $Json 'blocks')) {
        foreach ($segment in @(Get-Prop $block 'segments')) {
            if ((Get-Prop $segment 'type') -eq $Type -and "$(Get-Prop $segment 'template')" -match $Pattern) { return $true }
        }
    }
    $false
}

# Con 'extends', Oh My Posh combina este bloque con el primer bloque izquierdo del tema base.
function Add-PoshSegment($Json, $Segment) {
    $blocks = @(@(Get-Prop $Json 'blocks') | Where-Object { $null -ne $_ })
    $block = $blocks | Where-Object { (Get-Prop $_ 'type') -eq 'prompt' -and (Get-Prop $_ 'alignment') -eq 'left' } | Select-Object -First 1
    if (-not $block) {
        $block = [pscustomobject]@{ type = 'prompt'; alignment = 'left'; segments = @() }
        Set-Prop $Json 'blocks' ($blocks + $block)
    }
    Set-Prop $block 'segments' (@(@(Get-Prop $block 'segments') | Where-Object { $null -ne $_ }) + $Segment)
}

# Valor de 'extends' para un --config: nombre de tema, URL o ruta absoluta.
function ConvertTo-ExtendsValue([string]$Config) {
    $path = Resolve-PoshConfigPath $Config
    if ($path) { $path } else { $Config }
}

# Agrega los segmentos elegidos a un tema propio que extiende el del perfil ($PoshOverlayFile).
# Si el perfil ya usa un tema con 'extends', se agregan ahi mismo.
function Update-PoshSegments($State) {
    if (-not $State.PoshConfig) {
        Write-Info 'El perfil usa el tema por defecto de Oh My Posh; elige un tema para agregar venv o Node.js.'
        return
    }
    $file = Read-PoshConfigFile $State.PoshConfig
    if ($file -and -not (Get-Prop $file.Json 'extends')) { $file = $null }

    $wanted = @()
    foreach ($extra in Get-ExtraSegments) {
        if ($file -and (Test-ShowsSegment $file.Json $extra.Type $extra.Pattern)) {
            Write-Info "$($extra.Label): el tema ya lo muestra"
        } elseif (($extra.Type -ne 'node' -or (Test-Tool 'node')) -and (Confirm-Choice $extra.Prompt $false)) {
            $wanted += $extra
        }
    }
    if (-not $wanted.Count) { return }

    if (-not $file) {
        $file = Read-PoshConfigFile $PoshOverlayConfig
        if (Test-Path -LiteralPath $PoshOverlayFile) {
            if (-not ($file -and (Get-Prop $file.Json 'extends'))) {
                Write-Warn "$PoshOverlayFile ya existe y no extiende un tema; no se modifica."
                return
            }
        } else {
            $file = [pscustomobject]@{ Path = $PoshOverlayFile; Json = [pscustomobject]@{ '$schema' = $PoshSchemaUrl; version = 4 } }
        }
        Set-Prop $file.Json 'extends' (ConvertTo-ExtendsValue $State.PoshConfig)
        $State.PoshConfig = $PoshOverlayConfig
        $script:PoshChoice = $PoshOverlayConfig
    }
    foreach ($extra in $wanted) {
        if (-not (Test-ShowsSegment $file.Json $extra.Type $extra.Pattern)) { Add-PoshSegment $file.Json (& $extra.New) }
    }
    Invoke-Change "Agregar $(($wanted | ForEach-Object { $_.Label }) -join ', ') a $($file.Path) (tema '$(Get-Prop $file.Json 'extends')')" {
        Write-PoshConfigFile $file.Path $file.Json
    }
}

# El tema actual se mantiene salvo que el usuario quiera cambiarlo. Si el perfil usa un
# tema propio con 'extends', se cambia el tema base dentro de ese archivo.
function Update-PoshTheme($State) {
    $file = Read-PoshConfigFile $State.PoshConfig
    $extends = Get-Prop $(if ($file) { $file.Json }) 'extends'
    if ($script:PoshChoice) {
        if ($State.PoshConfig -ne $script:PoshChoice -and
            (Confirm-Choice "Usar tambien el tema elegido ($script:PoshChoice) en lugar de '$($State.PoshConfig)'?" $true)) {
            $State.PoshConfig = $script:PoshChoice
        }
        return
    }
    $current = if ($extends) { "$extends (en $($file.Path))" } elseif ($State.PoshConfig) { $State.PoshConfig } else { 'predeterminado' }
    if (-not (Confirm-Choice "El perfil usa el tema '$current'. Elegir otro tema?" $false)) { return }

    $reference = if ($extends) { $extends } else { $State.PoshConfig }
    $default = if ($reference -and -not (Resolve-PoshConfigPath $reference) -and $reference -notmatch '^https?://') { $reference } else { $Theme }
    $config = Get-PoshThemeChoice $default
    if (-not $config) { return }
    if ($extends) {
        $base = ConvertTo-ExtendsValue $config
        Set-Prop $file.Json 'extends' $base
        Invoke-Change "Cambiar el tema base de $($file.Path) a '$base'" { Write-PoshConfigFile $file.Path $file.Json }
        $script:PoshChoice = $State.PoshConfig
    } else {
        $State.PoshConfig = $config
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
        Posh = $false
        PoshConfig = $null
        # Lo que ya configuran las lineas propias no se agrega al bloque.
        OwnListView = $own -match 'PredictionViewStyle'
        OwnMenuComplete = $own -match 'Set-PSReadLineKeyHandler\b.*\bTab\b'
        OwnZoxide = $own -match 'zoxide'
        OwnPosh = $own -match 'oh-my-posh'
        OwnLs = ($own -match "$define(?:ls)\b") -or ($own -match 'Terminal-Icons')
        OwnCd = $own -match "$define(?:cd)\b"
        OwnShortcuts = @($EzaShortcuts.Keys | Where-Object { $own -match "$define$_\b" })
    }
    if ($managed -match '(?m)^oh-my-posh init pwsh(?: --config (?:''([^'']*)''|"([^"]*)"))?') {
        $state.Posh = $true
        $state.PoshConfig = @($Matches[1], $Matches[2]) | Where-Object { $_ } | Select-Object -First 1
    }
    $state
}

# Pregunta solo por lo que el perfil aun no tiene.
function Complete-ProfileState($State) {
    $own = @(
        if ($State.OwnPosh) { 'Oh My Posh' }
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

    if (-not (Test-Tool 'oh-my-posh')) {
        if (-not ($State.Posh -or $State.OwnPosh)) { Write-Warn 'Oh My Posh no esta instalado; no se agrega al perfil.' }
        return
    }
    if ($State.Posh) {
        Update-PoshTheme $State
    } elseif (-not $State.OwnPosh -and (Confirm-Choice 'Agregar Oh My Posh al perfil?' $true)) {
        $config = if ($script:PoshChoice) { $script:PoshChoice } else { Get-PoshThemeChoice $Theme }
        if ($config) {
            $State.Posh = $true
            $State.PoshConfig = $config
        }
    }
    if (-not $State.Posh) { return }

    # Tema exportado que ya no existe.
    $path = Resolve-PoshConfigPath $State.PoshConfig
    if ($path -and $path -ne $PoshOverlayFile -and -not (Test-Path -LiteralPath $path)) {
        $name = [IO.Path]::GetFileName($path) -replace '\.omp\.(json|ya?ml|toml)$', ''
        Write-Warn "El tema local '$path' no existe."
        if (Confirm-Choice "Exportar el tema '$name' a esa ruta?" $true) {
            Invoke-Change "Exportar tema '$name' a $path" { Export-PoshTheme $name $path }
        }
    }
    Update-PoshSegments $State
}

function New-ProfileBlock($State, [bool]$Legacy) {
    if ($State.TerminalIcons) { 'Import-Module Terminal-Icons' }
    if ($State.ListView) { if ($Legacy) { $ListViewGuarded } else { $ListViewLine } }
    if ($State.MenuComplete) { $MenuCompleteLine }
    if ($State.Zoxide) { "Invoke-Expression (& { (zoxide init powershell$(if ($State.ZoxideCd) { ' --cmd cd' }) | Out-String) })" }
    if ($State.Eza) {
        'Remove-Item Alias:ls -Force -ErrorAction Ignore'
        'function ls { eza --icons @args }'
        foreach ($name in $EzaShortcuts.Keys) {
            if ($State.OwnShortcuts -notcontains $name) { "function $name { $($EzaShortcuts[$name]) }" }
        }
    }
    if ($State.Posh) {
        $config = if ($State.PoshConfig) { ' --config ' + (Format-PoshConfig $State.PoshConfig) } else { '' }
        "oh-my-posh init pwsh$config | Invoke-Expression"
    }
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
        if ((Test-Path -LiteralPath $allHosts) -and (Read-TextFile $allHosts) -match 'oh-my-posh') {
            Write-Warn "$allHosts tambien inicializa Oh My Posh; revisalo para evitar duplicados."
        }

        $state = Read-ProfileState $original
        Complete-ProfileState $state
        $block = @(New-ProfileBlock $state $shell.Legacy)
        $content = New-ProfileContent $state $block
        if ($content -eq ($original -replace '\r?\n', "`r`n")) {
            Write-Info 'El perfil ya esta actualizado.'
        } else {
            Write-Info 'Bloque gestionado:'
            foreach ($line in $block) { Write-Host "      $line" -ForegroundColor DarkGray }
            if (Confirm-Choice 'Guardar el perfil?' $true) {
                Invoke-Change "$(if ($exists) { 'Actualizar' } else { 'Crear' }) perfil de $($shell.Name)" {
                    Backup-File $profilePath
                    Write-TextFile $profilePath $content $true
                }
            }
        }

        Update-ShellModules $shell $state
    }
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
    try { $script:Ansi = [bool]$Host.UI.SupportsVirtualTerminal } catch { $script:Ansi = $false }
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    # Con la sesion de Oh My Posh heredada de la terminal, 'oh-my-posh print' ignora --config.
    Remove-Item Env:POSH_SESSION_ID -ErrorAction SilentlyContinue

    Write-Step "Configuracion de Windows Terminal y PowerShell $($PSVersionTable.PSVersion)"
    if ($DryRun) { Write-Warn 'Modo simulacion: no se instalara ni modificara nada.' }

    if (-not $SkipInstall) { Install-Tools }
    Update-SessionPath
    Switch-ToPwsh

    try {
        $shells = @(Get-Shells)
        Set-ScriptPolicy $shells
        Install-NerdFont
        Update-TerminalSettings
        Update-Profiles $shells
        Show-Summary
    } finally {
        if ($script:ThemeDir) { Remove-Item -LiteralPath $script:ThemeDir -Recurse -Force -ErrorAction SilentlyContinue }
    }
}

# Permite cargar las funciones con ". .\personalizar-terminal.ps1" sin ejecutar nada.
if ($MyInvocation.InvocationName -ne '.') { Main }
