---
title: "Guía de comandos Lección 04 - AAA local y firewall en Linux"
tags:
  - nota
  - course
  - curso
  - guia-de-comandos
  - aaa
  - firewall
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "04"
author: Jordy
start: 2026-08-31
end: 2026-09-01
created_at: 2026-08-28
aliases:
  - "Guía de comandos Lección 04 - AAA local y firewall en Linux"
---
# Guía de comandos Lección 04 - AAA local y firewall en Linux

## Índice

- [Para qué sirve esta guía](#para-qué-sirve-esta-guía)
- [Cómo leer los comandos](#cómo-leer-los-comandos)
- [Los comandos que vas a usar](#los-comandos-que-vas-a-usar)
- [El laboratorio](#el-laboratorio)
- [Etapa A - Comprobar el laboratorio](#etapa-a---comprobar-el-laboratorio)
- [Etapa C - Probar quién puede qué](#etapa-c---probar-quién-puede-qué)
- [Por qué soporte01 no puede tocar el firewall](#por-qué-soporte01-no-puede-tocar-el-firewall)
- [Etapa D - Aplicar el firewall](#etapa-d---aplicar-el-firewall)
- [Etapa E - Probar el firewall](#etapa-e---probar-el-firewall)
- [Etapa F - Leer los registros](#etapa-f---leer-los-registros)
- [Si algo no funciona](#si-algo-no-funciona)
- [Cómo se relacionan los controles](#cómo-se-relacionan-los-controles)

## Para qué sirve esta guía

Esta guía te explica **qué significa** cada comando y qué mirar en su salida.

No la leas de corrido. Úsala cuando quieras entender un comando o cuando algo no salga como esperabas.

Las cuentas, los grupos, las direcciones y SSH ya vienen preparados en las máquinas. Aquí solo está lo que ejecutas durante la actividad.

## Cómo leer los comandos

Algunos símbolos se repiten. No son parte del comando: le indican a la terminal qué hacer con él.

| Símbolo | Qué significa |
| --- | --- |
| `sudo` | Ejecuta la orden con permisos de administrador. |
| `\|` | Envía la salida del comando de la izquierda al de la derecha. |
| `\| grep texto` | Filtra y muestra solo las líneas que contienen ese texto. |
| `\| tail -20` | Muestra solo las últimas 20 líneas. |
| `--since -20min` | Limita la búsqueda a los últimos 20 minutos. |

## Los comandos que vas a usar

Son dieciocho en total. No hay que memorizarlos; esta tabla está para consultarla.

| Comando | Qué hace |
| --- | --- |
| `ip -br addr` | Muestra las direcciones IP de la máquina, en formato corto. |
| `ip route` | Muestra hacia dónde sabe llegar la máquina. |
| `ping -c 2 DIRECCIÓN` | Envía dos paquetes de prueba y espera respuesta. |
| `ssh usuario@DIRECCIÓN` | Abre una sesión remota en otra máquina. |
| `exit` | Cierra la sesión remota y vuelve a la máquina anterior. |
| `sudo -l` | Lista qué comandos privilegiados tiene permitidos tu cuenta. |
| `sudo systemctl status ssh --no-pager` | Muestra si el servicio SSH está funcionando. |
| `sudo ufw status` | Dice si el firewall está activo o inactivo. |
| `sudo ufw status numbered` | Lista las reglas activas, numeradas. |
| `sudo ufw status verbose` | Igual, con la política por defecto y el nivel de registro. |
| `sudo ufw default deny incoming` | Define que todo lo que entra se rechaza salvo excepción. |
| `sudo ufw default allow outgoing` | Define que lo que sale de la máquina se permite. |
| `sudo ufw allow ...` | Crea una excepción: deja pasar un tráfico concreto. |
| `sudo ufw logging low` | Registra el tráfico que el firewall bloquea. |
| `sudo ufw show added` | Muestra las reglas escritas, antes de activarlas. |
| `sudo ufw enable` | Activa el firewall. |
| `sudo journalctl -u ssh` | Muestra los registros del servicio SSH. |
| `sudo journalctl -k` | Muestra los registros del núcleo, donde el firewall anota los bloqueos. |

## El laboratorio

```text
CLIENTE-LAB                         SERVIDOR-LAB
10.10.10.10/24  ---------------->  10.10.10.20/24
red de administración              SSH + firewall

10.20.20.10/24  ---------------->  10.20.20.20/24
terminales de patio                mismo servidor

Red interna aislada | sin gateway | sin acceso a Internet
```

Una misma máquina cliente tiene dos direcciones. Según a cuál del servidor te conectes, sales desde una red o desde la otra. Eso te permite probar los dos orígenes sin necesitar una tercera máquina.

## Etapa A - Comprobar el laboratorio

### Comprobar la instantánea

No es un comando: se mira en VirtualBox, en **Instantáneas** de cada VM. Debe existir `LAB04-INICIAL`, la que creaste al instalar el laboratorio.

Es lo primero porque es lo único que no puedes improvisar después. Si aplicas una regla que te deja fuera del servidor, la instantánea es la diferencia entre volver al estado inicial en segundos y perder el laboratorio en plena evaluación.

### Ver las direcciones

```bash
ip -br addr
```

`-br` significa *brief*: una línea por interfaz. Debes ver `enp0s3` con las dos direcciones del cliente.

### Comprobar que el servidor responde

```bash
ping -c 2 10.10.10.20
```

`-c 2` envía solo dos paquetes y termina; sin esa opción `ping` sigue indefinidamente hasta que lo cortes con `Ctrl+C`.

La línea final dice cuántos paquetes volvieron. `2 received` es lo correcto.

### Comprobar el aislamiento

```bash
ip route
```

Cada línea es una red que la máquina sabe alcanzar. Deben aparecer las dos del laboratorio y **ninguna que empiece por `default`**.

Una línea `default` significa «para todo lo demás, envíalo por aquí»: es la salida a Internet. Que no exista es lo que mantiene el laboratorio aislado.

### Ver el estado inicial del firewall

```bash
sudo ufw status
```

Debe decir `Status: inactive`. Activarlo es parte de la actividad.

## Etapa C - Probar quién puede qué

### Entrar al servidor

```bash
ssh admin01@10.10.10.20
```

La primera vez aparece un aviso sobre la autenticidad del servidor y su huella digital. Es normal: tu máquina nunca había hablado con esa otra y te pide confirmar. Responde `yes`.

Ese aviso volvería a aparecer si el servidor cambiara de identidad, y entonces sí sería una señal de alerta.

### Ver los permisos de la cuenta

```bash
sudo -l
```

Lista lo que esa cuenta puede ejecutar con privilegios. Para `admin01` debe aparecer una sola línea con `/usr/sbin/ufw`.

Esa línea **es** su autorización: ni más ni menos que administrar el firewall.

### El comando denegado (AAA-03)

Como `soporte01`:

```bash
sudo ufw status verbose
```

Responde algo así:

```text
Sorry, user soporte01 is not allowed to execute
'/usr/sbin/ufw status verbose' as root on servidor-lab
```

La cuenta existe, la contraseña era correcta y aun así no puede. Eso es autorización funcionando.

### El comando permitido (AAA-02)

```bash
sudo systemctl status ssh --no-pager
```

Este sí funciona para `soporte01`. `--no-pager` hace que la salida se imprima completa en vez de abrirse en un visor que hay que cerrar con `q`.

Al final de la salida aparecen las últimas líneas de registro del servicio, donde ya se ven los accesos recientes.

## Por qué soporte01 no puede tocar el firewall

En el servidor hay un archivo de configuración que define qué puede ejecutar cada rol. No puedes abrirlo -está reservado al administrador-, pero su contenido equivale a esto:

```text
%admin-red ALL=(root) /usr/sbin/ufw
%soporte   ALL=(root) /usr/bin/systemctl status ssh --no-pager
%auditor   ALL=(root) /usr/sbin/ufw status verbose, /usr/bin/journalctl -u ssh --no-pager
```

Cada línea dice: los miembros de este grupo pueden ejecutar **exactamente** estos comandos como administrador.

Dos detalles que vale la pena mirar:

`admin-red` tiene `/usr/sbin/ufw` a secas, así que puede usar cualquier opción de `ufw`. `auditor` en cambio tiene `ufw status verbose` con su argumento incluido: puede consultar el estado y nada más. **El mismo programa, distinta autorización, según el argumento.**

`soporte` no aparece en ninguna línea con `ufw`. Por eso su intento se rechaza.

No necesitas editar este archivo durante la actividad. Está aquí para que entiendas de dónde viene cada resultado.

## Etapa D - Aplicar el firewall

### La política por defecto

```bash
sudo ufw default deny incoming
```

```bash
sudo ufw default allow outgoing
```

Estas dos definen qué pasa con el tráfico que **no** coincide con ninguna regla. Rechazar todo lo que entra y permitir lo que sale se llama **denegación por defecto**, y es el punto de partida correcto: se abre solo lo necesario, en vez de cerrar lo que se recuerde.

### Las excepciones

```bash
sudo ufw allow from 10.10.10.0/24 to any port 22 proto tcp
```

Se lee por partes:

```text
from 10.10.10.0/24   solo desde la red de administración
to any               hacia cualquier dirección de este servidor
port 22              al puerto de SSH
proto tcp            por protocolo TCP
```

```bash
sudo ufw allow 443/tcp
```

Abre el puerto del portal de carga, desde cualquier origen.

> [!IMPORTANT] Abrir un puerto no crea un servicio
> Esta regla permite que llegue tráfico al puerto 443. No instala ni inicia nada. Si nadie está escuchando ahí, la conexión igual fallará, y eso no significa que el firewall esté mal.

### El registro

```bash
sudo ufw logging low
```

`low` anota únicamente el tráfico que el firewall **rechaza**, que es lo que necesitarás en la etapa F.

Existe también `medium`, pero registra además cada conexión nueva, incluidas consultas internas del sistema cada pocos segundos. El registro se llena de líneas irrelevantes y encontrar tu bloqueo se vuelve difícil.

### Revisar antes de activar

```bash
sudo ufw show added
```

Muestra las reglas escritas **sin** aplicarlas todavía. Es tu última oportunidad de corregir un error sin consecuencias.

### Activar

```bash
sudo ufw enable
```

```bash
sudo ufw status numbered
```

La primera activa el firewall; la segunda lista las reglas con un número por línea, que sirve para referirse a ellas.

## Etapa E - Probar el firewall

### Desde el origen autorizado

```bash
ssh admin01@10.10.10.20
```

Pide contraseña de inmediato. La regla del paso anterior deja pasar este tráfico.

### Desde el origen no autorizado

```bash
ssh -o ConnectTimeout=10 admin01@10.20.20.20
```

`-o ConnectTimeout=10` limita la espera a diez segundos. Sin esa opción, SSH insistiría durante más de un minuto antes de rendirse.

Se queda esperando y termina con un error de tiempo agotado. Es la misma cuenta y la misma contraseña: lo único que cambió es el origen.

> [!IMPORTANT] Una expiración no prueba que fue el firewall
> Un cable suelto, una ruta mal configurada o un servicio caído producen el mismo síntoma. Para afirmar que fue el firewall necesitas su registro, y eso es la etapa F.

## Etapa F - Leer los registros

### Los accesos por SSH

```bash
sudo journalctl -u ssh --since -20min | tail -20
```

`-u ssh` selecciona los registros de ese servicio. Busca líneas como:

```text
Accepted password for admin01 from 10.10.10.10 port 59412 ssh2
```

Ahí tienes **quién** entró, **desde dónde** y **cuándo**. Un intento fallido aparecería como `Failed password`.

### El bloqueo del firewall

```bash
sudo journalctl -k --since -20min | grep BLOCK | tail -5
```

`-k` selecciona los registros del núcleo, que es donde el firewall anota. Busca:

```text
[UFW BLOCK] IN=enp0s3 SRC=10.20.20.10 DST=10.20.20.20 PROTO=TCP DPT=22
```

`SRC` es el origen rechazado, `DPT` el puerto de destino. **Esta línea es la que convierte «se me quedó colgado» en «el firewall lo bloqueó».**

Se repite varias veces porque SSH reintenta antes de rendirse.

## Si algo no funciona

| Síntoma | Qué revisar |
| --- | --- |
| `ping` no responde | Que ambas VMs estén encendidas y en la misma red interna. |
| Aparece una línea `default` en `ip route` | La VM tiene salida a Internet; avisa al docente. |
| `ssh` dice `Connection refused` | El servicio SSH no está corriendo en el servidor. |
| `ssh` se queda colgado hacia `10.10.10.20` | Revisa la regla del paso 12: puede estar mal escrita la red de origen. |
| `sudo` responde `not allowed to execute` | Es el resultado esperado si estás como `soporte01`. Si te pasa como `admin01`, avisa. |
| No aparece ninguna línea `BLOCK` | Comprueba que `ufw logging low` se ejecutó y repite la prueba FW-02. |
| Te quedaste fuera del servidor | Usa la consola de VirtualBox, no SSH. Si no puedes entrar, restaura la instantánea. |

## Cómo se relacionan los controles

```text
identidad     ¿quién eres?          → cuenta individual y contraseña
autenticación ¿lo demuestras?       → SSH acepta o rechaza
autorización  ¿qué puedes hacer?    → sudo permite o deniega
filtrado      ¿desde dónde?         → el firewall deja pasar o bloquea
accounting    ¿qué quedó anotado?   → los registros
```

Los cuatro primeros son controles; el quinto es lo que permite demostrar que los otros funcionaron. Sin registros no puedes afirmar nada: solo suponerlo.
