---
title: "Guía práctica de comandos Lección 11 - Restricción SSH con UFW"
tags:
  - nota
  - course
  - curso
  - guia-comandos
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "11"
author: Jordy
start: 2026-10-20
end: 2026-10-26
created_at: 2026-10-18
aliases:
  - "Guía práctica de comandos Lección 11 - Restricción SSH con UFW"
---

# Guía práctica de comandos Lección 11 - Restricción SSH con UFW

## Objetivo y alcance

Usa esta guía para ejecutar los pasos 2 y 3 de la actividad de la lección 11. Al finalizar tendrás el estado inicial de UFW, la corrección de la regla SSH, una prueba permitida, una prueba denegada y el registro que permite atribuir el bloqueo. Esas salidas son las evidencias E1 a E6 de la actividad.

Los comandos se ejecutan solo en las copias `CLIENTE-LAB` y `SERVIDOR-LAB` importadas desde los OVA preparados por el docente, conectadas únicamente a la red interna `lab_seguridad`. No se instala nada ni se usa Internet. Las respuestas, la ficha de auditoría y las evidencias se completan únicamente en `plantilla-entrega-leccion-11.docx`; la terminal sirve para observar, corregir y probar un control.

## Usuarios y cambios de sesión

| Secciones de esta guía | Equipo y acceso | Usuario |
| --- | --- | --- |
| 1: IP, rutas y conectividad del cliente; 3, 5 y 6: iniciar pruebas SSH | Consola local de `CLIENTE-LAB` | `docente` |
| 1: IP y rutas del servidor; 2 y 4: consultar y modificar UFW | Consola local de `SERVIDOR-LAB` | `admin01` |
| 5: autenticación en la conexión SSH permitida | Sesión remota en `SERVIDOR-LAB`, iniciada desde el cliente | `admin01`; al terminar, `exit` vuelve a `docente` en el cliente. |
| 7: consultar registros del kernel | Consola local de `SERVIDOR-LAB` | `docente`; cerrar antes la sesión local de `admin01`. |

Usa las contraseñas entregadas para cada cuenta: `sudo ufw` y SSH solicitan la de `admin01` del servidor; `sudo journalctl` solicita la de `docente`. No se muestran caracteres al escribirlas. Los indicadores de terminal que se mencionan a continuación sirven para comprobar equipo y usuario; no forman parte de los comandos.

## Recorrido seguro

```text
entorno correcto -> estado inicial de UFW -> SSH alcanzable desde terminales
-> regla específica -> retirar regla amplia -> estado final
-> prueba permitida -> prueba denegada -> registro UFW BLOCK
```

## Herramientas

| Comando | Equipo | Uso en la práctica |
| --- | --- | --- |
| `ip -br addr` · `ip route` | Ambos | Confirmar direcciones y ausencia de ruta por defecto. |
| `ping -c 2` | Cliente | Comprobar conectividad básica con el servidor. |
| `sudo ufw status` | Servidor | Leer reglas y política por defecto del firewall. |
| `sudo ufw allow` · `sudo ufw delete` | Servidor | Agregar la regla específica y retirar la amplia. |
| `ssh -o ConnectTimeout=8` | Cliente | Probar el acceso permitido y el denegado. |
| `date` | Ambos | Anotar la hora de cada prueba para correlacionarla. |
| `journalctl -k` · `grep` · `tail` | Servidor | Buscar el registro del paquete bloqueado. |

## 1. Comprobar el entorno

Importa los OVA entregados por el docente. En VirtualBox, revisa que ambas VM tengan un solo adaptador de tipo **Red interna** llamado `lab_seguridad`; el estado inicial ya viene preparado en los OVA. Luego, en la consola local del cliente como **`docente`** y en la del servidor como **`admin01`**:

```bash
ip -br addr
ip route
```

En `CLIENTE-LAB`, como **`docente`** (`docente@cliente-lab:~$`), comprueba además la conectividad:

```bash
ping -c 2 10.10.10.20
ping -c 2 10.20.20.20
```

