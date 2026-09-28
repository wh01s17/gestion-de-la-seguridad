---
title: "Actividad Lección 08 - Mesa de selección metodológica"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "08"
author: Jordy
start: 2026-09-28
end: 2026-09-29
created_at: 2026-09-26
aliases:
  - "Actividad Lección 08 - Mesa de selección metodológica"
---

# Actividad Lección 08 - Mesa de selección metodológica

- **Duración estimada:** 90 minutos.
- **Caso:** `PR-2027-01` - PACÍFICO RETAIL SPA (ficticia), continuación de la Lección 07.
- **Carácter:** formativo, sin calificación.
- **Producto:** este mismo archivo completado. Es para su propio trabajo y la discusión en clase; no se entrega.

## Pregunta del caso

La Lección 07 acotó el alcance y fijó criterios para el análisis. La gerencia ahora pide decidir **cómo** se sostendrá el trabajo de riesgo con una persona de seguridad a media jornada.

> ¿Qué proceso ordenará el ciclo completo, qué apoyo se usará para evaluar escenarios y cómo se comunicará el resultado?

Una guía de evaluación no cubre por sí sola el tratamiento, la aceptación y el seguimiento. En esta lección no se asignan niveles de riesgo ni se decide qué tratamiento ejecutar primero: esas decisiones corresponden a las lecciones 09 y 10.

## Estado del caso al comenzar la Lección 08

Este bloque contiene las decisiones vigentes después de la Lección 07. Reemplaza las carencias descritas en el perfil original del caso.

### Alcance vigente

| Elemento | Decisión consolidada |
| --- | --- |
| Objetivo | Establecer los criterios y propietarios con que se priorizarán los riesgos que puedan interrumpir la venta en línea o exponer datos personales durante la campaña. |
| Periodo | 1 de octubre al 15 de diciembre de 2026. |
| Incluye | Venta en línea, respaldo y restauración, gestión de cuentas; dependencias NUBEPAC y PAGOSUR. |
| Excluye | Analítica comercial, locales y despacho; deberán incorporarse en ciclos posteriores. |
| Autoriza el alcance | Gerencia general. |
| Capacidad | Nueve personas en tecnología y una persona con funciones de seguridad a media jornada. |
| Presupuesto | 22 millones de pesos para seguridad durante 2027. |
| Congelamiento | No se hacen cambios en producción entre el 25 de octubre y el 5 de diciembre de 2026. |

### Escala única y tolerancias

| Nivel | Probabilidad en 24 meses | Impacto financiero |
| ---: | --- | --- |
| 1 | Cero ocurrencias y la condición necesaria no está presente | Menos de 5 millones de pesos |
| 2 | Cero ocurrencias, pero existe una condición que lo hace posible | Desde 5 y menos de 20 millones |
| 3 | Una ocurrencia | Desde 20 y menos de 50 millones |
| 4 | Entre dos y nueve ocurrencias | Desde 50 y menos de 150 millones |
| 5 | Diez o más ocurrencias, o la condición está activa | Desde 150 millones |

- La indisponibilidad del sitio en campaña no puede superar 30 minutos entre el 1 y el 30 de noviembre; acepta la Gerencia general.
- El retraso de analítica comercial puede alcanzar cinco días hábiles al mes; acepta la Jefatura de tecnología.
- La protección de datos personales y mantener los datos de tarjeta fuera de sistemas propios son requisitos mínimos, no apetito al riesgo.
- No se mezclan ni promedian etiquetas, CVSS, porcentajes ni productos ordinales con esta escala.

### Propiedad ya acordada

| Escenario | Propietario | Responsable interno del control |
| --- | --- | --- |
| Cuenta de una persona desvinculada permanece activa | Jefatura de recursos humanos | Jefatura de tecnología |
| Respaldo de NUBEPAC no se puede restaurar | Jefatura de tecnología | Jefatura de tecnología, con NUBEPAC como ejecutor externo |

## Paso 1 - Clasificar las necesidades de decisión

Usen estos tipos:

- **A:** evaluación detallada de escenarios.
- **B:** proceso continuo de gestión.
- **C:** comunicación de estado y brechas.
- **R:** requisito mínimo que debe incorporarse al proceso.

Completen las tres últimas columnas. La razón debe usar un dato de la misma fila o del estado del caso anterior.

