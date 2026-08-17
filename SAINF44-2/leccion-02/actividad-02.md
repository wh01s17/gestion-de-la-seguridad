---
title: "Actividad 02 - Triage de vectores de ataque"
tags: [nota, course, curso]
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "02"
author: Jordy
start: 2026-08-17
end: 2026-08-18
created_at: 2026-08-12
aliases:
  - "Actividad 02 - Triage de vectores de ataque"
---
# Actividad 02 - Triage de vectores de ataque

**Duración:** 80 minutos. 
**Modalidad:** parejas. 
**Carácter:** formativo, sin calificación. 
**Versión:** B. 
**Aplicación prevista:** SAINF44-2, jornada vespertina.

## Propósito

Distinguir vector, amenaza, vulnerabilidad y consecuencia; justificar una clasificación y realizar un triage inicial. La lista de 13 vectores es una agrupación pedagógica del programa, no una taxonomía oficial universal.

## Recordatorio para resolver la actividad

| Concepto | Pregunta para reconocerlo | Ejemplo breve |
| --- | --- | --- |
| Activo | ¿Qué recurso con valor se quiere proteger? | Una cuenta, un dispositivo o datos de clientes. |
| Amenaza | ¿Qué actor, evento o circunstancia podría causar daño? | Un tercero no autorizado, un error o una cuenta comprometida. |
| Vector | ¿Por qué vía o mecanismo se alcanza el activo? | Un correo engañoso o un servicio público. |
| Vulnerabilidad o condición | ¿Qué debilidad o situación permite o facilita el hecho? | Una contraseña predeterminada o la ausencia de bloqueo. |
| Consecuencia | ¿Qué podría ocurrirle al activo? | Divulgación, modificación, fraude o interrupción. |
| Control inicial | ¿Qué medida responde directamente a la condición? | Cambiar una credencial predeterminada. |
| Evidencia de funcionamiento | ¿Qué registro o prueba permitiría comprobar el control? | Una configuración revisada o una prueba autorizada. |

### Consulta rápida de los 13 vectores

| Vector | Pregunta para reconocerlo |
| --- | --- |
| Phishing | ¿El engaño llegó mediante un mensaje o servicio? |
| Ingeniería social | ¿Se manipuló a una persona o proceso? |
| Malware | ¿Se utilizó código para realizar acciones no autorizadas? |
| Aplicación web | ¿La vía depende de una debilidad de una aplicación web o API? |
| Credenciales | ¿Se obtuvo, adivinó o abusó una identidad o sesión? |
| Servicio expuesto | ¿El activo era accesible desde una red no confiable? |
| Configuración insegura | ¿Un parámetro o permiso aumentó la exposición? |
| Amenaza interna | ¿El acceso legítimo o aparentemente interno habilitó el hecho? |
| Terceros y cadena de suministro | ¿Una dependencia externa introdujo acceso, software o datos? |
| Dispositivo móvil | ¿Un teléfono o tableta y su contexto son la vía dominante? |
| Red inalámbrica | ¿La conectividad inalámbrica habilitó el acceso? |
| Medio removible | ¿Un soporte trasladó datos o código? |
| Ataque físico | ¿Se intervino una instalación, equipo o soporte material? |

Para completar cada fila, sigan la misma ruta: **citen el hecho → separen activo y amenaza → elijan el vector → identifiquen la condición → indiquen una consecuencia posible**. Un caso puede combinar vectores; la justificación basada en el hecho es más importante que memorizar una única etiqueta.

## Casos

| ID | Situación |
| --- | --- |
| B1 | Una persona convence a soporte para restablecer la contraseña de otra cuenta sin verificar su identidad. |
| B2 | Un correo con una factura falsa induce a habilitar macros que ejecutan código malicioso. |
| B3 | Un panel administrativo permanece en Internet con depuración activa y credenciales predeterminadas. |
| B4 | Un contratista con acceso autorizado sincroniza datos de clientes con una nube personal. |
| B5 | Un pendrive desconocido conectado en recepción intenta ejecutar contenido automáticamente. |
| B6 | Una tableta corporativa sin bloqueo se extravía durante un viaje. |
| B7 | Personas se conectan a una red Wi-Fi falsa que imita el nombre de la red corporativa. |
| B8 | Una API entrega el registro de otro cliente cuando se modifica el identificador de la solicitud. |

## Parte A - Clasificar con evidencia

Completen una fila por caso. El hecho citado debe explicar la clasificación; no basta con escribir una etiqueta.

| ID  | Hecho o técnica que respalda la clasificación                                  | Activo y amenaza, diferenciados                                                | Vector principal | Vector secundario posible | Vulnerabilidad o condición               | Consecuencia posible                          |
| --- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ---------------- | ------------------------- | ---------------------------------------- | --------------------------------------------- |
| B1  |                                                                                |                                                                                |                  |                           |                                          |                                               |
| B2  | Un correo con una factura falsa induce a habilitar macros que ejecutan código. | Activos: equipo y datos. Amenaza: actor que distribuye el documento malicioso. | Phishing         | Malware                   | Ejecución de macros inducida por engaño. | Ejecución de código o pérdida de información. |
| B3  |                                                                                |                                                                                |                  |                           |                                          |                                               |
| B4  |                                                                                |                                                                                |                  |                           |                                          |                                               |
| B5  |                                                                                |                                                                                |                  |                           |                                          |                                               |
| B6  |                                                                                |                                                                                |                  |                           |                                          |                                               |
| B7  |                                                                                |                                                                                |                  |                           |                                          |                                               |
| B8  |                                                                                |                                                                                |                  |                           |                                          |                                               |

## Parte B - Relacionar un control

Para **B2, B3, B6 y B8**, propongan un control inicial que responda directamente a la condición y una evidencia que permita verificarlo.

| ID  | Control inicial                                               | Condición que reduce                            | Evidencia de funcionamiento                                                 |
| --- | ------------------------------------------------------------- | ----------------------------------------------- | --------------------------------------------------------------------------- |
| B2  | Bloquear macros no autorizadas y filtrar el mensaje engañoso. | Ejecución inducida desde un documento recibido. | Política efectiva y resultado de una prueba controlada de bloqueo o alerta. |
| B3  |                                                               |                                                 |                                                                             |
| B6  |                                                               |                                                 |                                                                             |
| B8  |                                                               |                                                 |                                                                             |

Para B8, indiquen además una categoría [OWASP](https://owasp.org/Top10/2025/) pertinente. Expliquen en una frase por qué la categoría orienta la comunicación, pero no demuestra por sí sola la existencia de la vulnerabilidad.

## Parte C - Triage inicial

Seleccionen **dos** casos que atenderían primero en una empresa pequeña. Justifiquen el orden usando únicamente:

- la exposición descrita en el caso;
- la consecuencia posible para el activo;
- la posibilidad de aplicar una medida inicial inmediata.

Para cada caso, declaren un dato faltante que podría cambiar el orden. No deben calcular probabilidad, construir una matriz de riesgo, estimar riesgo residual ni clasificar formalmente los controles: esos contenidos se estudiarán después.

| Orden | Caso | Justificación con los criterios indicados |
| ----: | ---- | ----------------------------------------- |
|     1 |      |                                           |
|     2 |      |                                           |

## Parte D - Cierre individual

Cada integrante responde en dos o tres frases:

1. ¿En qué se diferencian vector y vulnerabilidad?
2. ¿Por qué pueden coexistir un vector principal y uno secundario?
3. ¿Por qué una categoría OWASP no reemplaza la evidencia del caso?