| Parte | Explicación |
| --- | --- |
| `ip -br addr` | Muestra cada interfaz con su estado y dirección en una línea (`-br`, formato breve). |
| `ip route` | Lista las rutas. No debe aparecer una línea que empiece con `default`. |
| `ping` | Envía mensajes de eco al servidor y espera respuesta. |
| `-c 2` | Envía solo dos mensajes y termina. |

Resultado esperado: el cliente tiene `10.10.10.10/24` y `10.20.20.10/24`; el servidor, `10.10.10.20/24` y `10.20.20.20/24`. Ninguno tiene ruta `default` y ambos `ping` reciben respuesta. Esta salida es la evidencia **E1**.

**Por qué importan dos direcciones:** el cliente usa como origen la dirección de la misma red que el destino. Si te conectas a `10.10.10.20`, el origen es `10.10.10.10` (administración); si te conectas a `10.20.20.20`, el origen es `10.20.20.10` (terminales). Así un mismo equipo representa los dos orígenes del requisito.

**Precaución:** si aparece otra dirección, una ruta `default` o un adaptador NAT o puente, detente e informa al docente. No corrijas la red por tu cuenta.

## 2. Leer el estado inicial de UFW

En la **consola local** de `SERVIDOR-LAB`, como `admin01`:

```bash
sudo ufw status verbose
sudo ufw status numbered
```

| Parte | Explicación |
| --- | --- |
| `sudo` | Ejecuta el comando con privilegios; pedirá la contraseña de `admin01`. |
| `ufw status verbose` | Muestra si UFW está activo, el nivel de registro y la política por defecto, por ejemplo `Default: deny (incoming), allow (outgoing)`. |
| `ufw status numbered` | Lista las reglas con un número entre corchetes. No muestra la política por defecto. |

Cómo leer una regla:

| Columna | Ejemplo | Significado |
| --- | --- | --- |
| `To` | `22/tcp` | Puerto y protocolo de destino en el servidor. |
| `Action` | `ALLOW IN` | Se permite el tráfico entrante. |
| `From` | `Anywhere` | Cualquier origen. Es el problema de esta regla. |
| `(v6)` | `22/tcp (v6)` | La misma regla para IPv6. |

Resultado esperado: UFW activo, entrada denegada por defecto, `22/tcp ALLOW IN Anywhere` y `443/tcp ALLOW IN Anywhere`. Esta salida es la evidencia **E2**. Si hay otras reglas para el puerto 22, detente y consulta al docente.

## 3. Comprobar que terminales alcanza SSH

En la consola local de `CLIENTE-LAB`, como **`docente`** (`docente@cliente-lab:~$`):

```bash
date '+%F %T'
ssh -o ConnectTimeout=8 admin01@10.20.20.20
```

| Parte | Explicación |
| --- | --- |
| `date '+%F %T'` | Muestra fecha y hora (`AAAA-MM-DD HH:MM:SS`) para registrar cuándo hiciste la prueba. |
| `ssh` | Abre una conexión de administración remota. |
| `-o ConnectTimeout=8` | Espera como máximo ocho segundos a que el servidor responda. |
| `admin01@10.20.20.20` | Cuenta y dirección de destino. El origen será `10.20.20.10`. |

Cuando aparezca la petición de contraseña, **no la escribas**: cancela con `Ctrl+C`. Si antes aparece la pregunta `Are you sure you want to continue connecting (yes/no/[fingerprint])?`, eso ya demuestra que el servidor respondió: cancela también con `Ctrl+C`. Esta salida es la evidencia **E3**: el origen no autorizado alcanza el servicio; no prueba que alguien haya iniciado sesión.

## 4. Corregir la regla

Sigue en la **consola local** de `SERVIDOR-LAB`, como **`admin01`** (`admin01@servidor-lab:~$`). No hagas este cambio desde una sesión SSH: si te equivocas, podrías perder el acceso.

```bash
sudo ufw allow from 10.10.10.0/24 to any port 22 proto tcp
sudo ufw delete allow 22/tcp
sudo ufw status numbered
sudo ufw status verbose
```

