---
title: Actividad - Diseñar controles y defensa en profundidad
tags:
  - nota
  - course
  - curso
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "03"
author: Jordy
start: 2026-08-24
end: 2026-08-25
created_at: 2026-08-07 11:56
aliases:
  - Actividad - Diseñar controles y defensa en profundidad
---
# Actividad - Diseñar controles y defensa en profundidad

**Duración:** 80 minutos.  
**Modalidad:** equipos de 3 integrantes.  
**Carácter:** formativo, sin calificación. No se asignará puntaje; el producto se utilizará para retroalimentar el aprendizaje.  
**Versión:** A.  
**Aplicación prevista:** SAINF44-1, jornada diurna.

## Propósito

Seleccionar controles para condiciones concretas de una sede pequeña, clasificarlos en dimensiones independientes, proponer evidencia verificable y organizarlos como defensa en profundidad y como una prioridad inicial apoyada en CIS Controls v8.1.

## Caso: sede de CALA NORTE SPA

CALA NORTE SPA presta servicios administrativos desde una sede pequeña. La organización dispone de recepción, oficina administrativa, sala de servidores, Wi-Fi corporativo y de invitados, diez portátiles, correo en la nube, un repositorio de respaldos y un formulario web mantenido por un proveedor.

Durante una revisión inicial se observan estos hechos:

1. La recepción está abierta al público. La llave de la sala de servidores se guarda en un cajón y no existe registro de quién la utiliza.
2. El Wi-Fi corporativo y el de invitados usan el mismo equipo de red. Se afirma que están separados, pero no existe un diagrama ni una prueba que lo demuestre.
3. Una planilla registra ocho portátiles, aunque en la sede hay diez. Ocho equipos aparecen activos en la consola EDR; no se conoce el estado de los otros dos.
4. El correo en la nube posee filtro, registros de inicio de sesión y alertas. Nadie tiene asignada la revisión de esas alertas.
5. Soporte utiliza una cuenta administrativa compartida en una aplicación heredada. La aplicación todavía no admite cuentas individuales.
6. Existe un procedimiento de actualización aprobado, pero no hay registros que permitan saber qué equipos fueron actualizados ni cuándo.
7. Los respaldos se ejecutan cada noche en un repositorio que permanece conectado. Nunca se ha intentado restaurar un archivo de prueba.
8. Un proveedor mantiene el formulario web. El contrato no solicita evidencia de revisión de código, control de dependencias ni pruebas de seguridad antes de publicar cambios.

## Recordatorio para resolver

| Dimensión | Pregunta que deben responder |
| --- | --- |
| Objetivo de control | ¿Qué resultado verificable se busca frente a una condición concreta? |
| Naturaleza | ¿La medida es administrativa, técnica o física? |
| Función | ¿Previene, detecta, corrige, disuade, compensa o permite recuperar? |
| Ubicación | ¿Es interna o externa según la frontera declarada? ¿Quién la opera? |
| Evidencia | ¿Qué demuestra su diseño, implementación, operación o efectividad? |

Una clasificación necesita mecanismo y evidencia. Es mejor escribir “es detectivo porque genera una alerta que revisa una persona responsable” que limitarse a la etiqueta “detectivo”.

## Parte A - Del hecho al objetivo de control

Conserven el ejemplo y seleccionen **otros tres hechos** del caso. No asignen probabilidades, niveles ni puntajes de riesgo.

| Hecho citado | Activo | Condición o vía de acceso | Consecuencia posible | Objetivo de control verificable |
| --- | --- | --- | --- | --- |
| El repositorio de respaldos permanece conectado y nunca se ha probado una restauración. | Respaldos y datos administrativos. | Un incidente que alcance los sistemas podría afectar también las copias conectadas. | No disponer de una copia utilizable para recuperar datos. | Mantener una copia protegida del mismo incidente y demostrar que permite restaurar un archivo controlado. |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

Revisen cada objetivo con esta pregunta: **si el control funcionara, ¿qué resultado concreto podría comprobar otra persona?**

## Parte B - Clasificar sin mezclar dimensiones

Clasifiquen los siete controles propuestos. Pueden asignar más de una naturaleza o función cuando el control combine mecanismos, pero deben justificar cada etiqueta. Para “interno” o “externo”, declaren si hablan de ubicación o de quién lo opera.