| ID | Necesidad, quién la plantea, plazo y dato disponible | Tipo | Referencia o proceso útil | Razón basada en el caso |
| --- | --- | :---: | --- | --- |
| ND-01 | Gerencia general: ordenar riesgos y costos para asignar los 22 millones antes del 25 de octubre de 2026; ya existen escalas y tolerancias. | [Completar] | [Completar] | [Completar] |
| ND-02 | Gerencia general: mostrar dónde está la empresa y dónde debería estar en doce meses, para fijar metas de 2027 en marzo de 2027; no existe una evaluación previa comparable. | [Completar] | [Completar] | [Completar] |
| ND-03 | Encargado de seguridad: repetir el análisis cada año sin consultora, de forma permanente; hay una persona de seguridad a media jornada y ninguna metodología documentada. | [Completar] | [Completar] | [Completar] |
| ND-04 | Jefatura de tecnología: definir condiciones para renovar NUBEPAC en marzo de 2027, incluido nivel de servicio y pruebas de restauración; el contrato actual no tiene nivel de servicio negociado. | [Completar] | [Completar] | [Completar] |
| ND-05 | Adquirente de tarjetas: demostrar en su revisión anual que los datos de tarjeta permanecen fuera de los sistemas propios; el informe anual de PAGOSUR no declara su alcance. | [Completar] | [Completar] | [Completar] |
| ND-06 | Asesoría legal externa: preparar el tratamiento de datos personales para la vigencia de la Ley 21.719, el 1 de diciembre de 2026; no existe inventario de esos datos. | [Completar] | [Completar] | [Completar] |

**Punto de control:** ND-05 y ND-06 deben quedar reconocidas como requisitos, no como riesgos que la organización pueda ignorar o aceptar.

## Paso 2 - Comparar las referencias

### Tres fichas breves

| Referencia | Para qué sirve | Proceso o instrumento | Resultado principal | Límite importante | Esfuerzo típico |
| --- | --- | --- | --- | --- | --- |
| **ISO/IEC 27005:2022** | Gestionar riesgos de seguridad de la información dentro de un sistema de gestión. | Contexto; identificación, análisis y valoración; tratamiento y aceptación; comunicación; seguimiento y revisión. | Proceso repetible, registro de riesgos, plan de tratamiento y aceptaciones documentadas. | Debe adaptarse: no entrega una escala, fórmula ni catálogo obligatorio. | Moderado a alto si se implementa completa; puede ajustarse al tamaño y alcance de la organización. |
| **NIST SP 800-30 Rev. 1** | Realizar y mantener evaluaciones de riesgo. | Preparar, evaluar, comunicar resultados y mantener la evaluación. | Escenarios con probabilidad, impacto, riesgo, supuestos e incertidumbre. | No desarrolla el tratamiento ni el gobierno del ciclo completo. | Alto si se aplica con todo su detalle: exige datos o juicio experto para cada escenario. |
| **NIST CSF 2.0** | Describir y comunicar resultados de ciberseguridad. | Funciones GOVERN, IDENTIFY, PROTECT, DETECT, RESPOND y RECOVER; perfiles actual y objetivo. | Brecha entre el estado actual y el objetivo, comunicable a la dirección. | No calcula probabilidad, impacto ni costo por escenario. | Bajo a moderado para un primer perfil; crece con la cantidad de resultados que se evalúen. |

Las dos primeras filas del cuadro comparativo ya contienen hechos de las fichas. Revísenlas y completen las dos filas aplicadas al caso.

| Dimensión | ISO/IEC 27005:2022 | NIST SP 800-30 Rev. 1 | NIST CSF 2.0 |
| --- | --- | --- | --- |
| Propósito y resultado | Proceso completo; registro, tratamiento y aceptación | Evaluación detallada; escenarios con probabilidad, impacto e incertidumbre | Comunicación de resultados; perfil actual, objetivo y brecha |
| Información de entrada | Contexto, criterios, alcance y controles existentes | Propósito, alcance, supuestos, amenazas, vulnerabilidades y modelo de riesgo | Contexto, prioridades y evidencia del estado actual |
| Esfuerzo para PACÍFICO RETAIL | [Completar con un dato del caso] | [Completar con un dato del caso] | [Completar con un dato del caso] |
| Límite para este caso | [Completar] | [Completar] | [Completar] |

```text
Referencia que puede ordenar el ciclo completo y por qué: [Completar]

Referencia que puede apoyar la evaluación de escenarios y por qué: [Completar]

Referencia que puede apoyar la comunicación y por qué: [Completar]
```

**Punto de control:** cada celda de esfuerzo y límite cita un dato del estado del caso, como la capacidad, el plazo o el alcance; «es más conocida» no justifica nada.

## Paso 3 - Seleccionar un enfoque

Consideren simultáneamente estos hechos:

- la gerencia pide resultados en tres semanas, pero el alcance acordado no cubre toda la empresa;
- existe una persona de seguridad a media jornada;
- ya hay una escala común y no debe reemplazarse por las escalas de ejemplo de otra referencia;
- NUBEPAC debe renegociarse en marzo de 2027;
- la gerencia necesita decidir y también comprender el estado de la organización.

```text
Proceso rector del ciclo completo: [Completar]

Dos datos del caso que justifican la selección: [Completar]

Apoyo para evaluar escenarios y parte que se usará: [Completar]

Apoyo para comunicar y parte que se usará, o «no necesario»: [Completar]

Escala única y cargo que coordinará el ciclo: [Completar]

Limitación o dato que falta verificar: [Completar]
```

