---
title: "Actividad - Afinar una regla IDS con Snort"
tags:
  - nota
  - course
  - curso
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "05"
author: Jordy
start: 2026-09-07
end: 2026-09-08
created_at: 2026-09-05
aliases:
  - "Actividad Lección 05 - Afinar una regla IDS con Snort"
---
# Actividad - Afinar una regla IDS con Snort

**Duración:** 55 minutos.
**Modalidad:** trabajo en parejas.
**Carácter:** formativo, sin calificación.
**Entorno:** VM `SENSOR-LAB`, sin conexión de red. Todo el análisis se realiza sobre una captura guardada.

## Propósito

Completar y validar una regla básica de Snort, comprobarla con tráfico positivo y negativo, y relacionar su alerta con los registros de AAA, firewall y accounting.

## Caso: servicio web de PUERTO SEGURO

PUERTO SEGURO utiliza el servicio interno `WEB-LAB` (`10.10.20.5:80`). El firewall permite el acceso desde la red de administración `10.10.10.0/24` y el IDS observa una copia del tráfico después del firewall.

El script de mantención incluye el marcador `UA1-LAB` en sus solicitudes. Seguridad quiere una alerta cuando ese marcador viaje **desde la red autorizada hacia el servidor**.

La regla actual busca `LOGIN` en ambos sentidos:

```text
alert tcp any any <> 10.10.20.5 80 (msg:"INF44 L05 patrón LOGIN amplio"; content:"LOGIN"; sid:1000101; rev:1;)
```

Por eso alerta ante tráfico que no interesa y no detecta el marcador solicitado.

## Recordatorio para resolver

| Concepto | Idea clave |
| --- | --- |
| IDS | Observa y alerta; no bloquea el tráfico. |
| `->` | Revisa el tráfico solo en la dirección indicada. |
| `content` | Busca una cadena dentro de los datos del paquete. |
| Falso positivo | Alerta ante tráfico que no se quería detectar. |
| Falso negativo | No alerta ante tráfico que sí se quería detectar. |
| Correlación | Une la alerta con otros registros para entender el contexto. |

La captura contiene cinco casos conocidos:

| Caso | Tráfico | Contenido | Resultado esperado con la regla ajustada |
| --- | --- | --- | --- |
| P1 | cliente `41001` → servidor `80` | `UA1-LAB` dentro de `POST /demo` | Una alerta |
| P2 | cliente `41002` → servidor `80` | `GET /status` | Sin alerta |
| P3 | cliente `41003` → servidor `80` | `GET /LOGIN-help` | Sin alerta |
| P4 | servidor `80` → cliente `41004` | `LOGIN complete` | Sin alerta |
| P5 | servidor `80` → cliente `41005` | `UA1-LAB` en la respuesta | Sin alerta |

P5 contiene el mismo marcador que P1, pero viaja en sentido contrario. Solo se pide alertar cuando el marcador va **hacia** el servidor.

## Preparación

Estos pasos están incluidos en los 10 minutos de la Parte A.

Entra a la carpeta `material/` y ejecuta:

```bash
sha256sum -c manifest_entrega.sha256
cp regla_inicial.rules local_l05.rules
SNORT_CONFIG_L05=/usr/local/etc/snort/snort.lua
```

Los seis archivos del manifiesto deben indicar `OK`. Si aparece `FAILED`, detente y avisa al docente.

La VM ya trae `snort.lua` preparado para esta actividad. No lo modifiques ni agregues opciones distintas a los comandos indicados.

Trabaja solo sobre `local_l05.rules`; no modifiques la regla original.

## Parte A - Diagnosticar la regla inicial

Primero valida que la regla esté bien escrita:

```bash
snort -c "$SNORT_CONFIG_L05" -R local_l05.rules -T
```

Después ejecútala sobre la captura:

```bash
snort -q -c "$SNORT_CONFIG_L05" -R local_l05.rules \
  -r trafico_l05.pcap -A alert_fast
```

La regla inicial genera alertas en P3 y P4, pero no en P1. Completa:

| Caso | ¿Qué ocurrió? | ¿Por qué? | Clasificación |
| --- | --- | --- | --- |
| P1 | No alertó | | Falso negativo |
| P3 | Alertó | | Falso positivo |
| P4 | Alertó | | Falso positivo |

Usa estas pistas:

- `content:"LOGIN"` también coincide dentro de `LOGIN-help`;
- `<>` revisa cliente → servidor y servidor → cliente;
- la regla inicial nunca busca `UA1-LAB`.

## Parte B - Completar la regla

Edita `local_l05.rules` y completa los cuatro espacios:

```text
alert tcp __________ any -> __________ 80 (msg:"INF44 L05 marcador UA1-LAB"; flow:to_server,established; content:"__________"; sid:1000101; rev:____;)
```

Tu regla debe:

1. usar como origen `10.10.10.0/24`;
2. usar como destino `10.10.20.5`;
3. buscar el marcador `UA1-LAB`;
4. conservar el `sid:1000101` y aumentar `rev` a `2`.

`flow:to_server,established` indica que se revisan solicitudes hacia el servidor dentro de una conexión TCP establecida.

## Parte C - Validar y probar

Repite la validación y el análisis:

```bash
snort -c "$SNORT_CONFIG_L05" -R local_l05.rules -T
snort -q -c "$SNORT_CONFIG_L05" -R local_l05.rules \
  -r trafico_l05.pcap -A alert_fast
```

El resultado correcto es **una alerta en P1 y ninguna en P2, P3, P4 ni P5**.

Completa `matriz_pruebas.csv`. Registra lo observado, si coincide con lo esperado y la evidencia breve que utilizaste. No inventes resultados: si algo no coincide, anótalo y solicita apoyo.

> [!IMPORTANT] Validar sintaxis no basta
> `-T` demuestra que Snort pudo cargar la regla. Las pruebas P1 a P5 permiten comprobar si la regla hace lo solicitado en esta captura.

> [!TIP] Qué prueba cada caso
> Si alertas en P5, tu regla encontró el marcador pero todavía revisa los dos sentidos: revisa `->` y `flow:to_server,established`. P2 y P3 comprueban el contenido; P4 y P5 comprueban la dirección.

## Parte D - Integrar los controles

Revisa los eventos del caso:

```bash
cat contexto_controles.csv
cat registros_l05.csv
```

Completa en `matriz_pruebas.csv` las columnas `firewall`, `aaa_o_accounting` y `conclusion` para P1 y P3.

Considera:

- En P1, el firewall permitió el origen, AAA registra una sesión de `soporte01` y accounting relaciona esa cuenta con `POST /demo`.
- En P3, el firewall permitió el origen, pero el registro indica `sin sesion asociada`.
- Una alerta del IDS por sí sola no identifica a una persona.

Luego responde en una frase:

**¿Por qué la conexión denegada por el firewall a las 10:02:35 no aparece en la captura del IDS?**

## Cierre individual

Responde con una o dos frases por pregunta:

1. ¿Qué cambiaste en la regla y qué demostraron P1 a P5?
2. ¿Por qué la regla inicial producía falsos positivos?
3. ¿Qué no puedes afirmar después de probar solo cinco casos conocidos?
4. ¿Qué dato adicional necesitas para atribuir una alerta a una persona?

## Lista de cotejo

- [ ] Conservé `regla_inicial.rules` sin cambios.
- [ ] Expliqué el falso negativo de P1 y los falsos positivos de P3 y P4.
- [ ] Completé una regla válida con `sid:1000101` y `rev:2`.
- [ ] Obtuve una alerta en P1 y ninguna en P2, P3, P4 ni P5.
- [ ] Registré las pruebas en `matriz_pruebas.csv`.
- [ ] Relacioné P1 y P3 con firewall y accounting sin inventar atribuciones.
- [ ] Completé el cierre individual.

Si Snort no funciona después de cinco minutos de revisión, solicita al docente las salidas de contingencia y márcalas como `simuladas`.
