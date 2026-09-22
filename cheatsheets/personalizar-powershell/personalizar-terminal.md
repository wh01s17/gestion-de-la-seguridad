# Configurar Terminal de Windows

## Instalación

- **Terminal** -> Microsoft Store
- **PowerShell** -> https://github.com/PowerShell/PowerShell/releases
- **Oh-My-Posh**:

```powershell
winget install JanDeDobbeleer.OhMyPosh --source winget --scope user --force
```

## Combinación de colores

1. Configuración > Combinaciones de colores > Abrir archivo JSON
2. Agregar dentro del arreglo `schemes`: https://github.com/Richienb/windows-terminal-snazzy/blob/main/snazzy.json
3. Guardamos y seleccionamos **Snazzy**
4. Establecer como predeterminado
5. Guardar

## Seleccionar fuente

1. Iniciar terminal como administrador
2. Ejecutar el comando:

```powershell
oh-my-posh font install
```

3. Seleccionar e instalar fuente (recomendada **FiraCode**)
4. Iniciar terminal como usuario y seleccionar la fuente en:
    - Configuración > Valores predeterminados > Tipo de fuente

## Activar transparencia en pestañas con Acrylic effect

- Configuración > Apariencia > Usar material acrílico en la fila de tabulación

## Transparencia de terminal

- Configuración > Valores predeterminados > Apariencia > Opacidad del fondo (recomendada **95%**)

## Seleccionar tema Oh-My-Posh

1. Buscamos el tema en https://ohmyposh.dev/docs/themes
2. Lo activamos con:

```powershell
oh-my-posh init pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/pure.omp.json" | Invoke-Expression
```

3. Creamos el archivo de configuración de nuestro perfil:

```powershell
New-Item -Path $PROFILE -Type File -Force
```

4. Lo abrimos con:

```powershell
notepad $PROFILE
```

5. Agregamos la línea:

```powershell
oh-my-posh init pwsh --config 'url_theme' | Invoke-Expression
```

6. Guardamos y cerramos

## Agregar iconos en comando ls

1. Instalamos los iconos:

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery
```

2. Abrimos el archivo de configuración:

```powershell
notepad $PROFILE
```

3. Agregamos la línea:

```powershell
Import-Module Terminal-Icons
```

4. Guardamos y cerramos

## Ver listado con historial de comandos que coincida con el input

1. Abrimos el archivo de configuración:

```powershell
notepad $PROFILE
```

2. Agregamos la línea:

```powershell
Set-PSReadLineOption -PredictionViewStyle ListView
```

3. Guardamos y cerramos

## Instalar y configurar zoxide

Instalación:

```powershell
winget install ajeetdsouza.zoxide
```

Agregar estas líneas en `$PROFILE`:

```powershell
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Remove-Item Alias:cd -Force -ErrorAction Ignore
Set-Alias cd z
```

## Instalar y configurar eza

Instalación:

```powershell
winget install eza-community.eza
```

Agregar estas líneas en `$PROFILE`:

```powershell
Remove-Item Alias:ls -Force -ErrorAction Ignore
Set-Alias ls eza
```