Se admite un proceso simplificado de ISO/IEC 27005. Si seleccionan SP 800-30 para evaluar, nombren por separado el proceso que gobernará tratamiento, aceptación y seguimiento.

**Punto de control:** otra persona puede leer esta sección y saber qué referencia ordena el ciclo completo y qué función distinta cumple cada apoyo.

## Paso 4 - Bosquejar el ciclo

Para cada etapa indiquen **un artefacto verificable** y **un hecho o frecuencia que obligue a revisarlo**. Escriban ambos elementos en la misma celda con la forma `artefacto — disparador`.

Pueden usar, adaptar o descartar estos antecedentes: campaña de noviembre; revisión anual del adquirente; vigencia de la Ley 21.719; renovación de NUBEPAC en marzo; cambio de proveedor o sistema; incidente que supere una tolerancia; aparición de información nueva; revisión mensual, trimestral o anual.

| Etapa | Artefacto verificable — disparador de revisión |
| --- | --- |
| Contexto y criterios | [Completar] |
| Identificación | [Completar] |
| Análisis | [Completar] |
| Valoración y priorización | [Completar] |
| Tratamiento y aceptación | [Completar] |
| Comunicación y consulta | [Completar] |
| Seguimiento y revisión | [Completar] |

**Punto de control:** el ciclo no termina en una matriz y contiene al menos un disparador ligado al contrato de NUBEPAC o a un incidente que supere una tolerancia.

## Paso 5 - Redactar la recomendación ejecutiva

La solicitud original de la gerencia fue evaluar todos los riesgos de la empresa en tres semanas, ordenarlos y calcular cuánto cuesta cerrarlos. El alcance vigente demuestra que una parte de ese pedido debe continuar en ciclos posteriores.

Redacten un máximo de 120 palabras. Indiquen el proceso rector, los apoyos, la escala, la primera entrega posible y lo que queda fuera de las tres semanas. Eviten siglas sin explicar.

> [Completar]

**Punto de control:** la recomendación no supera 120 palabras y declara qué parte del pedido queda fuera de las tres semanas.

## Cierre

Respondan brevemente las tres preguntas.

1. ¿Qué parte del ciclo debe revisarse si NUBEPAC cambia el contrato?
2. El fabricante del punto de venta informó una vulnerabilidad con CVSS 8,1 sobre 10. ¿Por qué un puntaje CVSS alto no equivale al riesgo del negocio?
3. ¿Qué parte del pedido de gerencia queda fuera de tres semanas y cómo se comunica?

| Pregunta | Respuesta |
| :---: | --- |
| 1 | [Completar] |
| 2 | [Completar] |
| 3 | [Completar] |

## Comprobación final

- [ ] Las seis necesidades tienen tipo, referencia y razón basada en el caso.
- [ ] La comparación distingue ciclo completo, evaluación y comunicación.
- [ ] La selección nombra un proceso rector y apoyos acotados.
- [ ] La propuesta conserva la escala acordada en la Lección 07.
- [ ] Las siete etapas incluyen artefacto y disparador.
- [ ] No se asignaron niveles de riesgo ni se priorizaron tratamientos.
- [ ] La recomendación no supera 120 palabras y declara qué queda fuera.
- [ ] El cierre responde brevemente las tres preguntas.

## Ampliación opcional

Solo si el producto obligatorio está cerrado, elijan **una** alternativa.

### A. Diagnosticar escalas incompatibles

| ID | Objeto | Valor informado | Qué mide realmente |
| --- | --- | --- | --- |
| EP-01 | Caída del sitio en campaña | Alto | Etiqueta sin descriptor ni periodo de referencia |
| EP-02 | Cuenta de persona desvinculada activa | 4 × 2 = 8 | Producto ordinal; impacto medido en horas de TI |
| EP-03 | Vulnerabilidad del punto de venta | CVSS 8,1 | Severidad técnica sin contexto de la organización |
| EP-04 | Fraude con tarjetas | 70 % | Porcentaje de jefaturas preocupadas |

Expliquen por qué las cuatro filas no se comparan directamente y qué dato se necesita para expresarlas con la escala común:

> [Completar solo si eligieron esta ampliación]

### B. Clasificar propuestas de tratamiento

| ID | Propuesta | Costo anual |
| --- | --- | ---: |
| PT-01 | Informar cada desvinculación el mismo día, desactivar en 24 horas y revisar cuentas mensualmente | 2 millones |
| PT-02 | Mantener respaldo independiente de NUBEPAC y probar restauración trimestral | 9 millones |
| PT-03 | Eliminar la copia identificable usada en analítica y trabajar con datos agregados | Sin costo directo |
| PT-04 | Contratar un seguro que cubra fraude y costos de notificación | 6 millones |
| PT-05 | No agregar acciones y revisar mensualmente el retraso de analítica | Sin costo directo |

Clasifiquen cada propuesta como evitar, modificar, compartir o retener, e indiquen un residual que podría permanecer. No las prioricen ni las acepten formalmente:

> [Completar solo si eligieron esta ampliación]
