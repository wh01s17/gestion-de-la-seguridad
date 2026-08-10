# Cheatsheet de Comandos Linux

## Índice

1. [Navegación básica y archivos](#1-navegación-básica-y-archivos)
2. [Usuario, sesión y entorno](#2-usuario-sesión-y-entorno)
3. [Ejecución y control básico](#3-ejecución-y-control-básico)
4. [Redirecciones y tuberías](#4-redirecciones-y-tuberías)
5. [Compresión y descompresión](#5-compresión-y-descompresión)
6. [Búsqueda y filtrado](#6-búsqueda-y-filtrado)
7. [Monitorización y procesos](#7-monitorización-y-procesos)
8. [Gestión de usuarios y grupos](#8-gestión-de-usuarios-y-grupos)
9. [Permisos y atributos](#9-permisos-y-atributos)
10. [Sistema de archivos y estructura](#10-sistema-de-archivos-y-estructura)
11. [Particionado de discos y RAID](#11-particionado-de-discos-y-raid)
12. [Capabilities (avanzado)](#12-capabilities-avanzado)

---

## 1. Navegación básica y archivos

### Navegación

```bash
pwd -> Muestra la ruta absoluta del directorio actual.

cd -> Cambia al directorio indicado.

cd .. -> Sube un nivel en la estructura de directorios.

ls -> Lista los archivos y carpetas del directorio actual.

mkdir -> Crea un nuevo directorio.

touch -> Crea un archivo vacío o actualiza su fecha de modificación.
```

### Manipulación de archivos

```bash
echo -> Muestra un texto o variable en la salida estándar.

cat -> Muestra el contenido de un archivo.

mv -> Mueve o renombra archivos o carpetas.

rm -> Elimina archivos o carpetas.

cp -> Copia archivos o carpetas.

which -> Indica la ubicación de un comando en el sistema.

wc -> Muestra el número de líneas, palabras y caracteres de un archivo o entrada de texto.

less -> Visualiza archivos de texto de forma paginada, permitiendo desplazamiento y búsqueda.

file -> Determina el tipo real de un archivo según su contenido.

stat -> Muestra información detallada de un archivo o directorio: permisos, inodos, tiempos y tamaño.

```

---

## 2. Usuario, sesión y entorno

```bash
whoami -> Muestra el usuario actual.

id -> Muestra el UID, GID y grupos del usuario.

sudo -> Ejecuta un comando con privilegios de superusuario.

su -> Cambia a otro usuario (por defecto, root).

exit -> Cierra la sesión o shell actual.
```

### Exploración, historial y entorno

```bash
man -> Muestra el manual de un comando.

history -> Muestra el historial de comandos ejecutados.

printenv -> Lista las variables de entorno.

echo $PATH -> Muestra las rutas donde el sistema busca ejecutables.
```

---

## 3. Ejecución y control básico

```bash
./ -> Ejecuta un archivo o script en el directorio actual.

sh -> Ejecuta un script con la shell.

echo $? -> Muestra el código de salida del último comando.

Ctrl + L -> Limpia la pantalla de la terminal.
```

### Procesos en segundo plano

```bash
& (al final) -> Ejecuta un comando en segundo plano.

disown -> Desasocia un proceso de la terminal para que siga ejecutándose.
```

---

## 4. Redirecciones y tuberías

```bash
| -> Envía la salida de un comando como entrada a otro.

; -> Ejecuta varios comandos en secuencia.

&& -> Ejecuta el segundo comando solo si el primero tuvo éxito.

|| -> Ejecuta el segundo comando solo si el primero falló.

> -> Redirige la salida estándar a un archivo (sobrescribe).

>> -> Redirige la salida estándar a un archivo (añade).

2> -> Redirige los errores a un archivo.

&> -> Redirige salida y errores a un archivo.

stdin (<) -> Entrada estándar desde un archivo.

stdout (>) -> Salida estándar a un archivo.

stderr (2>) -> Errores estándar a un archivo.
```

---

## 5. Compresión y descompresión

### Compresión

```bash
7z a archivo_comprimido.7z archivo.txt -> Comprime un archivo con 7-Zip.

zip archivo.zip archivo.txt -> Comprime un archivo en formato ZIP.

zip -r directorio.zip directorio/ -> Comprime un directorio en formato ZIP.

tar -czf archivo.tar.gz archivo.txt -> Comprime con tar y gzip.
```

### Descompresión

```bash
7z x archivo_comprimido.7z -> Extrae un archivo 7-Zip.

unzip archivo.zip -> Extrae un archivo ZIP.

tar -xzf archivo.tar.gz -> Extrae un archivo .tar.gz.
```

---

## 6. Búsqueda y filtrado

### Búsquedas con find

```bash
find / -name "archivo"
    Busca archivos o directorios llamados exactamente "archivo" comenzando desde la raíz /.

find / -type f
    Busca solo archivos regulares (f de file).

find / -type d
    Busca solo directorios (d de directory).

find / -perm -4000
    Busca archivos con el bit SUID activado (permiso especial 4000).

find / -perm -2000
    Busca archivos con el bit SGID activado (permiso especial 2000).

find / -group "grupo"
    Busca archivos pertenecientes al grupo "grupo".

find / -user root -writable
    Busca archivos propiedad del usuario root y que sean escribibles.

find / -executable
    Busca archivos que tengan permiso de ejecución.

find / -name "dex*"
    Busca archivos o directorios cuyo nombre comience con "dex".

find / -name "vuln*"
    Busca archivos o directorios cuyo nombre comience con "vuln".
```

### Filtrado de contenido

```bash
grep -> Busca patrones o texto específico dentro de archivos o entrada estándar.

xargs -> Construye y ejecuta comandos a partir de la salida de otro comando, útil para procesar listas.

wc -> Cuenta líneas, palabras y caracteres de archivos o entrada estándar.

head -> Muestra las primeras líneas de un archivo o de la salida estándar.

tail -> Muestra las últimas líneas de un archivo o de la salida estándar.

tail -f -> Muestra las últimas líneas de un archivo y las actualiza en tiempo real (útil para logs).

```

---

## 7. Monitorización y procesos

```bash
ps aux
    Muestra todos los procesos en ejecución con detalles como usuario, CPU y memoria usada.

top
    Monitor en tiempo real de procesos activos y uso de recursos del sistema.

htop
    Versión mejorada y visual de top, con interfaz interactiva para manejar procesos.

kill
    Envía señales a un proceso específico para detenerlo o controlarlo, usando su PID.

killall
    Envía señales a todos los procesos que coincidan con un nombre dado.

du -> Muestra el uso de espacio en disco de archivos y directorios.

df -> Muestra el espacio libre y usado en los sistemas de archivos montados.

kill -SIGTERM -> Envía una señal de terminación limpia a un proceso.

kill -SIGKILL -> Finaliza un proceso de forma forzada (no capturable).

```

### Señales

```bash
SIGTERM (15) -> Solicita la terminación limpia de un proceso. El proceso puede capturarla y cerrar correctamente. (señal por defecto de kill)

SIGINT (2) -> Interrupción enviada normalmente desde el teclado (Ctrl + C). Permite limpieza controlada.

SIGQUIT (3) -> Termina el proceso y genera un core dump para depuración.

SIGKILL (9) -> Finaliza el proceso de forma inmediata y forzada. No puede ser capturada ni ignorada.

SIGSTOP (19) -> Detiene (pausa) un proceso. No puede ser capturada ni ignorada.

SIGTSTP (20) -> Suspende un proceso (Ctrl + Z). Puede ser capturada.

SIGCONT (18) -> Reanuda un proceso detenido o suspendido.

SIGHUP (1) -> Señala que la sesión o terminal fue cerrada; común para recargar configuraciones.

SIGUSR1 (10) -> Señal definida por el usuario (uso personalizado por aplicaciones).

SIGUSR2 (12) -> Segunda señal definida por el usuario.

SIGALRM (14) -> Señal enviada cuando expira un temporizador configurado.

SIGPIPE (13) -> Proceso intenta escribir en un pipe sin lector.

SIGCHLD (17) -> Enviada a un proceso padre cuando un hijo termina o cambia de estado.

```

---

## 8. Gestión de usuarios y grupos

```bash
useradd -> Crea un nuevo usuario en el sistema.

passwd -> Cambia o asigna la contraseña de un usuario.

usermod -> Modifica la configuración de un usuario existente.

userdel -> Elimina un usuario del sistema.

groupadd -> Crea un nuevo grupo.
```

---

## 9. Permisos y atributos

### Notación simbólica

```bash
# Usuarios/roles

u → usuario/propietario** (owner)

g → grupo del archivo

o → otros (anyone else)

a → todos (u+g+o)

# Operadores
= → asigna exactamente los permisos indicados (reemplaza los existentes)

+ → agrega permisos sin quitar los existentes

- → quita permisos sin afectar los demás

# Permisos

r → lectura (read)

w → escritura (write)

x → ejecución (execute)

X → ejecución solo si el archivo es directorio o ya tiene permiso de ejecución para algún usuario

s → SUID/SGID (setuid/setgid)

t → sticky bit (impide que otros borren archivos en un directorio compartido)

# Ejemplos de uso
chmod u=rwx,g=rx,o=rx archivo.txt    # asigna permisos exactos
chmod u+x archivo.txt                # agrega permiso de ejecución al propietario
chmod g-w archivo.txt                # quita permiso de escritura al grupo
chmod a+r archivo.txt                # da permiso de lectura a todos
chmod u+s archivo.txt                # aplica SUID al archivo
chmod g+s directorio                 # aplica SGID al directorio
chmod +t directorio                  # aplica sticky bit al directorio
```

### Notación octal

```bash
ej: 755

    rwx rwx rwx
    421 421 421
    111 101 101
     7   5   5

ej: 251

    rwx rwx rwx
    421 421 421
    010 101 001
     2   5   1

  0 - - - Nada
  1 - - x Solo ejecución de archivos o acceso a directorio
  2 - w - Solo escritura
  3 - w x Escritura y ejecución/acceso
  4 r - - Solo lectura
  5 r - x Lectura y ejecución/acceso
  6 r w - Lectura y escritura
  7 r w x Lectura, escritura y ejecución/acceso
```

```bash
chmod -> Cambia los permisos de un archivo o directorio.

chown -> Cambia el propietario y/o grupo de un archivo o directorio.

chgrp -> Cambia únicamente el grupo de un archivo o directorio.

lsattr -> Lista los atributos especiales de archivos y directorios en sistemas con ext2/ext3/ext4.

chattr -> Cambia los atributos especiales de archivos y directorios en sistemas con ext2/ext3/ext4.
```

```bash
Algunos atributos especiales son:
	- a (append only) → El archivo solo se puede abrir en modo añadir; no se puede borrar ni modificar su contenido existente.

	- i (immutable) → El archivo o directorio no se puede modificar, renombrar ni eliminar.

	- A (no atime updates) → No actualiza la marca de tiempo de último acceso (atime).

	- S (synchronous updates) → Las escrituras en el archivo se realizan de forma síncrona (inmediata en disco).

	- d (no dump) → Excluye el archivo del comando dump (copias de seguridad).

	- c (compressed) → El archivo se almacena comprimido en disco (requiere soporte del FileSystem).

	- e (extent format) → Usa el formato de "extents" (habilitado por defecto en ext4).


# Atributos menos usados

	- j (data journaling) → Guarda datos en el journal de ext3/ext4 antes de escribir en el archivo.

	- t (no tail merging) → Evita que el sistema de archivos combine bloques sobrantes con otros archivos pequeños (tail packing).

	- u (undeletable) → Si se elimina, se conserva una copia recuperable.

	- E (compression error) → Indica error en compresión (solo lectura).

	- h (huge file) → Permite manejar archivos muy grandes.
```

```bash
SUID -> Permiso especial que permite ejecutar un archivo con los privilegios de su propietario.

SGID -> Permiso especial que permite ejecutar un archivo con los privilegios de su grupo o heredar grupo en directorios.

Sticky bit -> Permiso especial que impide que usuarios eliminen archivos de otros en un directorio compartido.

Notación octal -> Forma numérica de representar permisos en Linux (ej. 755, 644).
```

---

## 10. Sistema de archivos y estructura

```bash
/etc/passwd -> Contiene información básica de los usuarios.

/etc/group -> Contiene información de los grupos del sistema.

/etc/shadow -> Almacena contraseñas cifradas y políticas de contraseñas.

/etc/sudoers -> Configuración de permisos para sudo.

/home -> Directorios personales de los usuarios.

/root -> Directorio personal del usuario root.

/etc -> Archivos de configuración del sistema.

/bin -> Comandos esenciales para todos los usuarios.

/sbin -> Comandos esenciales para administración del sistema.

/usr -> Programas y datos de usuario del sistema.

/var -> Contiene archivos que varían con el tiempo: logs, bases de datos, colas de correo, cachés y archivos temporales persistentes.

/tmp -> Archivos temporales del sistema y usuarios. Se limpia al reiniciar en muchos sistemas.

/opt -> Software adicional instalado manualmente.

/media -> Puntos de montaje para dispositivos externos.

/mnt -> Punto de montaje temporal para sistemas de archivos.

/dev -> Archivos de dispositivos del sistema.

/proc -> Información y configuración del kernel y procesos.

/sys -> Información y configuración del hardware.

/boot -> Archivos de arranque del sistema, incluido el kernel.

/srv -> Sistema de archivos virtual que contiene información sobre dispositivos y controladores gestionados por el kernel.

/lost+found -> Archivos recuperados después de errores en el sistema de archivos.

/cdrom -> Punto de montaje para CDs/DVDs. No siempre existe; depende de la configuración del sistema.

/lib → /usr/lib -> Librerías esenciales compartidas necesarias para los ejecutables en `/bin` y `/sbin`. En sistemas modernos, suele apuntar a `/usr/lib`.

/lib64 → /usr/lib64 -> Librerías esenciales de 64 bits, equivalentes a `/lib` pero para arquitecturas de 64 bits.

/run -> Contiene archivos temporales de ejecución, como PID de procesos y sockets, que se crean en cada arranque.

/snap -> Contiene los paquetes instalados mediante Snap (sistema de paquetes de Canonical).
```

---

## 11. Particionado de discos y RAID

### Identificación de discos y particiones

```bash
lsblk -> Muestra dispositivos de bloques, particiones y puntos de montaje.

blkid -> Muestra UUID y tipo de sistema de archivos de los dispositivos.

fdisk -l -> Lista discos y particiones en el sistema (modo solo lectura).

mount -> Muestra los sistemas de archivos montados actualmente.

df -h -> Muestra uso de disco por sistema de archivos en formato legible.
```

### Particionado de discos

```bash
fdisk -> Herramienta interactiva para crear y modificar particiones MBR.

cfdisk -> Versión interactiva y visual de fdisk.

parted -> Herramienta avanzada para gestionar particiones GPT y grandes discos.
```

### Creación de sistemas de archivos

```bash
mkfs.ext4 -> Crea un sistema de archivos ext4 en una partición o dispositivo.

mkfs.xfs -> Crea un sistema de archivos XFS.

mkswap -> Crea un área de intercambio (swap).
```

### Montaje persistente

```bash
mount -> Monta manualmente un sistema de archivos.

umount -> Desmonta un sistema de archivos.

nano /etc/fstab -> Configura montajes automáticos al iniciar el sistema.
```

### RAID por software (mdadm)

```bash
mdadm --create -> Crea un arreglo RAID por software.

mdadm --detail -> Muestra información detallada de un arreglo RAID.

mdadm --stop -> Detiene un arreglo RAID.

mdadm --assemble -> Reconstruye un arreglo RAID existente.
```

### Niveles RAID comunes

```bash
RAID 0 -> Striping. Máximo rendimiento, sin tolerancia a fallos.

RAID 1 -> Mirroring. Redundancia total, menor capacidad usable.

RAID 5 -> Striping con paridad. Tolerancia a 1 disco fallido.

RAID 6 -> Paridad doble. Tolerancia a 2 discos fallidos.

RAID 10 -> Combinación de RAID 1 + RAID 0. Rendimiento y redundancia.
```

### Swap

```bash
swapon -> Activa particiones o archivos swap.

swapoff -> Desactiva swap.

free -h -> Muestra uso de memoria RAM y swap.
```

---

## 12. Capabilities (avanzado)

```bash
getcap -> Muestra las capacidades asignadas a un archivo ejecutable.

setcap -> Asigna o modifica capacidades a un archivo ejecutable.
```

### Listado de Capabilities

```bash
CAP_AUDIT_CONTROL → Habilitar o deshabilitar el sistema de auditoría, cambiar reglas.

CAP_AUDIT_READ → Leer los registros de auditoría vía multicast netlink socket.

CAP_AUDIT_WRITE → Escribir mensajes en el log de auditoría.

CAP_BLOCK_SUSPEND → Bloquear suspensión del sistema (inhibir sleep).

CAP_BPF → Usar programas BPF (eBPF), mapas, etc.

CAP_CHECKPOINT_RESTORE → Operaciones para restauración de procesos (CRIU).

CAP_CHOWN → Cambiar propietario de archivos.

CAP_DAC_OVERRIDE → Ignorar permisos de lectura, escritura y ejecución.

CAP_DAC_READ_SEARCH → Ignorar permisos de lectura y búsqueda en directorios.

CAP_FOWNER → Ignorar restricciones de propietario en operaciones sobre ficheros.

CAP_FSETID → Permitir mantener/setear los bits setuid/setgid en ficheros.

CAP_IPC_LOCK → Bloquear memoria (mlock, mlockall).

CAP_IPC_OWNER → Ignorar verificaciones de permisos en objetos IPC.

CAP_KILL → Matar procesos que no son propios.

CAP_LAST_CAP → Última capability reconocida (usada como referencia por el kernel).

CAP_LEASE → Crear y modificar leases de archivos.

CAP_LINUX_IMMUTABLE → Modificar flag de inmutabilidad/extensibilidad de ficheros.

CAP_MAC_ADMIN → Administrar políticas MAC (Mandatory Access Control).

CAP_MAC_OVERRIDE → Ignorar políticas MAC.

CAP_MKNOD → Crear nodos especiales de dispositivo.

CAP_NET_ADMIN → Administrar interfaces de red, routing, firewall, etc.

CAP_NET_BIND_SERVICE → Enlazar sockets a puertos privilegiados (<1024).

CAP_NET_BROADCAST → Operaciones de broadcast obsoletas (casi sin uso).

CAP_NET_RAW → Usar sockets raw (ej: ping).

CAP_PERFMON → Usar herramientas de monitoreo de rendimiento (perf).

CAP_SETGID → Cambiar GID efectivo, real o saved.

CAP_SETFCAP → Asignar capabilities a ficheros.

CAP_SETPCAP → Modificar las capabilities de procesos.

CAP_SETUID → Cambiar UID efectivo, real o saved.

CAP_SYS_ADMIN → “Cajón desastre”: casi todo lo administrativo (montar fs, namespaces, etc.).

CAP_SYS_BOOT → Permitir reboot y kexec.

CAP_SYS_CHROOT → Usar `chroot()`.

CAP_SYS_MODULE → Cargar o descargar módulos del kernel.

CAP_SYS_NICE → Cambiar prioridades de procesos, scheduling, etc.

CAP_SYS_PACCT → Configurar process accounting.

CAP_SYS_PTRACE → Trazar procesos (debuggers como gdb, strace).

CAP_SYS_RAWIO → Acceso directo a memoria y puertos de E/S.

CAP_SYS_RESOURCE → Ignorar límites de recursos (`ulimit`).

CAP_SYS_TIME → Cambiar hora del sistema.

CAP_SYS_TTY_CONFIG → Configurar consola virtual.

CAP_WAKE_ALARM → Configurar alarmas que despierten al sistema.
```