| Parte | Explicación |
| --- | --- |
| `ufw allow from 10.10.10.0/24` | Permite tráfico solo desde la red de administración (`/24`: de `10.10.10.0` a `10.10.10.255`). |
| `to any port 22 proto tcp` | Hacia el puerto TCP 22 de cualquier dirección del servidor. |
| `ufw delete allow 22/tcp` | Elimina la regla amplia, escrita igual que cuando se creó. Retira también su copia `(v6)`. |
| `status numbered` y `status verbose` | Confirman reglas finales y política por defecto. Se necesitan ambos. |

El orden importa: primero se agrega el acceso correcto y después se retira el amplio, para no quedar sin ningún acceso permitido.

Resultado esperado: `22/tcp ALLOW IN 10.10.10.0/24`, ninguna regla `22/tcp ALLOW IN Anywhere` ni `(v6)`, `443/tcp` conservado y `Default: deny (incoming)`. Los comandos y ambas salidas son la evidencia **E4**.

**Precaución:** si `ufw delete` responde `Could not delete non-existent rule`, revisa con `sudo ufw status numbered` cómo está escrita la regla y consulta al docente antes de borrar por número.

## 5. Probar el acceso permitido

En la consola local de `CLIENTE-LAB`, como **`docente`** (`docente@cliente-lab:~$`):

```bash
date '+%F %T'
ssh -o ConnectTimeout=8 admin01@10.10.10.20
```

Si aparece la pregunta de autenticidad, verifica la huella con el docente antes de aceptarla. Escribe la contraseña de **`admin01` del servidor** cuando la pida. Ya dentro, el indicador cambia a `admin01@servidor-lab:~$`. Sal de esa sesión remota con:

```bash
exit
```

| Parte | Explicación |
| --- | --- |
| `admin01@10.10.10.20` | Destino en la red de administración; el origen es `10.10.10.10`. |
| `exit` | Cierra la sesión remota y vuelve al cliente. |

Comprueba que el indicador vuelve a **`docente@cliente-lab:~$`** antes de continuar. Resultado esperado: se pide contraseña y se inicia sesión. Hora, comando y resultado son la evidencia **E5**. No incluyas la contraseña en la captura.

## 6. Probar el acceso denegado

En la consola local de `CLIENTE-LAB`, como **`docente`**, después de salir de SSH y comprobar que el indicador sea `docente@cliente-lab:~$`:

```bash
date '+%F %T'
ssh -o ConnectTimeout=8 admin01@10.20.20.20
```

Resultado esperado: después de unos ocho segundos aparece `Connection timed out`, **sin** pedir contraseña. Anota la hora mostrada por `date`.

| Mensaje | Qué significa |
| --- | --- |
| `Connection timed out` | No hubo respuesta: el paquete se descartó. Es lo esperado con UFW. |
| `Connection refused` | El servidor respondió que no hay servicio o lo rechazó. No es el resultado esperado; consulta al docente. |
| Petición de contraseña | La restricción no se aplicó. Vuelve al paso 4. |

## 7. Atribuir el bloqueo a UFW

Vuelve a la **consola local de `SERVIDOR-LAB`** en VirtualBox. Si sigue abierta la sesión local de `admin01`, escribe `exit` para cerrarla e inicia sesión como **`docente`**, con su contraseña. Comprueba que el indicador sea **`docente@servidor-lab:~$`**. `admin01` tiene permiso para UFW, pero no para esta consulta del kernel. Como `docente`, ejecuta:

```bash
sudo journalctl -k --since -20min | grep 'UFW BLOCK' | tail -5
```

| Parte | Explicación |
| --- | --- |
| `journalctl -k` | Muestra los mensajes del kernel, donde UFW registra los paquetes bloqueados. |
| `--since -20min` | Limita la búsqueda a los últimos 20 minutos. |
| `\|` | Envía la salida al comando siguiente. |
| `grep 'UFW BLOCK'` | Deja solo las líneas de paquetes bloqueados. |
| `tail -5` | Muestra las cinco últimas coincidencias. |

