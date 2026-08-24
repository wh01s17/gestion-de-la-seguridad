---
title: "Actividad 02 - Evaluar controles y construir capas de protección"
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
created_at: 2026-08-12
aliases:
  - "Actividad 02 - Evaluar controles y construir capas de protección"
---
# Actividad 02 - Evaluar controles y construir capas de protección

**Duración:** 80 minutos.  
**Modalidad:** equipos de 3 integrantes.  
**Carácter:** formativo, sin calificación. No se asignará puntaje; el producto se utilizará para retroalimentar el aprendizaje.  
**Versión:** B.
**Aplicación prevista:** SAINF44-2, jornada vespertina.

## Propósito

Seleccionar controles para condiciones concretas de una oficina de servicios, clasificarlos en dimensiones independientes, proponer evidencia verificable y organizarlos como defensa en profundidad y como una prioridad inicial apoyada en CIS Controls v8.1.

## Caso: oficina de PUERTO CLARO SPA

PUERTO CLARO SPA administra reservas y facturación desde una oficina pequeña. Dispone de un mesón de atención, área de operaciones, oficina de administración, gabinete de comunicaciones, Wi-Fi corporativo y para visitantes, diez computadores, colaboración en la nube, respaldos y un portal de reservas mantenido por un proveedor.

Durante una revisión inicial se observan estos hechos:

1. El mesón recibe público y proveedores. La llave del gabinete de comunicaciones cuelga dentro de una bodega abierta y no se registra su uso.
2. Las redes inalámbricas corporativa y de visitantes utilizan el mismo punto de acceso. El proveedor afirma que están aisladas, pero no entregó un diagrama ni resultados de una prueba.
3. El inventario contiene nueve computadores. Un equipo temporal tampoco aparece en la consola de protección de endpoint.
4. La plataforma cloud genera alertas por inicios de sesión y descarga masiva. Estas llegan a un buzón general que no tiene responsable ni revisión periódica.
5. El sistema heredado de facturación solo permite una cuenta administrativa, cuya contraseña conoce todo el equipo de soporte.
6. Existe una instrucción para actualizar los equipos cada mes, pero no se conserva el resultado de cada ejecución ni las excepciones.
7. Los respaldos se copian a un dispositivo que permanece conectado al servidor. Nunca se ha restaurado un documento de prueba.
8. El proveedor publica cambios en el portal de reservas sin entregar evidencia de revisión de cambios, dependencias o pruebas de seguridad.

## Recordatorio para resolver

| Dimensión | Pregunta que deben responder |
| --- | --- |
| Objetivo de control | ¿Qué resultado verificable se busca frente a una condición concreta? |
| Naturaleza | ¿La medida es administrativa, técnica o física? |
| Función | ¿Previene, detecta, corrige, disuade, compensa o permite recuperar? |
| Ubicación | ¿Es interna o externa según la frontera declarada? ¿Quién la opera? |
| Evidencia | ¿Qué demuestra su diseño, implementación, operación o efectividad? |

Una clasificación necesita mecanismo y evidencia. Es mejor escribir “es correctivo porque aísla el equipo después de validar una alerta” que limitarse a la etiqueta “correctivo”.

## Parte A - Del hecho al objetivo de control

Conserven el ejemplo y seleccionen **tres hechos** del caso. No asignen probabilidades, niveles ni puntajes de riesgo.

| Hecho citado | Activo | Condición o vía de acceso | Consecuencia posible | Objetivo de control verificable |
| --- | --- | --- | --- | --- |
| Las alertas cloud llegan a un buzón general sin responsable ni revisión periódica. | Cuentas, archivos cloud y registros de actividad. | Una señal relevante puede no ser revisada ni atendida. | Un acceso o una descarga anómala puede continuar sin respuesta. | Asignar cada alerta relevante y demostrar que fue revisada y resuelta por una persona responsable. |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

Revisen cada objetivo con esta pregunta: **si el control funcionara, ¿qué resultado concreto podría comprobar otra persona?**

## Parte B - Clasificar

Clasifiquen los siete controles propuestos. Pueden asignar más de una naturaleza o función cuando el control combine mecanismos, pero deben justificar cada etiqueta. Para “interno” o “externo”, declaren si hablan de ubicación o de quién lo opera.

