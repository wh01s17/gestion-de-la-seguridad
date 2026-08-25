---
title: "Solución docente - Controles y defensa en profundidad, versión A"
tags: [nota, course, curso, docente, reservado]
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "03"
author: Jordy
start: 2026-08-24
end: 2026-08-25
created_at: "2026-08-07 11:56"
aliases:
  - "Solución docente - Controles y defensa en profundidad, versión A"
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
| La llave de la sala se guarda sin registro. | Servidores, equipos y soportes. | Una persona puede obtener acceso físico sin autorización trazable. | Alteración, retiro o interrupción de equipos. | Permitir el ingreso solo a personas autorizadas y conservar un registro revisable de cada acceso. |
| Dos portátiles no aparecen en el inventario ni en EDR. | Portátiles y datos que procesan. | Se desconoce su configuración y cobertura de protección. | Un equipo sin control puede facilitar ejecución o pérdida de información. | Identificar los diez equipos y demostrar que todos reportan al control definido. |
| Las alertas del correo no tienen responsable. | Cuentas, correo y datos asociados. | Una señal relevante puede no ser revisada ni atendida. | Un acceso anómalo puede continuar sin respuesta. | Asignar cada alerta relevante y demostrar que fue revisada por una persona responsable. |

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

| ID | Objetivo al que responde | Naturaleza | Función o funciones y mecanismo | Ubicación u operación, con frontera declarada |
| --- | --- | --- | --- | --- |
| C1 | Autorizar y hacer trazable cada visita a la sala. | Administrativa. | Preventiva al exigir autorización; detectiva si el registro se revisa para identificar excepciones. | Interna por ubicación y operación. |
| C2 | Impedir el ingreso no autorizado y registrar los intentos. | Física y técnica. | Preventiva al rechazar; detectiva al registrar; disuasiva por su presencia visible. | Interna por ubicación; puede ser externa por operación si la supervisa un proveedor. |
| C3 - ejemplo | Evitar que una contraseña robada sea suficiente para entrar al correo. | Técnica. | Preventiva: exige un segundo factor antes de autorizar el acceso. | Externa por operación si la aplica el proveedor cloud; la organización conserva la responsabilidad de exigirla y revisar su cobertura. |
| C4 | Detectar actividad maliciosa y contener el equipo afectado. | Técnica. | Detectiva al generar la alerta; correctiva al aislar después de la decisión autorizada. | Interna por los portátiles protegidos; la operación puede ser externa si la presta un tercero. |
| C5 | Conservar una copia utilizable si los sistemas habituales son afectados. | Técnica, con procedimiento administrativo asociado. | Preventiva frente al daño simultáneo al separar la copia; de recuperación cuando permite restaurar. | Interna si la copia y la prueba son operadas por la organización. |
| C6 | Restringir y atribuir el uso de la cuenta compartida mientras se habilitan cuentas individuales. | Administrativa y técnica. | Compensatoria porque sustituye temporalmente las cuentas individuales; preventiva por aprobación; detectiva por registro y revisión. | Interna por responsabilidad; la bóveda puede ser externa por operación. |
| C7 | Evitar aceptar cambios del formulario sin evidencia de seguridad. | Administrativa y técnica. | Preventiva si bloquea la publicación sin aprobación; detectiva si la revisión identifica defectos. | Externa por ejecución del proveedor e interna por aceptación y supervisión. |

## Parte C - Distinguir evidencia de efectividad

Una compra, un contrato o un documento pueden demostrar existencia o diseño, pero no prueban por sí solos que el control esté implementado, opere de manera constante o logre el resultado esperado.

Elijan **tres** de estos controles: EDR, respaldos, actualizaciones o desarrollo seguro del formulario. Completen una fila por control. Diseñen la prueba, pero **no la ejecuten** durante esta actividad.

