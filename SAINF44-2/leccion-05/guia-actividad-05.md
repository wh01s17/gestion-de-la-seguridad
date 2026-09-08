---
title: "Guía práctica y compendio de Snort 3 - Lección 05"
tags:
  - nota
  - course
  - curso
  - guia-de-comandos
  - ids
  - snort
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "05"
author: Jordy
start: 2026-09-07
end: 2026-09-08
created_at: 2026-09-05
aliases:
  - "Guía de comandos Lección 05 - Snort 3"
  - "Guía práctica y compendio de Snort 3 - Lección 05"
---
# Guía práctica y compendio de Snort 3 - Lección 05

La primera parte acompaña la actividad y la referencia final sirve para continuar practicando. No es necesario leer el documento completo antes de comenzar.

## Índice

- [El laboratorio](#el-laboratorio)
- [Anatomía de la regla](#anatomía-de-la-regla)
- [Secuencia de trabajo](#secuencia-de-trabajo)
  - [Comando directo para aplicar la solución](#5-comando-directo-para-aplicar-la-solución)
- [Cómo leer una alerta](#cómo-leer-una-alerta)
- [Correlacionar los registros](#correlacionar-los-registros)
- [Si algo falla](#si-algo-falla)
- [Otros comandos útiles para este laboratorio](#otros-comandos-útiles-para-este-laboratorio)
- [Referencia práctica para después del laboratorio](#referencia-práctica-para-después-del-laboratorio)
  - [Rutas y configuración mínima](#1-rutas-y-configuración-mínima)
  - [Ciclo seguro para una regla](#2-ciclo-seguro-para-una-regla)
  - [Reglas locales de ejemplo](#3-reglas-locales-de-ejemplo)
  - [Reducir alertas repetidas](#4-reducir-alertas-repetidas)
  - [Salida JSON](#5-salida-json)
  - [Revisión cotidiana](#6-revisión-cotidiana)
- [Fuentes oficiales](#fuentes-oficiales)

## El laboratorio

Para realizar la actividad, inicia sesión en el OVA `SENSOR-LAB` con el usuario `lab`; el docente entrega la contraseña por separado. La cuenta `docente`, que tiene privilegios administrativos, se utiliza únicamente para preparar, mantener o recuperar la VM y no debe usarse durante el trabajo del estudiante.

```text
CLIENTE-LAB  →  FIREWALL  →  SENSOR IDS  →  WEB-LAB
10.10.10.10                              10.10.20.5:80
```

El firewall permite o deniega. El IDS recibe una copia del tráfico que el firewall dejó pasar y genera alertas; no bloquea.

La VM no tiene red. Snort leerá `trafico_l05.pcap`, una captura sintética guardada.

## Anatomía de la regla

Una regla completa reúne una cabecera y sus opciones:

```text
alert tcp 10.10.10.0/24 any -> 10.10.20.5 80 (msg:"Ejemplo LOGIN"; flow:to_server,established; content:"LOGIN"; sid:1000101; rev:1;)
```

La cabecera indica qué tráfico se revisará:

```text
alert tcp 10.10.10.0/24 any -> 10.10.20.5 80
  │    │        │        │   │       │     └─ puerto de destino
  │    │        │        │   │       └─ IP de destino
  │    │        │        │   └─ dirección del tráfico
  │    │        │        └─ puerto de origen: cualquiera
  │    │        └─ red de origen
  │    └─ protocolo
  └─ acción: generar una alerta
```

| Elemento                     | Significado                                                                    |
| ---------------------------- | ------------------------------------------------------------------------------ |
| `->`                         | Revisa solo desde el origen hacia el destino.                                  |
| `<>`                         | Revisa ambos sentidos.                                                         |
| `msg:"Ejemplo LOGIN"`       | Define el texto que aparecerá en la alerta.                                    |
| `flow:to_server,established` | Exige una solicitud hacia el servidor dentro de una conexión establecida.      |
| `content:"LOGIN"`            | Busca esa cadena dentro de los datos. Distingue mayúsculas y minúsculas.       |
| `sid:1000101`                | Asigna un identificador único a la regla. Los locales comienzan en `1000000`.  |
| `rev:1`                      | Indica la revisión de la regla; aumenta cuando esta cambia.                    |

Cada opción termina en `;` y todas quedan dentro de paréntesis.

## Secuencia de trabajo

### 1. Preparar la copia

```bash
# -c: comprueba los hashes indicados en el manifiesto
sha256sum -c manifest_entrega.sha256

# cp: crea la copia que se editará
cp regla_inicial.rules local_l05.rules

# Guarda la ruta de la configuración para reutilizarla
SNORT_CONFIG_L05=/usr/local/etc/snort/snort.lua
```

La variable guarda la ruta del archivo de configuración mientras la terminal permanezca abierta.

### 2. Validar sintaxis

```bash
# -c: carga la configuración de Snort
# -R: carga la regla que se validará
# -T: revisa la configuración y termina sin analizar tráfico
snort -c "$SNORT_CONFIG_L05" -R local_l05.rules -T
```

Si termina sin errores, Snort pudo cargar la regla. Esto todavía no demuestra que detecte el tráfico correcto.

### 3. Analizar la captura

```bash
# -q: muestra solo las alertas
# -c: carga la configuración de Snort
# -R: carga la regla que se probará
# -r: analiza una captura guardada
# -A alert_fast: muestra una alerta por línea
snort -q -c "$SNORT_CONFIG_L05" -R local_l05.rules \
  -r trafico_l05.pcap -A alert_fast
```

En esta actividad se usa `-r` para leer la captura guardada. No se usa `-i`, porque esa opción escucharía tráfico en vivo desde una interfaz de red.

### 4. Editar la regla

```bash
# Abre la copia de la regla para editarla
nano local_l05.rules
```

Guarda con `Ctrl+O` y sal con `Ctrl+X`.

Después de editar, repite siempre la validación de sintaxis y el análisis de la captura.

### 5. Comando directo para aplicar la solución

Después de diagnosticar la regla inicial, puedes escribir la regla ajustada completa con un solo comando:

```bash
# printf genera la línea; > reemplaza el contenido de la copia local
printf '%s\n' 'alert tcp 10.10.10.0/24 any -> 10.10.20.5 80 (msg:"INF44 L05 marcador UA1-LAB"; flow:to_server,established; content:"UA1-LAB"; sid:1000101; rev:2;)' > local_l05.rules
```

El comando modifica únicamente `local_l05.rules`: no altera `regla_inicial.rules`. La solución restringe el origen a `10.10.10.0/24`, dirige la inspección hacia `10.10.20.5:80`, busca `UA1-LAB`, exige una conexión dirigida al servidor y aumenta la revisión a `2` sin cambiar el `sid`.

Valida de inmediato tanto la sintaxis como el comportamiento:

```bash
snort -c "$SNORT_CONFIG_L05" -R local_l05.rules -T
snort -q -c "$SNORT_CONFIG_L05" -R local_l05.rules \
  -r trafico_l05.pcap -A alert_fast
```

La salida correcta contiene una sola alerta: P1, identificable por el puerto de cliente `41001`. P2, P3, P4 y P5 no deben aparecer.

## Cómo leer una alerta

Ejemplo:

```text
09/07-10:00:01 [**] [1:1000101:1] mensaje [**] {TCP} 10.10.10.10:41003 -> 10.10.20.5:80
```

| Parte | Qué indica |
| --- | --- |
| `09/07-10:00:01` | Hora del paquete dentro de la captura. |
| `[1:1000101:1]` | Generador, `sid` y `rev`. |
| `10.10.10.10:41003` | IP y puerto de origen. El puerto permite reconocer P1 a P5. |
| `-> 10.10.20.5:80` | Dirección, IP y puerto de destino. |

Los puertos `41001`, `41002`, `41003`, `41004` y `41005` corresponden a P1, P2, P3, P4 y P5.

## Correlacionar los registros

```bash
# cat: muestra el contenido sin modificar los archivos
cat contexto_controles.csv
cat registros_l05.csv
```

Compara la hora, el origen, el servicio y la cuenta:

- el IDS informa qué tráfico coincidió con la regla;
- el firewall informa si permitió o denegó el origen;
- AAA informa las sesiones aceptadas;
- accounting registra la acción y, cuando existe evidencia suficiente, la cuenta asociada.

No atribuyas una acción a una persona si el registro no identifica una cuenta. La respuesta correcta puede ser `no atribuible con la evidencia disponible`.

## Si algo falla

| Problema | Revisión breve |
| --- | --- |
| `snort: command not found` | Confirma que estás dentro de `SENSOR-LAB`. |
| No encuentra `snort.lua` | Vuelve a definir `SNORT_CONFIG_L05`. |
| El manifiesto muestra `FAILED` | Detente y avisa al docente. |
| La regla no carga | Revisa paréntesis, comillas y `;`. |
| La regla inicial muestra solo P3 | No modifiques `snort.lua`. Confirma que usas `SENSOR-LAB` y avisa al docente. |
| La regla ajustada no alerta en P1 | Revisa `content`, mayúsculas, origen y dirección. |
| La regla ajustada alerta en P5 | El marcador también viaja en la respuesta del servidor. Revisa `->` y `flow:to_server,established`. |
| Aparecen alertas adicionales | Identifica el caso por el puerto y revisa el sentido y el contenido. |

## Otros comandos útiles para este laboratorio

Estos comandos son opcionales. Sirven para revisar el entorno y comprender mejor la captura. Todos leen archivos locales; ninguno captura tráfico en vivo.

### Confirmar ubicación y archivos

```bash
# pwd: muestra la carpeta actual
pwd

# -l: lista detallada; -h: muestra tamaños fáciles de leer
ls -lh

# file: identifica el tipo de archivo
file trafico_l05.pcap
```

- `pwd` muestra la carpeta actual.
- `ls -lh` enumera los archivos y sus tamaños.
- `file` comprueba que `trafico_l05.pcap` sea una captura reconocible.

### Consultar las versiones instaladas

```bash
# -V y --version: muestran la versión de cada herramienta
snort -V

# | envía la salida a head; -n 1 conserva solo la primera línea
tshark --version | head -n 1
```

Permiten registrar qué versiones se utilizaron si un resultado difiere entre estaciones.

### Resumir las conversaciones TCP

```bash
# -r: lee la captura; -q: oculta paquetes individuales
# -z conv,tcp: resume las conversaciones TCP
tshark -r trafico_l05.pcap -q -z conv,tcp
```

Muestra los pares de direcciones y puertos. En esta captura deben aparecer cinco conversaciones.

### Mostrar solamente paquetes con datos

```bash
# -r: lee la captura; -Y: aplica el filtro indicado
# -T fields: muestra campos; cada -e agrega una columna
tshark -r trafico_l05.pcap -Y 'tcp.len > 0' \
  -T fields -e frame.number -e ip.src -e tcp.srcport \
  -e ip.dst -e tcp.dstport -e tcp.len
```

Oculta los paquetes de establecimiento que no transportan contenido y facilita reconocer la dirección de cada caso.

### Revisar un caso por su puerto

```bash
# -r: lee la captura; -Y: muestra solo el puerto indicado
tshark -r trafico_l05.pcap -Y 'tcp.port == 41001'
```

El ejemplo muestra solo P1. Sustituye `41001` por `41002`, `41003`, `41004` o `41005` para revisar otro caso.

### Mostrar las solicitudes HTTP

```bash
# -Y: conserva solicitudes HTTP; -T fields: muestra campos
# Cada -e agrega una columna a la salida
tshark -r trafico_l05.pcap -Y 'http.request' \
  -T fields -e tcp.stream -e http.request.method -e http.request.uri
```

Permite distinguir `POST /demo`, `GET /status`, `GET /LOGIN-help` y las solicitudes asociadas a P4 y P5.

### Comparar la regla original con la ajustada

```bash
# -u: presenta las diferencias en un formato unificado
diff -u regla_inicial.rules local_l05.rules
```

Las líneas con `-` pertenecen a la regla original y las líneas con `+` muestran lo que cambió en la copia.

### Buscar eventos relevantes en los registros

```bash
# -E: permite usar | como "o" dentro del patrón de búsqueda
grep -E '41001|41003|denegado' registros_l05.csv
```

Muestra los eventos asociados con P1, P3 y la conexión que el firewall denegó.

---

## Referencia práctica para después del laboratorio

Esta parte es opcional durante la clase. Resume configuraciones y reglas habituales para continuar practicando Snort 3.

Los comandos con `sudo` de esta referencia están pensados para una instalación propia o administrada, no para el OVA de la actividad. En `SENSOR-LAB` permanece con el usuario `lab` y no modifiques la configuración del sistema.

Los ejemplos representan situaciones empresariales, pero no deben copiarse directamente a producción. Sustituye las redes, prueba tráfico positivo y negativo, mide los falsos positivos y correlaciona cada alerta con otras fuentes antes de declarar un incidente.

### 1. Rutas y configuración mínima

Elige las rutas correspondientes a tu instalación:

```bash
# Debian o Arch compilado desde el código fuente
SNORT_CONFIG=/usr/local/etc/snort/snort.lua
LOCAL_RULES=/usr/local/etc/snort/rules/local.rules
```

```bash
# Arch instalado desde AUR
SNORT_CONFIG=/etc/snort/snort.lua
LOCAL_RULES=/etc/snort/rules/local.rules
```

Antes de editar, conserva una copia y crea el archivo de reglas locales:

```bash
# Respalda la configuración actual
sudo cp "$SNORT_CONFIG" "$SNORT_CONFIG.bak"

# Crea la carpeta y abre el archivo de reglas
sudo mkdir -p "$(dirname "$LOCAL_RULES")"
sudo nano "$LOCAL_RULES"
```

En `snort.lua`, define las redes antes de `include 'snort_defaults.lua'`:

```lua
HOME_NET = [[ 10.10.0.0/16 172.20.0.0/16 ]]
EXTERNAL_NET = 'any'

include 'snort_defaults.lua'
```

Después, edita la tabla `ips` que ya existe. No crees una segunda tabla:

```lua
ips =
{
    variables = default_variables,
    rules = [[
        include /etc/snort/rules/local.rules
    ]]
}
```

Si compilaste Snort, usa `/usr/local/etc/snort/rules/local.rules` en la última ruta.

> [!NOTE]
> La OVA de esta lección activa `search_engine.detect_raw_tcp` para una regla didáctica simplificada. No copies ese ajuste como configuración empresarial general. Para HTTP se prefieren búferes específicos, como `http_uri`, `http_header` y `file_data`.

### 2. Ciclo seguro para una regla

```text
Definir el objetivo → escribir → validar → probar PCAP → pilotar como alert → ajustar → desplegar
```

1. Escribe una sola intención por regla.
2. Usa un `sid` local único desde `1000000` y comienza con `rev:1`.
3. Valida la sintaxis antes de analizar tráfico.
4. Prueba una PCAP que deba alertar y otra que no deba alertar.
5. Despliega primero con acción `alert` en un sensor piloto.
6. Aumenta `rev` cuando modifiques la lógica sin cambiar su objetivo.
7. Usa `drop` solo en modo IPS, con aprobación y un procedimiento de reversión.

Para tráfico en vivo, `-i` recibe el nombre de una interfaz:

```bash
# Usa solo una interfaz autorizada conectada a un TAP, SPAN o laboratorio
sudo snort -q -c "$SNORT_CONFIG" -i enp1s0 -A alert_fast
```

### 3. Reglas locales de ejemplo

Cada regla debe ajustarse a la arquitectura y al tráfico normal de la organización.

Todas las reglas de las secciones 3.1 a 3.9 comienzan con `alert`: **detectan y registran, pero no bloquean**. Las variables `$HOME_NET` y `$EXTERNAL_NET` representan las redes definidas en `snort.lua`; si están mal configuradas, también lo estará el alcance de las reglas. En la configuración mínima anterior, `EXTERNAL_NET = 'any'` simplifica la práctica, pero también abarca direcciones internas. Para que «externa» signifique realmente fuera de la organización, su valor debe ajustarse a la arquitectura antes de usar estos ejemplos.

Opciones que se repiten en los ejemplos:

| Opción | Cómo se interpreta |
| --- | --- |
| `flags:S,CE` | Examina paquetes con solo `SYN`, ignorando los bits ECN `CWR` y `ECE`; aproxima el inicio de una conexión TCP. |
| `flow:to_server,established` | Exige tráfico del cliente al servidor dentro de una conexión TCP ya establecida. |
| `flow:to_client,established` | Exige una respuesta del servidor al cliente dentro de una conexión establecida. |
| `detection_filter:track by_src,count N,seconds S` | Cuenta coincidencias por IP de origen y genera eventos cuando esa fuente supera `N` coincidencias durante `S` segundos. No descarta paquetes. |
| `service:http` | Exige que el inspector de Snort haya identificado el servicio como HTTP, aunque use un puerto distinto de 80. |
| `nocase` | Hace que la búsqueda no distinga mayúsculas de minúsculas. |
| `offset` y `depth` | Limitan la búsqueda a una posición y longitud determinadas dentro del búfer seleccionado. |

#### 3.1 Intento de SMB hacia Internet

```snort
alert tcp $HOME_NET any -> $EXTERNAL_NET 445 (
    msg:"EMPRESA POLICY intento SMB hacia Internet";
    flags:S,CE;
    sid:1001001;
    rev:1;
)
```

Puede revelar errores de configuración, software no autorizado o propagación.

La cabecera selecciona intentos desde una red interna hacia TCP/445 en los destinos representados por `$EXTERNAL_NET`. Solo equivale a «Internet» si esa variable excluye correctamente las redes internas. `flags:S,CE` hace coincidir el paquete inicial `SYN`, por lo que una alerta representa un **intento de abrir una conexión SMB**, no una sesión completada ni una fuga de archivos. Antes de responder, confirma si el destino era realmente externo, si era legítimo y si el firewall permitió la conexión.

#### 3.2 Administración desde una red no autorizada

```snort
alert tcp 10.10.30.0/24 any -> 10.10.20.0/24 [22,3389] (
    msg:"EMPRESA POLICY acceso administrativo desde red de usuarios";
    flags:S,CE;
    sid:1001002;
    rev:1;
)
```

Ejemplo para una red de usuarios que no debería administrar servidores mediante SSH o RDP.

La regla observa paquetes `SYN` desde `10.10.30.0/24` hacia los puertos 22 o 3389 de `10.10.20.0/24`. La lista `[22,3389]` significa SSH **o** RDP. La alerta muestra un intento de conexión desde un segmento no autorizado, pero no demuestra que el acceso se haya autenticado ni que haya tenido éxito.

#### 3.3 Concentración de conexiones SYN

```snort
alert tcp $EXTERNAL_NET any -> $HOME_NET any (
    msg:"EMPRESA RECON concentracion de conexiones TCP SYN";
    flags:S,CE;
    detection_filter:track by_src,count 20,seconds 10;
    sid:1001003;
    rev:1;
)
```

Puede indicar reconocimiento o automatización, pero también coincidir con balanceadores y monitores legítimos.

Cada `SYN` dirigido a la red protegida cuenta como una coincidencia. `track by_src` mantiene un contador separado por IP de origen y la regla comienza a generar eventos cuando una fuente supera 20 coincidencias dentro de 10 segundos. El umbral reduce ruido, pero no limita ni bloquea las conexiones; debe ajustarse usando una línea base de tráfico normal.

#### 3.4 Barrido ICMP: detección, no bloqueo

```snort
alert icmp $EXTERNAL_NET any -> $HOME_NET any (
    msg:"EMPRESA RECON concentracion de solicitudes ICMP";
    itype:8;
    detection_filter:track by_src,count 20,seconds 10;
    sid:1001004;
    rev:1;
)
```

Ajusta el umbral para no alertar por herramientas de monitoreo autorizadas.

`itype:8` selecciona solicitudes ICMP Echo Request, conocidas habitualmente como `ping`. La regla cuenta esas solicitudes por IP de origen y alerta cuando una fuente supera 20 en 10 segundos, un patrón compatible con un barrido de hosts.

Esta regla **no bloquea ICMP**, porque su acción es `alert`. Tampoco confirma por sí sola un ataque: una plataforma de monitoreo, un inventario autorizado o una prueba de conectividad pueden producir el mismo patrón. Además, solo examina el tipo 8; no representa todo el protocolo ICMP.

#### 3.5 Múltiples conexiones SSH

```snort
alert tcp $EXTERNAL_NET any -> $HOME_NET 22 (
    msg:"EMPRESA AUTH multiples conexiones SSH";
    flow:to_server,established;
    content:"SSH-",offset 0,depth 4;
    detection_filter:track by_src,count 10,seconds 60;
    sid:1001005;
    rev:1;
)
```

No demuestra que las credenciales hayan fallado; confirma el resultado en los registros de autenticación.

Después de establecerse TCP, cliente y servidor envían una cadena de versión que comienza con `SSH-`. Esta regla busca la cadena enviada hacia el servidor y cuenta las coincidencias por origen. Si una IP supera 10 en 60 segundos genera eventos. Por ello aproxima múltiples conexiones SSH, pero no inspecciona intentos de contraseña ni permite concluir fuerza bruta sin correlacionar `sshd`, PAM u otra fuente de autenticación.

#### 3.6 Acceso HTTP a una ruta administrativa

```snort
alert tcp $EXTERNAL_NET any -> $HOME_NET any (
    msg:"EMPRESA WEB acceso a ruta administrativa";
    flow:to_server,established;
    service:http;
    http_uri:path;
    content:"/admin",nocase;
    sid:1001006;
    rev:1;
)
```

`http_uri:path` limita la búsqueda a la ruta normalizada de la solicitud.

Snort debe identificar primero la sesión como HTTP. Luego `http_uri:path` mueve la búsqueda a la ruta normalizada de la solicitud y `content:"/admin",nocase` busca esa cadena sin distinguir mayúsculas. Puede coincidir con `/admin`, `/admin/usuarios` o incluso `/administracion`; si solo interesa una ruta exacta, se necesitan condiciones adicionales. Una coincidencia indica acceso a la ruta, no autenticación exitosa ni explotación.

#### 3.7 Cliente HTTP automatizado

```snort
alert tcp $EXTERNAL_NET any -> $HOME_NET any (
    msg:"EMPRESA WEB cliente automatizado observado";
    flow:to_server,established;
    service:http;
    http_header:field user-agent;
    content:"python-requests",nocase;
    sid:1001007;
    rev:1;
)
```

La automatización puede ser legítima; esta coincidencia aporta contexto, no confirma un ataque.

`http_header:field user-agent` limita la búsqueda al valor normalizado de la cabecera `User-Agent`. La regla alerta cuando encuentra `python-requests`, sin importar sus mayúsculas. Es útil para inventariar clientes automatizados, pero el encabezado puede modificarse y aplicaciones internas legítimas también pueden usar esa biblioteca.

#### 3.8 Autenticación Basic sobre HTTP

```snort
alert tcp $HOME_NET any -> $EXTERNAL_NET any (
    msg:"EMPRESA POLICY autenticacion Basic sobre HTTP";
    flow:to_server,established;
    service:http;
    http_header:field authorization;
    content:"Basic ",nocase,offset 0,depth 6;
    sid:1001008;
    rev:1;
)
```

Detecta el uso de autenticación Basic mediante HTTP sin cifrar, pero no muestra la credencial.

La regla observa solicitudes HTTP salientes y selecciona únicamente el valor de la cabecera `Authorization`. `offset 0,depth 6` exige que sus primeros seis caracteres sean `Basic `. La alerta evidencia el uso del esquema Basic en tráfico que Snort puede leer; no valida la contraseña ni imprime por sí sola la credencial. No detectará el contenido de una sesión HTTPS si el sensor no tiene visibilidad después de una terminación TLS autorizada.

#### 3.9 Ejecutable PE descargado por HTTP

```snort
alert tcp $EXTERNAL_NET any -> $HOME_NET any (
    msg:"EMPRESA FILE posible ejecutable PE descargado por HTTP";
    flow:to_client,established;
    service:http;
    file_data;
    content:"MZ",depth 2;
    sid:1001009;
    rev:1;
)
```

`file_data` revisa el cuerpo normalizado de la respuesta. El encabezado `MZ` no demuestra que el archivo sea malware.

La dirección `to_client` selecciona la descarga desde un servidor hacia un equipo interno. `file_data` posiciona la inspección en los datos de archivo procesados por Snort y `content:"MZ",depth 2` exige la firma `MZ` dentro de los primeros dos bytes. Es un indicio de un ejecutable PE de Windows, pero también coincide con software legítimo; se debe complementar con hash, procedencia, firma digital, análisis de endpoint o sandbox.

#### 3.10 Bloqueo de solicitudes ICMP en modo IPS

Si el objetivo fuera **bloquear** las solicitudes de `ping` entrantes, la acción tendría que cambiar explícitamente. Este ejemplo descarta cada Echo Request que coincida:

```snort
drop icmp $EXTERNAL_NET any -> $HOME_NET any (
    msg:"EMPRESA POLICY descartar solicitudes ICMP Echo entrantes";
    itype:8;
    sid:1001010;
    rev:1;
)
```

`drop` descarta el paquete coincidente. Snort también dispone de `block`, que bloquea el paquete actual y los posteriores del mismo flujo. Ambas acciones requieren un despliegue **en línea y configurado como IPS**; al leer una PCAP o trabajar como IDS no se puede detener tráfico que ya pasó. Por esta razón, el OVA de la actividad solo demuestra detección.

No conviene bloquear todo ICMP con una regla genérica. El ejemplo restringe el control a Echo Request (`itype:8`), pero aun así puede interrumpir monitoreo y diagnóstico, y no impide todas las técnicas de descubrimiento. Antes de desplegarlo, valida el modo inline, define excepciones, prueba conectividad y prepara una reversión.

### 4. Reducir alertas repetidas

Primero restringe redes, puertos, dirección, servicio y búfer. Usa filtros solo después de entender por qué aparece el evento.

Una alerta cada 300 segundos por origen para `sid:1001001`:

```lua
event_filter =
{
    { gid = 1, sid = 1001001, type = 'limit',
      track = 'by_src', count = 1, seconds = 300 }
}
```

Suprimir un escáner autorizado:

```lua
suppress =
{
    { gid = 1, sid = 1001007,
      track = 'by_src', ip = '10.10.50.25' }
}
```

Si una tabla ya existe en `snort.lua`, agrega el registro dentro de ella. Documenta la justificación, el responsable y la fecha de revisión de cada supresión.

### 5. Salida JSON

```bash
# Crea una carpeta de registros sin privilegios
mkdir -p ~/snort-logs

# Guarda campos útiles en alert_json.txt
snort -q -c "$SNORT_CONFIG" -r prueba.pcap -A alert_json \
  -l ~/snort-logs \
  --lua "alert_json = { file = true, fields = 'timestamp proto dir src_ap dst_ap rule action msg class' }"
```

JSON facilita el envío posterior a un SIEM. Protege los registros, sincroniza la hora del sensor y define una política de retención.

### 6. Revisión cotidiana

| Revisión | Pregunta práctica |
| --- | --- |
| Salud del sensor | ¿Snort está activo, recibe tráfico y tiene espacio disponible? |
| Configuración | ¿`snort -c ... -T` termina correctamente? |
| Cobertura | ¿`HOME_NET` todavía representa las redes protegidas? |
| Alertas | ¿El evento coincide con el activo, servicio y dirección esperados? |
| Contexto | ¿Firewall, AAA, aplicación o EDR confirman la actividad? |
| Ruido | ¿Debe ajustarse la regla o existe una excepción formal? |
| Cambios | ¿Se registraron `sid`, `rev`, pruebas y responsable? |

El contenido de HTTPS está cifrado. Las reglas que inspeccionan URI, cabeceras o archivos necesitan visibilidad antes del cifrado, después de una terminación TLS autorizada o mediante otras fuentes de telemetría.

Para vulnerabilidades y amenazas actuales, utiliza reglas mantenidas por Cisco Talos o las reglas comunitarias. Las reglas locales anteriores cubren políticas y señales generales; no sustituyen un conjunto actualizado.

## Fuentes oficiales

- [Estructura de las reglas](https://docs.snort.org/rules/)
- [Acciones `alert`, `drop` y `block`](https://docs.snort.org/rules/headers/actions)
- [Opciones `flow`](https://docs.snort.org/rules/options/non_payload/flow)
- [Banderas TCP con `flags`](https://docs.snort.org/rules/options/non_payload/flags)
- [Tipos ICMP con `itype`](https://docs.snort.org/rules/options/non_payload/itype)
- [Filtros de detección](https://docs.snort.org/rules/options/post/detection_filter)
- [Búferes HTTP](https://docs.snort.org/rules/options/payload/http/)
- [Búfer de archivos `file_data`](https://docs.snort.org/rules/options/payload/file_data)
- [Registro de alertas](https://docs.snort.org/start/alert_logging)
- [Configuración de Snort 3](https://docs.snort.org/start/configuration)
- [Descarga de reglas oficiales y comunitarias](https://www.snort.org/downloads)
