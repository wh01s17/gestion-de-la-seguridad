# Configurar Terminal de Windows

## Instalación automática

El script [`personalizar-terminal.ps1`](personalizar-terminal.ps1) aplica todo lo de esta guía de forma interactiva, preguntando en cada sección:

```powershell
powershell -ExecutionPolicy Bypass -File .\personalizar-terminal.ps1
```

- Solo pregunta por lo que falta; lo que ya está configurado (tema, fuente, colores, alias propios) se mantiene.
- Avisa si Oh My Posh está desactualizado y ofrece actualizarlo (incluida la reinstalación que pide winget cuando cambia el tipo de instalador).
- Para elegir el tema muestra una galería paginada con el nombre y un ejemplo del prompt de cada tema; se puede buscar escribiendo parte del nombre.
- Ofrece mostrar el venv de Python y la versión de Node.js con cualquier tema (ver [esta sección](#mostrar-el-venv-de-python-y-la-versión-de-nodejs-en-cualquier-tema)).
- Deja la configuración gestionada en un bloque marcado al final del perfil (`# >>> post-install-linux ... >>>`); se puede ejecutar varias veces sin duplicar nada.
- Las líneas propias del perfil no se modifican: si ya configuran algo (por ejemplo, `oh-my-posh`, `zoxide` o un alias de `ls`), el script lo respeta y no lo agrega al bloque. Para que lo gestione el script, borra esas líneas antes de ejecutarlo.
- Respalda cada archivo antes de modificarlo (`<archivo>.bak-<fecha>`).
- Opciones: `-DryRun` (muestra lo que haría sin cambiar nada), `-Yes` (usa la respuesta por defecto en cada pregunta), `-Theme <nombre>` (tema propuesto, por defecto `pure`), `-SkipInstall` (no usa winget).

Las secciones siguientes explican cada paso para hacerlo a mano.

## Instalación

- **Terminal** -> Microsoft Store
- **PowerShell** -> https://github.com/PowerShell/PowerShell/releases
- **Oh-My-Posh**:

```powershell
winget install JanDeDobbeleer.OhMyPosh --source winget
```

Para actualizarlo más adelante, ver [Actualizar Oh My Posh](#actualizar-oh-my-posh).

## Actualizar Oh My Posh

1. Revisar la versión instalada y compararla con la última publicada en https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest:

```powershell
oh-my-posh version
```

2. Actualizar con winget (el mismo método con el que se instaló):

```powershell
winget upgrade JanDeDobbeleer.OhMyPosh --source winget
```

También se puede usar el comando propio de Oh My Posh:

```powershell
oh-my-posh upgrade
```

3. Cerrar y volver a abrir la terminal, y confirmar la versión nueva con `oh-my-posh version`.

Si `winget upgrade` responde que *la tecnología de instalación es diferente de la versión actual instalada*, Oh My Posh se instaló con el instalador clásico y la versión nueva de winget es un paquete MSIX. En ese caso hay que desinstalar e instalar de nuevo (los perfiles y los temas guardados en la carpeta de usuario no se modifican):

```powershell
winget uninstall --id JanDeDobbeleer.OhMyPosh --exact --source winget
winget install --id JanDeDobbeleer.OhMyPosh --exact --source winget
```

> La actualización automática de Oh My Posh nunca salta de versión mayor (por ejemplo, de 27.x a 31.x) para evitar cambios incompatibles; esas actualizaciones hay que hacerlas a mano con los comandos anteriores.

> Conviene mantenerlo al día: los temas y la documentación actuales usan la clave `options` en los segmentos, mientras que versiones antiguas (como la 27.x) solo entienden `properties` e ignoran `options` sin mostrar error. Si un tema copiado de la documentación no aplica sus opciones (estilos, formatos, etc.), lo más probable es que Oh My Posh esté desactualizado.

## Combinación de colores

1. Configuración > Combinaciones de colores > Abrir archivo JSON
2. Agregar dentro del arreglo `schemes`: https://github.com/Richienb/windows-terminal-snazzy/blob/main/snazzy.json
3. Guardamos y seleccionamos **Snazzy**
4. Establecer como predeterminado
5. Guardar

## Seleccionar fuente

1. Instalar la fuente (recomendada **Meslo**) sin permisos de administrador; queda instalada para el usuario actual:

```powershell
oh-my-posh font install meslo
```

> Ejecutar `oh-my-posh font install` sin argumentos muestra un selector con todas las Nerd Fonts disponibles.
> Como administrador, la fuente se instala para todo el sistema.

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

> Con **PowerShell 7** normalmente no es necesario: en Windows ya viene con `RemoteSigned` por defecto. Se necesita en **Windows PowerShell 5.1**, cuya política por defecto es `Restricted` (ver la sección siguiente). Si la política la fija una directiva de grupo (por ejemplo, en un equipo de trabajo), este comando no podrá cambiarla; en ese caso usar la opción `--eval` descrita en [Seleccionar tema Oh-My-Posh](#seleccionar-tema-oh-my-posh).

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
- **Oh My Posh, zoxide y eza** funcionan igual en 5.1 con las mismas líneas de esta guía.

## Seleccionar tema Oh-My-Posh

1. Buscamos el tema en https://ohmyposh.dev/docs/themes
2. Agregamos la línea en `$PROFILE`, usando el nombre del tema (se descarga automáticamente y queda en caché):

```powershell
oh-my-posh init pwsh --config 'pure' | Invoke-Expression
```

> Esta línea debe ser la **última** del perfil.

3. Guardamos y recargamos con `. $PROFILE`

`--config` también acepta una URL remota o la ruta a un archivo local. Para personalizar el tema o usarlo sin conexión, lo exportamos a un archivo local:

```powershell
oh-my-posh config export --config 'pure' --output "$HOME\pure.omp.json"
```

Y en `$PROFILE` apuntamos a ese archivo:

```powershell
oh-my-posh init pwsh --config "$HOME\pure.omp.json" | Invoke-Expression
```

> Según el instalador, `POSH_THEMES_PATH` puede no existir: la versión MSIX no incluye los temas en local ni define esa variable. Por eso conviene usar el nombre del tema en lugar de `$env:POSH_THEMES_PATH`, que funciona con cualquier instalación.

Si la política de ejecución sigue bloqueando scripts sin firmar (por ejemplo, porque no se puede cambiar con `Set-ExecutionPolicy`, ver [Crear el perfil de PowerShell](#crear-el-perfil-de-powershell)), usar `--eval` (inicia algo más lento):

```powershell
oh-my-posh init pwsh --config 'pure' --eval | Invoke-Expression
```

## Mostrar el venv de Python y la versión de Node.js en cualquier tema

En lugar de editar el tema, se crea un tema propio que lo **extiende** (`extends`) y solo agrega los segmentos. Así se puede cambiar de tema modificando una sola línea y sin perder los agregados.

1. Crear `$HOME\mi-tema.omp.json`:

```json
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "version": 4,
  "extends": "pure",
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "type": "python",
          "style": "plain",
          "foreground": "#EBCB8B",
          "template": "  {{ .Full }}{{ if .Venv }} ({{ .Venv }}){{ end }} ",
          "options": { "display_mode": "context", "fetch_virtual_env": true }
        },
        {
          "type": "node",
          "style": "plain",
          "foreground": "#8CC265",
          "template": "  {{ .Full }} ",
          "options": { "display_mode": "files" }
        }
      ]
    }
  ]
}
```

2. En `$PROFILE`, apuntar Oh My Posh a ese archivo:

```powershell
oh-my-posh init pwsh --config "$HOME\mi-tema.omp.json" | Invoke-Expression
```

3. Para cambiar de tema, cambiar solo el valor de `"extends"` (nombre del tema, URL o ruta a un archivo local).

Cómo funciona y qué tener en cuenta:

- Los segmentos se combinan con el **primer bloque izquierdo** del tema base. Si el tema ya tenía un segmento `python` o `node` en ese bloque, se reemplaza por el de aquí (no se duplica).
- **Python**: con `display_mode: context` aparece en carpetas con archivos de Python o cuando hay un venv activo; con `environment` aparece solo con un venv activo. `fetch_virtual_env: true` es necesario porque algunos temas ocultan el nombre del venv.
- **Node.js**: con `display_mode: files` aparece solo en proyectos JavaScript (`package.json`, `.nvmrc`, `node_modules`, etc.). Muestra la versión de `node` activa en el `PATH`, así que respeta la versión elegida con **nvm** (`nvm use`).
- Si el tema muestra Python o Node.js en **otro** bloque (por ejemplo, `atomic` en el lado derecho), aparecerán dos veces.
- Requiere Oh My Posh 28 o superior para la clave `options`; en versiones anteriores hay que usar `properties` (ver [Actualizar Oh My Posh](#actualizar-oh-my-posh)).

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