| Control y objetivo | Evidencia de diseño | Evidencia de implementación | Evidencia de operación | Prueba no disruptiva de efectividad | Métrica sencilla |
| --- | --- | --- | --- | --- | --- |
| EDR: detectar actividad maliciosa y permitir contención autorizada. | Alcance de diez portátiles, alertas requeridas, responsable y acción esperada. | Los diez agentes aparecen activos y vinculados a la consola. | Alertas y casos del período muestran revisión y cierre. | Generar una señal admitida por el proveedor en un equipo autorizado y observar alerta y atención. | Porcentaje de cobertura y tiempo de atención. |
| Respaldos: conservar y recuperar un archivo utilizable. | Datos cubiertos, separación prevista, frecuencia y responsable de restaurar. | Copia presente en el repositorio separado y con acceso restringido. | Registros de ejecución y revisión periódica de fallos. | Restaurar un archivo controlado y comparar contenido y estado esperado. | Porcentaje de ejecuciones correctas y restauraciones exitosas. |
| Desarrollo seguro: aceptar cambios del formulario con evidencia verificable. | Requisitos de revisión de cambios, dependencias y pruebas antes de aceptar. | Contrato y flujo de entrega incorporan las evidencias requeridas. | Cada cambio relevante contiene revisión, resultados y decisión de aceptación. | Revisar una entrega controlada y comprobar que no se aprueba sin la evidencia exigida. | Porcentaje de cambios con evidencia completa antes de publicar. |

Pueden usar métricas de cobertura, oportunidad, calidad o resultado. “Se compró EDR” expresa una actividad; “10 de 10 portátiles reportan a la consola” mide cobertura.

## Parte D - Priorizar con CIS Controls v8.1

Seleccionen **cuatro acciones** de las partes anteriores y relaciónenlas con uno o más de los 18 CIS Controls v8.1 presentados en la guía. Distribúyanlas entre 30, 90 y 180 días; debe existir al menos una acción en cada horizonte.

| Acción priorizada | CIS Control relacionado | Horizonte | Dependencia o razón del orden | Responsable | Evidencia y métrica esperadas |
| --- | --- | :---: | --- | --- | --- |
| Conciliar los diez portátiles y su cobertura EDR. | 1, inventario de activos; 2, inventario de software; y 10, defensas contra malware. | 30 días | La visibilidad habilita cobertura y seguimiento posteriores. | Soporte. | Inventario conciliado y 10 de 10 equipos reportando. |
| Asignar la revisión de alertas y comprobar MFA en todas las cuentas de correo. | 5, gestión de cuentas; 6, control de acceso; y 8, registros de auditoría. | 30 días | Utiliza capacidades disponibles y atiende una exposición inmediata. | Administración del servicio cloud. | Cobertura MFA y porcentaje de alertas asignadas. |
| Separar una copia y realizar una restauración controlada. | 3, protección de datos; y 11, recuperación de datos. | 90 días | Requiere acordar alcance, acceso y responsable. | Soporte y dueño de los datos. | Copia protegida y restauración documentada. |
| Incorporar evidencia de desarrollo seguro a la aceptación de cambios. | 15, gestión de proveedores; y 16, seguridad del software de aplicaciones. | 180 días | Puede requerir ajustar el contrato y el flujo de entrega. | Responsable del servicio y proveedor. | Porcentaje de cambios con revisión, dependencias y resultados de prueba. |

No marquen los 18 controles por obligación. Seleccionen solo los pertinentes.

## Cierre individual

Cada integrante responde en dos o tres frases:

1. ¿Por qué “técnico” y “detectivo” no son clasificaciones opuestas?
   **Respuesta:** “Técnico” describe la naturaleza de la medida y “detectivo” describe su función. Un EDR puede ser técnico por su implementación y detectivo porque genera una alerta sobre un evento.
2. ¿Por qué un procedimiento aprobado o una herramienta instalada no demuestran por sí solos efectividad?
   **Respuesta:** El procedimiento demuestra definición y la instalación demuestra implementación puntual. La efectividad necesita una prueba o un resultado que permita comprobar el objetivo del control.
3. ¿Qué acción priorizaste primero y qué dato faltante podría hacerte cambiar el orden?
   **Respuesta:** Se priorizó conciliar el inventario y la cobertura EDR porque no se conocen dos portátiles y esa visibilidad habilita otras acciones. El tipo de datos procesados por esos equipos o una exposición directa comprobada podría cambiar el orden.