Campos de una línea `UFW BLOCK` que debes relacionar con la prueba denegada:

| Campo | Valor esperado | Significado |
| --- | --- | --- |
| Hora al inicio de la línea | Cercana a la anotada en el paso 6 | Cuándo se bloqueó. |
| `SRC=` | `10.20.20.10` | Origen: terminales. |
| `DST=` | `10.20.20.20` | Destino: el servidor. |
| `DPT=` | `22` | Puerto de destino: SSH. |
| `SYN` | Presente | Intento de iniciar la conexión TCP. |

La salida del paso 6 y la línea correlacionada son la evidencia **E6**. Pega solo esa línea en el espacio E6 de la plantilla de entrega, junto al resultado denegado; no incluyas el registro completo. Si no aparece ninguna línea, anota «causa no confirmada»: un tiempo agotado por sí solo no identifica qué control actuó.

## Interpretar los resultados

| Resultado | Afirmación válida | Sobreafirmación que debe evitarse |
| --- | --- | --- |
| Estado final de UFW | La regla amplia ya no existe y SSH se permite solo desde `10.10.10.0/24`. | El servidor es seguro. |
| Prueba permitida | Desde administración se alcanza SSH y se autentica con una cuenta válida. | Todas las cuentas usan contraseñas robustas o MFA. |
| Prueba denegada con `UFW BLOCK` | UFW descartó el intento desde terminales al puerto 22 en esa hora. | Ningún origen no autorizado puede entrar por ningún servicio. |
| Tiempo agotado sin registro | La conexión desde terminales no se completó. | UFW fue la causa del bloqueo. |
| `443/tcp` conservado | La regla de HTTPS sigue presente. | Existe un servicio HTTPS funcionando. |
| Maqueta corregida | Se corrigió la desviación LAB11-SSH. | Se cerró el hallazgo H-01 de PACÍFICO RETAIL. |

## Evidencia mínima de cierre

| Evidencia | Qué comprobar o conservar |
| --- | --- |
| E1 · Entorno | `ip -br addr`, `ip route` y `ping` de ambos equipos. |
| E2 · Antes | `ufw status verbose` y `numbered` con la regla amplia. |
| E3 · Alcance inicial | Hora y petición de contraseña desde `10.20.20.10`, cancelada. |
| E4 · Cambio y después | Comandos aplicados y ambos estados finales. |
| E5 · Permitido | Hora, sesión iniciada desde `10.10.10.10` y `exit`. |
| E6 · Denegado y atribución | Hora, `Connection timed out` y la línea `UFW BLOCK` correlacionada, o «causa no confirmada». |

## Si aparece un error

| Situación | Qué revisar |
| --- | --- |
| `ping` sin respuesta | Adaptador `lab_seguridad` y direcciones con `ip -br addr`; informa al docente. |
| `sudo` rechaza el comando | Estás usando una cuenta distinta a la indicada para ese paso: `admin01` para UFW y `docente` para `journalctl`. |
| `ERROR: Could not find a profile matching` | Revisa la escritura: `from`, `to any port 22 proto tcp`. |
| `Could not delete non-existent rule` | La regla amplia está escrita de otra forma; consulta al docente antes de borrar por número. |
| Persiste `22/tcp (v6) ALLOW IN Anywhere (v6)` | La regla IPv6 no se eliminó; consulta al docente. |
| La prueba denegada pide contraseña | La regla amplia sigue activa; revisa `sudo ufw status numbered`. |
| La prueba permitida agota el tiempo | Revisa la regla específica y que te conectas a `10.10.10.20`, no a `10.20.20.20`. |
| `journalctl` no muestra `UFW BLOCK` | Comprueba la hora y que `ufw status verbose` indique `Logging: on`; si sigue sin aparecer, anota «causa no confirmada». |
| Perdiste la consola o la VM queda inestable | Informa al docente; si es necesario, se puede volver a importar el OVA en una copia separada, sin sobrescribir el trabajo previo. |

