---
title: "Solución docente - Controles y capas de protección, versión B"
tags: [nota, course, curso, docente, reservado]
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "03"
author: Jordy
start: 2026-08-24
end: 2026-08-25
created_at: 2026-08-12
aliases:
  - "Solución docente - Controles y capas de protección, versión B"
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

Conserven el ejemplo y seleccionen **otros tres hechos** del caso. No asignen probabilidades, niveles ni puntajes de riesgo.

| Hecho citado | Activo | Condición o vía de acceso | Consecuencia posible | Objetivo de control verificable |
| --- | --- | --- | --- | --- |
| Las alertas cloud llegan a un buzón general sin responsable ni revisión periódica. | Cuentas, archivos cloud y registros de actividad. | Una señal relevante puede no ser revisada ni atendida. | Un acceso o una descarga anómala puede continuar sin respuesta. | Asignar cada alerta relevante y demostrar que fue revisada y resuelta por una persona responsable. |
| La llave del gabinete cuelga en una bodega abierta y no se registra su uso. | Equipo de comunicaciones y servidor. | Una persona puede obtener acceso físico sin autorización trazable. | Alteración, desconexión o retiro de equipos. | Autorizar el ingreso y conservar evidencia revisable de cada apertura. |
| Un equipo temporal no aparece en el inventario ni en la consola de protección. | Computador temporal y datos procesados. | Se desconoce su configuración y cobertura de seguridad. | Un equipo sin control puede facilitar ejecución o pérdida de información. | Identificar los diez equipos y demostrar que todos reportan al control definido. |
| El respaldo permanece conectado y nunca se ha restaurado un documento de prueba. | Copias y documentos de reservas y facturación. | El mismo incidente puede alcanzar el servidor y la copia. | No disponer de datos utilizables para recuperar. | Mantener una copia protegida y demostrar que permite restaurar un documento controlado. |

Revisen cada objetivo con esta pregunta: **si el control funcionara, ¿qué resultado concreto podría comprobar otra persona?**

## Parte B - Clasificar sin mezclar dimensiones

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

| ID | Objetivo al que responde | Naturaleza | Función o funciones y mecanismo | Ubicación u operación, con frontera declarada |
| --- | --- | --- | --- | --- |
| B1 | Autorizar y hacer trazable el acceso de personal y contratistas al gabinete. | Administrativa. | Preventiva al exigir autorización; detectiva si el registro se revisa para identificar excepciones. | Interna por ubicación y operación. |
| B2 - ejemplo | Impedir el acceso no autorizado al gabinete y hacer visibles los intentos. | Física y técnica. | Preventiva al rechazar; detectiva al registrar; disuasiva por su presencia visible. | Interna por ubicación; puede ser externa por operación si un proveedor supervisa el sistema. |
| B3 | Evitar que una contraseña robada sea suficiente para acceder a la plataforma cloud. | Técnica. | Preventiva porque exige un segundo factor antes de autorizar. | Externa por operación cloud; interna por responsabilidad de exigir y revisar cobertura. |
| B4 | Detectar actividad maliciosa y contener el computador afectado. | Técnica. | Detectiva al generar una alerta; correctiva al poner en cuarentena después de la decisión autorizada. | Interna por los equipos protegidos; la operación puede ser externa si la presta un tercero. |
| B5 | Conservar una copia utilizable si el servidor o los equipos son afectados. | Técnica, con procedimiento administrativo asociado. | Preventiva frente al daño simultáneo al limitar escritura; de recuperación cuando permite restaurar. | Interna si la organización opera el dispositivo y la prueba. |
| B6 | Restringir y atribuir el uso de la cuenta compartida mientras se habilitan cuentas individuales. | Administrativa y técnica. | Compensatoria porque sustituye temporalmente las cuentas individuales; preventiva por aprobación; detectiva por registro y revisión. | Interna por responsabilidad; la bóveda puede ser externa por operación. |
| B7 | Evitar aceptar cambios del portal sin evidencia de seguridad. | Administrativa y técnica. | Preventiva si bloquea la publicación sin aprobación; detectiva si la revisión identifica defectos. | Externa por ejecución del proveedor e interna por aceptación y supervisión. |

Para B6 indiquen además por qué es **compensatorio**, cuál es el control preferido que todavía no puede aplicarse y cuándo debería revisarse la excepción. No es necesario calcular riesgo residual.

**Respuesta:** B6 es compensatorio porque sustituye temporalmente las cuentas administrativas individuales, que son el control preferido. La excepción debe revisarse mensualmente y terminar cuando el sistema heredado permita cuentas individuales o sea reemplazado.

## Parte C - Distinguir evidencia de efectividad

Una compra, un contrato o un documento pueden demostrar existencia o diseño, pero no prueban por sí solos que el control esté implementado, opere de manera constante o logre el resultado esperado.

