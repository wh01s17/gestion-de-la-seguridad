---
title: "Instalación de Snort 3 en Debian y Arch Linux"
tags:
  - nota
  - course
  - curso
  - ids
  - snort
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "05"
author: Jordy
created_at: 2026-09-06
aliases:
  - "Instalación de Snort 3 - Lección 05"
---
# Instalación de Snort 3 en Debian y Arch Linux

La VM `SENSOR-LAB` entregada para la actividad **ya incluye Snort 3**. Usa esta guía solo si quieres instalarlo en un equipo propio o reconstruir un laboratorio.

Necesitas conexión a Internet, una cuenta con `sudo` y al menos 4 GB libres. Los comandos instalan Snort en modo IDS; capturar tráfico real requiere autorización.

Estos pasos descargan el código vigente y son adecuados para aprendizaje. En producción se utiliza una versión estable identificada, se verifican sus hashes y se prueba cada actualización antes de desplegarla.

## Índice

- [Elegir el procedimiento](#elegir-el-procedimiento)
- [Opción A: Debian 13](#opción-a-debian-13)
  - [Instalar dependencias](#1-instalar-dependencias)
  - [Compilar e instalar LibDAQ](#2-compilar-e-instalar-libdaq)
  - [Compilar e instalar Snort 3](#3-compilar-e-instalar-snort-3)
  - [Verificar Debian](#4-verificar-debian)
- [Opción B: Arch Linux y derivados](#opción-b-arch-linux-y-derivados)
  - [Preparar AUR](#1-preparar-aur)
  - [Verificar Arch](#2-verificar-arch)
- [Ajuste para reproducir la Lección 05](#ajuste-para-reproducir-la-lección-05)
- [Problemas frecuentes](#problemas-frecuentes)
- [Fuentes oficiales](#fuentes-oficiales)

## Elegir el procedimiento

| Sistema    | Procedimiento recomendado                                  | Configuración habitual           |
| ---------- | ---------------------------------------------------------- | -------------------------------- |
| Debian 13  | Compilar Snort 3 y LibDAQ desde sus repositorios oficiales | `/usr/local/etc/snort/snort.lua` |
| Arch y derivados | Instalar el paquete `snort` desde AUR                 | `/etc/snort/snort.lua`           |

Debian 13 no ofrece Snort 3 en sus repositorios oficiales. En Arch, `snort` pertenece a AUR y no a los repositorios oficiales: revisa siempre el `PKGBUILD` antes de instalarlo.

## Opción A: Debian 13

### 1. Instalar dependencias

```bash
# Actualiza el índice de paquetes
sudo apt update

# Instala las herramientas y bibliotecas necesarias para compilar
sudo apt install -y build-essential cmake git pkg-config \
  libpcap-dev libpcre2-dev libdumbnet-dev libluajit-5.1-dev \
  libssl-dev libhwloc-dev zlib1g-dev liblzma-dev \
  flex bison autoconf libtool automake uuid-dev tshark
```

Si TShark pregunta si los usuarios sin privilegios pueden capturar paquetes, responde **No**: este laboratorio solo lee capturas guardadas. Si `apt` informa un error, corrígelo antes de continuar.

### 2. Compilar e instalar LibDAQ

LibDAQ permite que Snort lea capturas y reciba paquetes desde una interfaz.

```bash
# Crea una carpeta para el código fuente
mkdir -p ~/src
cd ~/src

# Descarga LibDAQ desde el repositorio oficial
git clone https://github.com/snort3/libdaq.git
cd libdaq

# Prepara, compila e instala en /usr/local
./bootstrap
./configure --prefix=/usr/local
make -j "$(nproc)"
sudo make install

# Registra la ruta de las bibliotecas instaladas
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/snort.conf
sudo ldconfig
```

Las líneas que comienzan con `warning` son advertencias. Detente solamente si aparece `error`, `failed` o el comando termina sin devolverte el prompt.

### 3. Compilar e instalar Snort 3

```bash
cd ~/src

# Descarga Snort 3 desde el repositorio oficial
git clone https://github.com/snort3/snort3.git
cd snort3

# Genera el proyecto de compilación
./configure_cmake.sh --prefix=/usr/local

# Compila e instala
cd build
make -j "$(nproc)"
sudo make install
sudo ldconfig
```

La compilación puede tardar varios minutos y mostrar muchas líneas. No cierres la terminal mientras `make` siga ejecutándose.

### 4. Verificar Debian

```bash
# Debe mostrar una versión 3.x
snort -V

# Debe enumerar módulos como pcap o afpacket
snort --daq-list

# Debe confirmar que la configuración es válida
snort -c /usr/local/etc/snort/snort.lua -T

# Debe mostrar la versión de TShark
tshark --version | head -n 1
```

Continúa solamente si los cuatro comandos terminan sin errores.

## Opción B: Arch Linux y derivados

### 1. Preparar AUR

```bash
# Actualiza el sistema e instala las herramientas de compilación y TShark
sudo pacman -Syu --needed base-devel git wireshark-cli

# Descarga el paquete de AUR
mkdir -p ~/aur
cd ~/aur
git clone https://aur.archlinux.org/snort.git
cd snort

# Revisa las instrucciones antes de ejecutarlas
less PKGBUILD

# Compila el paquete y lo instala con pacman
makepkg -si
```

Sal de `less` con `q`. No ejecutes `makepkg` con `sudo`.

Si ya utilizas un asistente de AUR confiable, el equivalente es:

```bash
# Descarga, compila e instala el paquete de AUR
yay -S snort
```

### 2. Verificar Arch

```bash
# Debe mostrar una versión 3.x
snort -V

# Debe enumerar los módulos DAQ disponibles
snort --daq-list

# Valida la configuración instalada por el paquete
sudo snort -c /etc/snort/snort.lua -T

# Debe mostrar la versión de TShark
tshark --version | head -n 1
```

Si el paquete de AUR presenta un problema, puedes compilar desde el código fuente. Instala primero estas dependencias y luego sigue los bloques **Compilar e instalar LibDAQ** y **Compilar e instalar Snort 3** de la opción Debian:

```bash
sudo pacman -Syu --needed base-devel cmake git pkgconf \
  libpcap pcre2 libdnet luajit hwloc openssl zlib xz \
  flex bison autoconf automake libtool wireshark-cli
```

La instalación compilada utiliza `/usr/local/etc/snort/snort.lua`, igual que Debian.

## Ajuste para reproducir la Lección 05

Una instalación general de Snort no necesita este cambio. Úsalo únicamente para reproducir la actividad, cuya regla inicial busca `LOGIN` en solicitudes y respuestas HTTP mediante un `content` simplificado.

En Debian o en una instalación compilada:

```bash
SNORT_CONFIG_L05=/usr/local/etc/snort/snort.lua
```

En Arch instalado desde AUR:

```bash
SNORT_CONFIG_L05=/etc/snort/snort.lua
```

Respalda y abre la configuración elegida:

```bash
sudo cp "$SNORT_CONFIG_L05" "$SNORT_CONFIG_L05.bak"
sudo nano "$SNORT_CONFIG_L05"
```

En la sección `5. configure detection`, antes de `references = default_references`, agrega:

```lua
-- Necesario para las reglas simplificadas de la Lección 05
search_engine =
{
    detect_raw_tcp = true
}
```

Guarda con `Ctrl+O`, confirma con `Enter` y sal con `Ctrl+X`. Luego valida:

```bash
snort -c "$SNORT_CONFIG_L05" -T
```

La salida debe incluir `search_engine` y terminar con `0 warnings`. En esta actividad, la regla inicial debe generar P3 y P4. En producción se prefieren búferes específicos del protocolo por precisión y rendimiento.

## Problemas frecuentes

| Mensaje | Qué revisar |
| --- | --- |
| `snort: command not found` | Prueba `/usr/local/bin/snort -V`. Si funciona, abre una terminal nueva. |
| `No available DAQ modules` | Ejecuta `sudo ldconfig` y revisa `snort --daq-dir /usr/local/lib/daq --daq-list`. |
| No encuentra `snort.lua` | Usa la ruta correspondiente a tu método de instalación. |
| Error durante `configure_cmake.sh` | Lee las últimas líneas: normalmente indican una dependencia ausente. |
| La validación termina con `FATAL` | No ejecutes Snort todavía; corrige primero la configuración indicada. |

## Fuentes oficiales

- [Instalación oficial de Snort 3](https://docs.snort.org/start/installation)
- [Código fuente de Snort 3](https://github.com/snort3/snort3)
- [Código fuente de LibDAQ](https://github.com/snort3/libdaq)
- [Búfer `pkt_data` y `detect_raw_tcp`](https://docs.snort.org/rules/options/payload/pkt_data)
- [Paquete `snort` indicado por ArchWiki](https://wiki.archlinux.org/title/Snort)
- [Búsqueda de paquetes de Debian](https://packages.debian.org/search?keywords=snort)
