# Fichas de referencias - Lección 08

Resumen de trabajo para la Lección 08 de INF44. Describe con palabras propias el propósito y la estructura de cada referencia; no reemplaza su texto. Las publicaciones del NIST son gratuitas; las normas ISO son de pago y aquí solo se describe lo que informa su ficha pública y lo que es conocido de su estructura.

Las tres primeras fichas son las referencias que se comparan en la actividad. La cuarta es un apoyo complementario para el registro de riesgos.

## Ficha 1 - ISO/IEC 27005:2022

| Aspecto | Descripción |
| --- | --- |
| Nombre | *Information security, cybersecurity and privacy protection - Guidance on managing information security risks* |
| Emisor y versión | ISO/IEC, cuarta edición, 2022 |
| Acceso | Norma de pago; ficha pública en el sitio de ISO |
| Propósito | Orientar la gestión de los riesgos de seguridad de la información dentro de un sistema de gestión (SGSI). Detalla cómo realizar las actividades de riesgo que exige ISO/IEC 27001:2022 |
| Relación con otras normas | Se alinea con el proceso general de ISO 31000:2018 y con los requisitos de ISO/IEC 27001 |
| Estructura del proceso | Establecimiento del contexto; evaluación del riesgo (identificación, análisis y valoración); tratamiento, que termina con la aceptación del plan y del riesgo residual por sus propietarios; comunicación y consulta; seguimiento y revisión; información documentada |
| Cómo identifica riesgos | Admite dos enfoques: basado en eventos (escenarios estratégicos) y basado en activos (activos, amenazas y vulnerabilidades) |
| Opciones de tratamiento | Evitar, modificar, compartir o retener el riesgo |
| Entradas que requiere | Contexto, criterios de riesgo definidos por la organización, información sobre activos, fuentes de riesgo y controles existentes |
| Resultado principal | Un proceso de gestión del riesgo repetible e integrado al sistema de gestión, con registro, plan de tratamiento y aceptaciones documentadas |
| Nivel de detalle | Orientación general: dice qué hacer y por qué, pero no impone escalas, fórmulas ni herramientas |
| Qué no hace | No es certificable por sí sola; no entrega una escala ni un catálogo cerrado de amenazas que se aplique sin adaptar |
| Esfuerzo | Moderado a alto si se implementa completa; puede ajustarse al tamaño de la organización |

## Ficha 2 - NIST SP 800-30 Rev. 1

| Aspecto | Descripción |
| --- | --- |
| Nombre | *Guide for Conducting Risk Assessments* |
| Emisor y versión | NIST, revisión 1, 2012 |
| Acceso | Gratuito |
| Propósito | Guiar la **evaluación** del riesgo: el componente «evaluar» del proceso de gestión del riesgo que describe NIST SP 800-39: enmarcar (*frame*), evaluar (*assess*), responder (*respond*) y supervisar (*monitor*) |
| Estructura del proceso | Cuatro pasos: preparar la evaluación; realizarla; comunicar los resultados; mantenerla actualizada |
| Tareas del paso «realizar» | Identificar fuentes de amenaza; identificar eventos de amenaza; identificar vulnerabilidades y condiciones predisponentes; determinar probabilidad; determinar impacto; determinar el riesgo |
| Niveles de aplicación | Organización, proceso de negocio o misión, y sistema de información |
| Enfoques admitidos | Cualitativo, semicuantitativo o cuantitativo; análisis orientado a amenazas, a activos e impacto, o a vulnerabilidades |
| Entradas que requiere | Propósito, alcance, supuestos, restricciones, fuentes de información y un modelo de riesgo definido en la preparación |
| Resultado principal | Una lista de riesgos determinados por probabilidad e impacto, con supuestos e incertidumbre, comunicada en un informe |
| Nivel de detalle | Alto: incluye tablas de ejemplo con escalas de cinco niveles y descriptores |
| Qué no hace | No desarrolla el tratamiento ni el gobierno del riesgo: eso corresponde a SP 800-39 y a la gestión de la organización |
| Esfuerzo | Alto si se aplica con todo su detalle; exige datos o juicio experto para cada escenario |

## Ficha 3 - NIST Cybersecurity Framework (CSF) 2.0

| Aspecto | Descripción |
| --- | --- |
| Nombre | *The NIST Cybersecurity Framework (CSF) 2.0* |
| Emisor y versión | NIST, versión 2.0, 2024 |
| Acceso | Gratuito, con guías rápidas y ejemplos de implementación |
| Propósito | Ofrecer una taxonomía de **resultados** de ciberseguridad que cualquier organización puede usar para comprender, evaluar, priorizar y comunicar su gestión del riesgo |
| Estructura | Seis funciones (GOVERN, IDENTIFY, PROTECT, DETECT, RESPOND, RECOVER) divididas en categorías y subcategorías de resultados |
| Instrumentos | Perfil actual, perfil objetivo y *Tiers* o niveles de implementación del 1 al 4 |
| Relación con el riesgo | GOVERN incluye la estrategia de gestión del riesgo (GV.RM); IDENTIFY incluye la evaluación de riesgos (ID.RA). El marco dice **qué resultado** lograr, no **cómo** evaluar |
| Entradas que requiere | Contexto, prioridades de la organización y evidencia de qué resultados se logran hoy |
| Resultado principal | Una brecha entre el perfil actual y el objetivo, expresada en resultados, que se traduce en un plan de acción priorizado y comunicable a la dirección |
| Nivel de detalle | Medio: los resultados son concretos, pero no se asignan probabilidades ni impactos |
| Qué no hace | No reemplaza una evaluación de riesgos por escenario; no es una norma certificable ni una lista de controles obligatorios |
| Esfuerzo | Bajo a moderado para un primer perfil; crece con la cantidad de subcategorías que se evalúen |

## Ficha 4 - NIST IR 8286A Rev. 1 (complementaria)

| Aspecto | Descripción |
| --- | --- |
| Nombre | *Identifying and Estimating Cybersecurity Risk for Enterprise Risk Management* |
| Emisor y versión | NIST, revisión 1, diciembre de 2025; forma parte de la serie IR 8286 |
| Propósito | Integrar el riesgo de ciberseguridad en la gestión del riesgo de toda la empresa: apetito, tolerancia, escenarios, probabilidad e impacto |
| Aporte principal | Un formato de **registro de riesgos de ciberseguridad** cuyos datos se consolidan en el perfil de riesgo de la empresa |
| Campos típicos del registro | Identificador, prioridad, descripción del escenario, categoría, probabilidad, impacto, exposición, tipo de respuesta, costo y descripción de la respuesta, propietario y estado |
| Uso en el curso | Sirve de modelo para el registro de las lecciones 09 y 10, con las escalas de la Lección 07 |

## Referencias

- ISO/IEC 27005:2022 - https://www.iso.org/standard/80585.html
- NIST SP 800-30 Rev. 1 - https://csrc.nist.gov/pubs/sp/800/30/r1/final
- NIST SP 800-39 - https://csrc.nist.gov/pubs/sp/800/39/final
- NIST CSF 2.0 - https://www.nist.gov/cyberframework
- NIST IR 8286A Rev. 1 - https://csrc.nist.gov/pubs/ir/8286/a/r1/final