| ID | Control propuesto |
| --- | --- |
| C1 | Procedimiento de autorización de visitas a la sala, con responsable y registro de entrada y salida. |
| C2 | Cerradura electrónica visible que rechaza accesos no autorizados y registra cada intento. |
| C3 | MFA obligatorio para todas las cuentas del correo en la nube. |
| C4 | EDR con cobertura de los diez portátiles, alerta dirigida a una persona responsable y aislamiento autorizado del equipo. |
| C5 | Copia de respaldo separada del acceso habitual y restauración periódica de un archivo controlado. |
| C6 | Mientras se reemplaza la cuenta compartida, contraseña custodiada en una bóveda, aprobación de cada uso, rotación y registro de actividad. |
| C7 | Requisito al proveedor para entregar evidencia de revisión de cambios, dependencias y pruebas de seguridad antes de publicar el formulario. |

| ID           | Objetivo al que responde                                               | Naturaleza | Función o funciones y mecanismo                                   | Ubicación u operación, con frontera declarada                                                                                          |
| ------------ | ---------------------------------------------------------------------- | ---------- | ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| C1           |                                                                        |            |                                                                   |                                                                                                                                        |
| C2           |                                                                        |            |                                                                   |                                                                                                                                        |
| C3 - ejemplo | Evitar que una contraseña robada sea suficiente para entrar al correo. | Técnica.   | Preventiva: exige un segundo factor antes de autorizar el acceso. | Externa por operación si la aplica el proveedor cloud; la organización conserva la responsabilidad de exigirla y revisar su cobertura. |
| C4           |                                                                        |            |                                                                   |                                                                                                                                        |
| C5           |                                                                        |            |                                                                   |                                                                                                                                        |
| C6           |                                                                        |            |                                                                   |                                                                                                                                        |
| C7           |                                                                        |            |                                                                   |                                                                                                                                        |

## Parte C - Distinguir evidencia de efectividad

Una compra, un contrato o un documento pueden demostrar existencia o diseño, pero no prueban por sí solos que el control esté implementado, opere de manera constante o logre el resultado esperado.

Elijan **tres** de estos controles: EDR, respaldos, actualizaciones o desarrollo seguro del formulario. Completen una fila por control. Diseñen la prueba, pero **no la ejecuten** durante esta actividad.

| Control y objetivo | Evidencia de diseño | Evidencia de implementación | Evidencia de operación | Prueba no disruptiva de efectividad | Métrica sencilla |
| ------------------ | ------------------- | --------------------------- | ---------------------- | ----------------------------------- | ---------------- |
|                    |                     |                             |                        |                                     |                  |
|                    |                     |                             |                        |                                     |                  |
|                    |                     |                             |                        |                                     |                  |

Pueden usar métricas de cobertura, oportunidad, calidad o resultado. “Se compró EDR” expresa una actividad; “10 de 10 portátiles reportan a la consola” mide cobertura.

## Parte D - Priorizar con CIS Controls v8.1

Seleccionen **cuatro acciones** de las partes anteriores y relaciónenlas con uno o más de los 18 CIS Controls v8.1 presentados en la guía. Distribúyanlas entre 30, 90 y 180 días; debe existir al menos una acción en cada horizonte.

| Acción priorizada | CIS Control relacionado | Horizonte | Dependencia o razón del orden | Responsable | Evidencia y métrica esperadas |
| ----------------- | ----------------------- | :-------: | ----------------------------- | ----------- | ----------------------------- |
|                   |                         |  30 días  |                               |             |                               |
|                   |                         |  90 días  |                               |             |                               |
|                   |                         | 180 días  |                               |             |                               |

No marquen los 18 controles por obligación. Seleccionen solo los pertinentes y recuerden que CIS Controls v8.1 contiene 18 controles.

## Cierre individual

Cada integrante responde en dos o tres frases:

1. ¿Por qué “técnico” y “detectivo” no son clasificaciones opuestas?
2. ¿Por qué un procedimiento aprobado o una herramienta instalada no demuestran por sí solos efectividad?
3. ¿Qué acción priorizaste primero y qué dato faltante podría hacerte cambiar el orden?