Elijan **tres** de estos controles: protección de endpoint, respaldos, actualizaciones o desarrollo seguro del portal. Completen una fila por control. Diseñen la prueba, pero **no la ejecuten** durante esta actividad.

| Control y objetivo                                                                     | Evidencia de diseño                                                                       | Evidencia de implementación                                                     | Evidencia de operación                                                        | Prueba no disruptiva de efectividad                                                               | Métrica sencilla                                                |
| -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| Protección de endpoint: detectar actividad maliciosa y permitir cuarentena autorizada. | Alcance de diez equipos, alertas requeridas, responsable y acción esperada.               | Los diez agentes aparecen activos y vinculados a la consola.                    | Alertas y casos del período muestran revisión y cierre.                       | Generar una señal admitida por el proveedor en un equipo autorizado y observar alerta y atención. | Porcentaje de cobertura y tiempo de atención.                   |
| Respaldos: conservar y recuperar un documento utilizable.                              | Datos cubiertos, frecuencia y separación prevista, frecuencia y responsable de restaurar. | Copia presente, no disponible para escritura habitual y con acceso restringido. | Registros de ejecución y revisión periódica de fallos.                        | Restaurar un documento controlado y comparar contenido y estado esperado.                         | Porcentaje de ejecuciones correctas y restauraciones exitosas.  |
| Desarrollo seguro: aceptar cambios del portal con evidencia verificable.               | Requisitos de revisión de cambios, dependencias y pruebas antes de aceptar.               | Contrato y flujo de entrega incorporan las evidencias requeridas.               | Cada cambio relevante contiene revisión, resultados y decisión de aceptación. | Revisar una entrega controlada y comprobar que no se aprueba sin la evidencia exigida.            | Porcentaje de cambios con evidencia completa antes de publicar. |

Pueden usar métricas de cobertura, oportunidad, calidad o resultado. “Se contrató una plataforma” expresa una actividad; “10 de 10 equipos reportan y sus alertas tienen responsable” mide cobertura y operación.

## Parte E - Priorizar con CIS Controls v8.1

Seleccionen **cuatro acciones** de las partes anteriores y relaciónenlas con uno o más de los 18 CIS Controls v8.1 presentados en la guía. Distribúyanlas entre 30, 90 y 180 días; debe existir al menos una acción en cada horizonte.

| Acción priorizada                                                        | CIS Control relacionado                                                             | Horizonte | Dependencia o razón del orden                                       | Responsable                           | Evidencia y métrica esperadas                                            |
| ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------- | :-------: | ------------------------------------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------ |
| Conciliar los diez equipos y su cobertura de endpoint.                   | 1, inventario de activos; 2, inventario de software; y 10, defensas contra malware. |  30 días  | La visibilidad habilita cobertura y seguimiento posteriores.        | Soporte.                              | Inventario conciliado y 10 de 10 equipos reportando.                     |
| Asignar alertas cloud y comprobar MFA en todas las cuentas.              | 5, gestión de cuentas; 6, control de acceso; y 8, registros de auditoría.           |  30 días  | Utiliza capacidades disponibles y atiende una exposición inmediata. | Administración cloud.                 | Cobertura MFA y porcentaje de alertas asignadas.                         |
| Proteger una copia y realizar una restauración controlada.               | 3, protección de datos; y 11, recuperación de datos.                                |  90 días  | Requiere acordar alcance, acceso y responsable.                     | Soporte y dueño de los datos.         | Copia protegida y restauración documentada.                              |
| Incorporar evidencia de desarrollo seguro a la aceptación del proveedor. | 15, gestión de proveedores; y 16, seguridad del software de aplicaciones.           | 180 días  | Puede requerir ajustar el contrato y el flujo de entrega.           | Responsable del servicio y proveedor. | Porcentaje de cambios con revisión, dependencias y resultados de prueba. |

No marquen los 18 controles por obligación. Seleccionen solo los pertinentes.

## Cierre

1. ¿Cómo puede un mismo control ser físico, preventivo y detectivo sin contradicción?
   >**Respuesta:** Una cerradura electrónica es física por naturaleza, preventiva al negar el paso y detectiva al registrar intentos. Las dimensiones responden preguntas diferentes y pueden coexistir.

2. ¿Qué diferencia existe entre un registro que demuestra operación y una prueba que aporta evidencia de efectividad?
   >**Respuesta:** El registro muestra que el control se ejecutó durante un período. La prueba compara su resultado con el objetivo y aporta evidencia de que produjo el efecto esperado.

3. ¿Qué acción priorizaste primero y qué dato faltante podría hacerte cambiar el orden?
   >**Respuesta:** Se priorizó conciliar los equipos y la cobertura porque existe uno fuera de inventario y esa visibilidad habilita otros controles. Una exposición comprobada del portal o la sensibilidad de los datos del equipo podría cambiar el orden.