| ID | Control propuesto |
| --- | --- |
| B1 | Procedimiento de autorización de personal y contratistas que acceden al gabinete, con responsable y registro de entrada y salida. |
| B2 | Gabinete con cerradura electrónica visible, sensor de apertura y registro de cada intento. |
| B3 | MFA obligatorio para todas las cuentas de colaboración en la nube. |
| B4 | Protección de endpoint en los diez computadores, alertas asignadas y cuarentena autorizada del equipo. |
| B5 | Copia de respaldo no disponible para escritura habitual y restauración periódica de un documento controlado. |
| B6 | Mientras el sistema no permita cuentas individuales, contraseña en una bóveda, aprobación por uso, rotación y revisión del registro. |
| B7 | Requisito de aceptación para que el proveedor entregue evidencia de revisión de cambios, dependencias y pruebas de seguridad del portal. |

| ID           | Objetivo al que responde                                                   | Naturaleza        | Función o funciones y mecanismo                                                     | Ubicación u operación, con frontera declarada                                                |
| ------------ | -------------------------------------------------------------------------- | ----------------- | ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| B1           |                                                                            |                   |                                                                                     |                                                                                              |
| B2 - ejemplo | Impedir el acceso no autorizado al gabinete y hacer visibles los intentos. | Física y técnica. | Preventiva al rechazar; detectiva al registrar; disuasiva por su presencia visible. | Interna por ubicación; puede ser externa por operación si un proveedor supervisa el sistema. |
| B3           |                                                                            |                   |                                                                                     |                                                                                              |
| B4           |                                                                            |                   |                                                                                     |                                                                                              |
| B5           |                                                                            |                   |                                                                                     |                                                                                              |
| B6           |                                                                            |                   |                                                                                     |                                                                                              |
| B7           |                                                                            |                   |                                                                                     |                                                                                              |

Para B6 indiquen además por qué es **compensatorio**, cuál es el control preferido que todavía no puede aplicarse y cuándo debería revisarse la excepción. No es necesario calcular riesgo residual.

## Parte C - Distinguir evidencia de efectividad

Una compra, un contrato o un documento pueden demostrar existencia o diseño, pero no prueban por sí solos que el control esté implementado, opere de manera constante o logre el resultado esperado.

Elijan **2** de estos controles: protección de endpoint, respaldos, actualizaciones o desarrollo seguro del portal. Completen una fila por control. Diseñen la prueba, pero **no la ejecuten** durante esta actividad.

| Control y objetivo                                                                     | Evidencia de diseño                                                         | Evidencia de implementación                                  | Evidencia de operación                                  | Prueba no disruptiva de efectividad                                                               | Métrica                                       |
| -------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| Protección de endpoint: detectar actividad maliciosa y permitir cuarentena autorizada. | Alcance de diez equipos, alertas requeridas, responsable y acción esperada. | Los diez agentes aparecen activos y vinculados a la consola. | Alertas y casos del período muestran revisión y cierre. | Generar una señal admitida por el proveedor en un equipo autorizado y observar alerta y atención. | Porcentaje de cobertura y tiempo de atención. |
|                                                                                        |                                                                             |                                                              |                                                         |                                                                                                   |                                               |
|                                                                                        |                                                                             |                                                              |                                                         |                                                                                                   |                                               |


Pueden usar métricas de cobertura, oportunidad, calidad o resultado. “Se contrató una plataforma” expresa una actividad; “10 de 10 equipos reportan y sus alertas tienen responsable” mide cobertura y operación.

## Parte D - Priorizar con CIS Controls v8.1

Seleccionen **cuatro acciones** de las partes anteriores y relaciónenlas con uno o más de los 18 CIS Controls v8.1 presentados en la guía. Distribúyanlas entre 30, 90 y 180 días; debe existir al menos una acción en cada horizonte.

| Acción priorizada | CIS Control relacionado | Horizonte | Dependencia o razón del orden | Responsable | Evidencia y métrica esperadas |
| ----------------- | ----------------------- | :-------: | ----------------------------- | ----------- | ----------------------------- |
|                   |                         |  30 días  |                               |             |                               |
|                   |                         |  90 días  |                               |             |                               |
|                   |                         | 180 días  |                               |             |                               |

No marquen los 18 controles por obligación. Seleccionen solo los pertinentes.

## Cierre

1. ¿Cómo puede un mismo control ser físico, preventivo y detectivo sin contradicción?
2. ¿Qué diferencia existe entre un registro que demuestra operación y una prueba que aporta evidencia de efectividad?
3. ¿Qué acción priorizaste primero y qué dato faltante podría hacerte cambiar el orden?
