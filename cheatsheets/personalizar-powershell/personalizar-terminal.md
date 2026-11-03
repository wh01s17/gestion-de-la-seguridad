# Configurar Terminal de Windows

## Instalación automática

El script [`personalizar-terminal.ps1`](personalizar-terminal.ps1) aplica todo lo de esta guía de forma interactiva, preguntando en cada sección:

```powershell
powershell -ExecutionPolicy Bypass -File .\personalizar-terminal.ps1
```

- Solo pregunta por lo que falta; lo que ya está configurado (fuente, colores, alias propios) se mantiene.
- Copia la configuración de Starship de [wh01s17/dotfiles](https://github.com/wh01s17/dotfiles) (la misma que en Linux, ver [Configurar Starship](#configurar-starship)); si la local es distinta, pregunta antes de reemplazarla.
- Si el perfil usa Oh My Posh, ofrece reemplazarlo por Starship y, cuando ya ningún perfil lo usa, desinstalarlo (los temas `*.omp.json` guardados no se borran).
- Deja la configuración gestionada en un bloque marcado al final del perfil (`# >>> post-install-linux ... >>>`); se puede ejecutar varias veces sin duplicar nada.
- Las líneas propias del perfil no se modifican: si ya configuran algo (por ejemplo, `starship`, `zoxide` o un alias de `ls`), el script lo respeta y no lo agrega al bloque. Para que lo gestione el script, borra esas líneas antes de ejecutarlo. La única excepción son las líneas que cargan Oh My Posh: ofrece comentarlas al pasar a Starship.
- Respalda cada archivo antes de modificarlo (`<archivo>.bak-<fecha>`).
- Opciones: `-DryRun` (muestra lo que haría sin cambiar nada), `-Yes` (usa la respuesta por defecto en cada pregunta), `-StarshipConfig <url o ruta>` (`starship.toml` que se copia, por defecto el de dotfiles), `-SkipInstall` (no usa winget).

Las secciones siguientes explican cada paso para hacerlo a mano.

## Instalación

- **Terminal** -> Microsoft Store
- **PowerShell** -> https://github.com/PowerShell/PowerShell/releases
- **Starship**:

```powershell
winget install --id Starship.Starship --exact --source winget
```

Para actualizarlo más adelante:

```powershell
winget upgrade --id Starship.Starship --exact --source winget
```

## Combinación de colores

1. Configuración > Combinaciones de colores > Abrir archivo JSON
2. Agregar dentro del arreglo `schemes`: https://github.com/Richienb/windows-terminal-snazzy/blob/main/snazzy.json
3. Guardamos y seleccionamos **Snazzy**
4. Establecer como predeterminado
5. Guardar

## Seleccionar fuente

1. Instalar la fuente (recomendada **Meslo**) sin permisos de administrador:
    - Descargar `Meslo.zip` desde https://www.nerdfonts.com/font-downloads y descomprimirlo.
    - Seleccionar los archivos `MesloLGMNerdFont-Regular.ttf`, `-Bold.ttf`, `-Italic.ttf` y `-BoldItalic.ttf`, clic derecho > **Instalar** (queda instalada para el usuario actual; **Instalar para todos los usuarios** requiere administrador).

2. Reiniciar la terminal y seleccionar **MesloLGM Nerd Font** en:
    - Configuración > Valores predeterminados > Apariencia > Tipo de fuente

O directamente en el JSON de configuración (`Ctrl + Shift + ,`):

```json
{
    "profiles": {
        "defaults": {
            "font": {
                "face": "MesloLGM Nerd Font"
            }
        }
    }
}
```

## Activar transparencia en pestañas con Acrylic effect

- Configuración > Apariencia > Usar material acrílico en la fila de tabulación

## Transparencia de terminal

- Configuración > Valores predeterminados > Apariencia > Opacidad del fondo (recomendada **95%**)

## Crear el perfil de PowerShell

Todas las secciones siguientes agregan líneas a `$PROFILE`. Si el archivo no existe, lo creamos:

```powershell
New-Item -Path $PROFILE -Type File -Force
```

Lo abrimos con:

```powershell
notepad $PROFILE
```

Después de guardar cambios, recargamos el perfil sin reiniciar la terminal:

```powershell
. $PROFILE
```

Si al abrir la terminal aparece un error indicando que la ejecución de scripts está deshabilitada, el perfil no se cargará. Para permitir scripts locales (y remotos solo si están firmados) para el usuario actual, sin permisos de administrador:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Para ver la política actual: `Get-ExecutionPolicy -List`

> Con **PowerShell 7** normalmente no es necesario: en Windows ya viene con `RemoteSigned` por defecto. Se necesita en **Windows PowerShell 5.1**, cuya política por defecto es `Restricted` (ver la sección siguiente). Si la política la fija una directiva de grupo (por ejemplo, en un equipo de trabajo), este comando no podrá cambiarla y el perfil no se cargará.

El perfil completo de referencia está en [`profile.txt`](profile.txt).

## Consideraciones si se usa Windows PowerShell 5.1

Windows incluye **Windows PowerShell 5.1** (`powershell.exe`, pestaña "Windows PowerShell" en Terminal), que es distinto de **PowerShell 7** (`pwsh.exe`, pestaña "PowerShell"). Esta guía está pensada para PowerShell 7; si se usa 5.1 hay que tener en cuenta:

- **Usar PowerShell 7 por defecto**: la forma más simple de evitar todo lo siguiente es dejar PowerShell 7 como perfil predeterminado en Configuración > Inicio > Perfil predeterminado > **PowerShell**.
- **Política de ejecución separada**: 5.1 tiene su propia política (`Restricted` por defecto), independiente de la de PowerShell 7. Hay que ejecutar `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` **desde Windows PowerShell 5.1**, aunque ya se haya hecho en PowerShell 7.
- **`$PROFILE` distinto**: cada versión carga su propio archivo, así que hay que agregar las líneas en ambos si se usan los dos:
    - PowerShell 7: `Documentos\PowerShell\Microsoft.PowerShell_profile.ps1`
    - Windows PowerShell 5.1: `Documentos\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
- **PSReadLine antiguo**: 5.1 trae PSReadLine 2.0.0, que no tiene `-PredictionViewStyle` (requiere 2.2+), por lo que `Set-PSReadLineOption -PredictionViewStyle ListView` falla al cargar el perfil. Para actualizarlo, cerrar todas las terminales de PowerShell y ejecutar desde `cmd`:

    ```cmd
    powershell -NoProfile -Command "Install-Module PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck"
    ```

    O bien, para que el mismo perfil funcione en ambas versiones sin actualizar, reemplazar la línea por:

    ```powershell
    if ((Get-Module PSReadLine).Version -ge [version]'2.2.0') { Set-PSReadLineOption -PredictionViewStyle ListView }
    ```

- **Codificación del perfil**: 5.1 lee los archivos UTF-8 sin BOM (lo que guarda Notepad por defecto) como ANSI, así que tildes o `ñ` en comentarios del perfil se verán mal. Evitarlas o guardar el archivo como "UTF-8 con BOM".
- **Starship, zoxide y eza** funcionan igual en 5.1 con las mismas líneas de esta guía.

## Configurar Starship

1. Agregar en `$PROFILE`:

```powershell
Invoke-Expression (&starship init powershell)
```

> Esta línea debe ir al final del perfil, solo antes de la de zoxide.

2. Copiar la configuración de Linux desde [wh01s17/dotfiles](https://github.com/wh01s17/dotfiles/blob/main/terminal/.config/starship.toml). En Windows, Starship la busca en `~\.config\starship.toml` (o en la ruta de `$env:STARSHIP_CONFIG`, si está definida):

```powershell
New-Item -ItemType Directory -Path "$HOME\.config" -Force | Out-Null
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/wh01s17/dotfiles/main/terminal/.config/starship.toml' -OutFile "$HOME\.config\starship.toml"
```

Para tomar los cambios del repositorio, volver a ejecutar el comando (o el script, que muestra si la copia local es distinta antes de reemplazarla).

3. Línea en blanco entre comandos: `starship.toml` usa `add_newline = false` porque en zsh esa línea la agrega un hook `precmd`, así el primer prompt queda pegado al borde superior. Para lo mismo en PowerShell, agregar antes de `starship init` (Starship ejecuta `Invoke-Starship-PreCommand` antes de cada prompt; el historial solo cambia si se ejecutó un comando, así que un Enter sin escribir nada no deja línea en blanco):

```powershell
function Invoke-Starship-PreCommand {
    $id = Get-History -Count 1 | ForEach-Object { $_.Id }
    if ($id -and $id -ne $global:StarshipLastHistoryId) { Write-Host }
    $global:StarshipLastHistoryId = $id
}
```

4. Guardar y recargar con `. $PROFILE`

Qué tener en cuenta:

- El venv de Python y la versión de Node.js aparecen solos (módulos `python` y `nodejs`), solo en carpetas con archivos de esos lenguajes o con un venv activo. `node` es el activo en el `PATH`, así que respeta la versión elegida con **nvm**.
- El módulo `sudo` no aparece en Windows (Starship lo desactiva ahí salvo con `allow_windows = true`).
- `starship explain` describe los segmentos del prompt actual y `starship timings` muestra cuánto tarda cada uno; en repositorios grandes `git_status` y `git_metrics` son los más lentos.
- Para probar otro estilo sin perder la configuración: `starship preset --list` y, por ejemplo, `starship preset tokyo-night -o "$HOME\.config\starship-tokyo.toml"`, y luego `$env:STARSHIP_CONFIG = "$HOME\.config\starship-tokyo.toml"` en la sesión.

## Ver listado con historial de comandos que coincida con el input

Agregar la línea en `$PROFILE`:

```powershell
Set-PSReadLineOption -PredictionViewStyle ListView
```

## Menú de autocompletado con Tab

Por defecto, cada `Tab` reemplaza el texto por la siguiente opción, una a la vez. Con esta línea en `$PROFILE`, `Tab` muestra todas las opciones en un menú (como en zsh) y se elige con las flechas:

```powershell
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
```

## Instalar y configurar zoxide

Instalación:

```powershell
winget install ajeetdsouza.zoxide
```

Agregar esta línea en `$PROFILE` (reemplaza `cd` por zoxide y agrega `cdi` para búsqueda interactiva; con `--cmd cd` el comando `z` ya no se define):

```powershell
Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
```

> Esta línea debe ser la **última** del perfil, después de la de Starship. zoxide registra los directorios visitados envolviendo la función `prompt`; si Starship se inicializa después, la reemplaza y zoxide deja de aprender rutas (y muestra el aviso *detected a possible configuration issue*).

## Instalar y configurar eza

Instalación:

```powershell
winget install eza-community.eza
```

Agregar estas líneas en `$PROFILE` (`Set-Alias` no admite argumentos, por eso se usa una función para agregar iconos):

```powershell
Remove-Item Alias:ls -Force -ErrorAction Ignore
function ls { eza --icons @args }
```

Accesos directos opcionales:

```powershell
function l { eza --icons @args }        # ls
function ll { eza --icons -l @args }    # ls -l
function lla { eza --icons -la @args }  # ls -la (incluye ocultos)
```

## Alternativa: iconos con Terminal-Icons

Solo si **no** se usa eza para `ls`, ya que Terminal-Icons decora la salida de `Get-ChildItem` y eza lo reemplaza.

1. Instalamos el módulo:

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
```

2. Agregamos la línea en `$PROFILE`:

```powershell
Import-Module Terminal-Icons
```
