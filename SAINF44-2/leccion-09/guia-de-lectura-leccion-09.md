---
title: "Activos, amenazas y vulnerabilidades: identificar riesgos y validar hallazgos"
tags:
  - nota
  - course
  - curso
  - materia
  - guia-de-lectura
  - gestion-de-riesgos
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "09"
author: Jordy
start: 2026-10-05
end: 2026-10-06
created_at: 2026-10-04
aliases:
  - "Activos, amenazas y vulnerabilidades: identificar riesgos y validar hallazgos"
  - "Materia y guía de lectura - Activos, amenazas y vulnerabilidades"
---
# Activos, amenazas y vulnerabilidades: identificar riesgos y validar hallazgos

**Consulta opcional.** La clase introduce lo necesario para resolver la actividad; no se exige leer esta guía antes ni responder sus preguntas por escrito. Úsenla para repasar o aclarar conceptos.

```toc
```

## Del método a la identificación

En la Lección 07 se fijaron las reglas: alcance, escalas, tolerancias y propietarios. En la Lección 08 se eligió el proceso que ordena el trabajo. Ahora empieza la primera etapa de la evaluación: la **identificación**.

> ¿Qué tiene la organización que valga la pena proteger, qué podría ocurrirle, qué debilidad lo haría posible y qué consecuencia tendría para sus objetivos?

Tres ideas ordenan la lección:

1. un riesgo se describe como un **escenario completo**: fuente, evento, vulnerabilidad, activo y consecuencia. Una palabra suelta («phishing», «hackeo») no es un riesgo;
2. un hallazgo de un escáner es un **dato por validar**, no un riesgo ni una prueba: hay que confirmar a qué activo afecta, si es real y si está dentro del alcance;
3. en esta etapa **no se asignan niveles**. Primero se describe bien; la valoración viene después, con la escala acordada.

## 1. La identificación dentro del ciclo

| Etapa | Pregunta | Producto |
| --- | --- | --- |
| Contexto y criterios (L07) | ¿Qué se analiza y con qué reglas? | Alcance, escalas y tolerancias |
| Selección del método (L08) | ¿Cómo se hará el trabajo? | Proceso rector y apoyos |
| **Identificación (L09)** | **¿Qué podría ocurrir, sobre qué y por qué?** | **Inventario y registro inicial de escenarios** |
| Análisis y valoración (L10) | ¿Qué tan probable y qué tan grave? ¿Qué se atiende primero? | Matriz y prioridades |
| Tratamiento (L10) | ¿Qué se hará con cada riesgo? | Plan, responsables y residual |

ISO/IEC 27005:2022 describe dos formas de identificar riesgos que se complementan:

| Enfoque | Punto de partida | Útil cuando |
| --- | --- | --- |
| Basado en eventos | Escenarios de alto nivel sobre los objetivos: «la venta en línea se detiene en campaña» | Hay poco tiempo y se necesita una visión estratégica |
| Basado en activos | El inventario: para cada activo, sus amenazas y vulnerabilidades | Se necesita detalle para elegir controles concretos |

En la práctica se usan juntos: los eventos ayudan a no perderse en el detalle y los activos ayudan a no quedarse en generalidades.

## 2. Activos: qué se protege

Un **activo** es algo que tiene valor para la organización y que, si se ve afectado, compromete un objetivo. La clasificación tradicional de ISO/IEC 27005 distingue dos tipos:

| Tipo | Qué incluye | Ejemplos |
| --- | --- | --- |
| **Primario** | Información y procesos de negocio | Base de datos de clientes, proceso de venta, proceso de despacho |
| **De soporte** | Aquello de lo que dependen los primarios | Servidores, aplicaciones, redes, servicios de proveedores, personas, instalaciones |

El valor de un activo de soporte se hereda de los primarios que sostiene. Un servidor vale lo que vale la información y el proceso que dependen de él.

### Lo que no es un activo

Un error frecuente es inventariar como activos cosas que pertenecen a otras piezas del escenario:

| Elemento | Qué es en realidad |
| --- | --- |
| «Phishing» | Una técnica o evento de amenaza |
| «Contraseñas débiles» | Una vulnerabilidad |
| «Ley de protección de datos» | Un requisito que define consecuencias y obligaciones |
| «Firewall» | Un activo de soporte si se inventaría como equipo; un control si se evalúa su función |
| «Hackeo» | Ninguna pieza concreta: debe descomponerse |

### El inventario

| Campo | Para qué sirve |
| --- | --- |
| Identificador y nombre | Citar el activo sin ambigüedad |
| Tipo | Primario o de soporte |
| Propietario | Cargo que responde por el activo y decide sobre su riesgo |
| Custodio | Quien lo opera o administra (TI, un proveedor) |
| Dependencias | De qué otros activos depende y qué depende de él |
| Qué se pierde si falla | Confidencialidad (C), integridad (I) o disponibilidad (D), dicho en términos del negocio |

**Propietario no es lo mismo que custodio.** TI puede administrar la base de clientes, pero quien responde por esa información ante el negocio suele ser una gerencia. Un proveedor puede ser custodio y ejecutar controles; el riesgo lo asume siempre un cargo de la organización. Una herramienta nunca es propietaria.

### Dependencias y terceros

Los servicios de terceros (alojamiento, pagos, rastreo, correo en la nube) son activos de soporte. Externalizar un servicio no externaliza la responsabilidad: si el proveedor falla, el proceso afectado sigue siendo de la organización. Por eso el inventario registra la dependencia y la condición contractual conocida (nivel de servicio, pruebas, informes del proveedor).

## 3. Amenazas: qué podría ocurrir

NIST SP 800-30 separa la **fuente** de amenaza del **evento** de amenaza:

| Concepto | Pregunta | Ejemplo |
| --- | --- | --- |
| Fuente de amenaza | ¿Quién o qué? | Un grupo criminal, un trabajador que comete un error, una falla de hardware |
| Evento de amenaza | ¿Qué hace? | Usa credenciales robadas para entrar a un sistema |

Las fuentes se agrupan en cuatro tipos:

| Tipo | Descripción | Ejemplo |
| --- | --- | --- |
| Adversaria | Personas u organizaciones con intención | Delincuentes, personal interno malicioso, competidores |
| Accidental | Errores de personas sin intención de dañar | Envío de un archivo al destinatario equivocado |
| Estructural | Fallas de equipos, software o servicios | Caída de un proveedor, disco que falla |
| Ambiental | Hechos naturales o de infraestructura | Corte eléctrico, incendio, terremoto |

No todos los riesgos tienen un atacante detrás. Una caída de proveedor durante la campaña puede costar más que un ataque.

### Describir el comportamiento del adversario

Para las fuentes adversarias, **MITRE ATT&CK** cataloga tácticas (el objetivo del atacante en cada fase) y técnicas (cómo lo logra), basadas en ataques observados. Por ejemplo, «uso de cuentas válidas» o «explotación de una aplicación expuesta a Internet». Nombrar la técnica ayuda a pensar qué control debería detectarla. ATT&CK no describe fuentes accidentales, estructurales ni ambientales: para esos eventos no hay técnica que buscar.

## 4. Vulnerabilidades y condiciones predisponentes

Una **vulnerabilidad** es una debilidad que una amenaza puede aprovechar. No es solo un error de software:

| Tipo | Ejemplo |
| --- | --- |
| Técnica | Software sin parche, servicio expuesto a Internet, configuración insegura |
| De proceso | Bajas de personal avisadas sin plazo, cambios sin revisión |
| De personas | Falta de capacitación, una sola persona que conoce un sistema |
| Contractual | Proveedor sin nivel de servicio ni pruebas comprometidas |

NIST SP 800-30 agrega las **condiciones predisponentes**: características de la organización o del entorno que hacen más o menos probable que un evento tenga éxito, aunque no sean fallas. Por ejemplo, depender de un solo proveedor, concentrar la operación en una temporada corta o tener personal que trabaja en terreno.

## 5. Controles existentes y evidencia

Un **control** es una medida que reduce la probabilidad o el impacto de un escenario: impide, detecta o ayuda a recuperar. En la identificación se registra qué controles **ya existen**, pero un control solo cuenta si hay **evidencia de que opera**:

| Diseño | Operación | Evidencia posible |
| --- | --- | --- |
| «Hay respaldo diario» | ¿Se ha restaurado alguna vez? | Acta de una prueba de restauración |
| «Se desactivan las cuentas de quienes se van» | ¿En cuánto tiempo, y quién lo revisa? | Fechas de baja comparadas con fechas de desactivación |
| «El panel registra los accesos» | ¿Alguien revisa ese registro? | Informe de revisión o alerta configurada |

Si no hay evidencia, se escribe «sin evidencia de operación». Dar por operativo un control que solo existe en el papel hace que el riesgo parezca menor de lo que es.

## 6. El escenario de riesgo

Un escenario reúne todas las piezas:

![Anatomía de un escenario de riesgo: una fuente de amenaza produce un evento que aprovecha una vulnerabilidad de un activo y genera una consecuencia para el negocio; un control existente puede impedir o detectar el evento si hay evidencia de que opera; abajo, un ejemplo con el correo de una empresa logística](anatomia-escenario-riesgo.svg)

Plantilla de redacción:

> **[Fuente]** **[evento]** aprovechando **[vulnerabilidad o condición]** en **[activo]**, lo que provoca **[consecuencia para un objetivo o requisito]**.

### Causa, evento y consecuencia

| Pieza | Pregunta | Error típico |
| --- | --- | --- |
| Causa (fuente y vulnerabilidad) | ¿Por qué podría ocurrir? | Escribir solo la vulnerabilidad y llamarla riesgo |
| Evento | ¿Qué ocurre? | Usar palabras vagas: «ataque», «falla» |
| Consecuencia | ¿Qué le pasa al negocio? | Quedarse en lo técnico: «el servidor se cae» |

La consecuencia se expresa en términos de los objetivos y tolerancias del caso: ventas perdidas, plazos incumplidos, datos personales expuestos, una tolerancia superada.

### De redacción débil a escenario

| Redacción débil | Qué falla | Escenario |
| --- | --- | --- |
| «Phishing alto» | Solo una técnica, con un nivel sin criterios | Un atacante obtiene la contraseña de un despachador mediante un correo falso y entra a su cuenta, aprovechando la ausencia de segundo factor, lo que permite enviar órdenes falsas a los conductores |
| «El firewall es un riesgo» | Confunde un control con un riesgo | Un atacante externo entra al sistema de seguimiento desde Internet, aprovechando una regla del firewall que deja abierto el acceso de administración, lo que permite alterar los datos del despacho |
| «Proveedor de rastreo» | Solo un activo | El proveedor de rastreo interrumpe su servicio por una falla propia, sin nivel de servicio comprometido, lo que deja el despacho sin seguimiento más de ocho horas |

### Consolidar y descartar

Dos escenarios con la misma causa, el mismo evento y la misma consecuencia son uno solo. Dos escenarios con la misma consecuencia pero causas distintas **no** se consolidan: necesitan tratamientos distintos. Un escenario sobre un activo fuera del alcance acordado no se registra en este ciclo; se anota para el siguiente.

## 7. Leer un reporte de vulnerabilidades

Un escáner compara lo que observa con una base de vulnerabilidades conocidas. Su reporte es útil, pero no es la verdad:

| Elemento del reporte | Qué preguntar |
| --- | --- |
| Objetivo analizado | ¿A qué activo del inventario corresponde? ¿Está dentro del alcance? |
| Cómo se detectó | ¿Por número de versión, con credenciales o con una prueba activa? |
| Evidencia registrada | ¿Qué demuestra exactamente y qué no demuestra? |
| Severidad declarada | ¿Qué mide ese puntaje? |
| Remediación sugerida | ¿Es aplicable dentro de las restricciones (por ejemplo, un congelamiento de cambios)? |

### Falsos positivos y falsos negativos

| Situación | Causa frecuente | Consecuencia |
| --- | --- | --- |
| **Falso positivo**: informa una vulnerabilidad que no existe | Detección solo por versión; el proveedor o la distribución corrigió la falla sin cambiar el número de versión (*backport*); el componente está presente, pero la función vulnerable no se usa | Se gasta esfuerzo en algo resuelto |
| **Falso negativo**: no informa una que sí existe | El escáner no tenía credenciales, el servicio no respondió o la vulnerabilidad es nueva | Falsa tranquilidad |

Una detección basada solo en el número de versión es la más débil: indica qué **declara** el sistema, no qué tiene.

### Objetivos fuera del inventario

Si el reporte incluye una dirección o un sistema que no figura en el inventario, hay dos posibilidades: no pertenece a la organización, o es un **activo olvidado** (un servidor de pruebas que nadie dio de baja). No se descarta por no estar en el inventario: se confirma a quién pertenece.

### Severidad no es riesgo

**CVSS** (*Common Vulnerability Scoring System*) asigna un puntaje de 0 a 10 a la severidad técnica de una vulnerabilidad. FIRST, que lo mantiene, advierte que mide severidad, no riesgo. El puntaje base describe la vulnerabilidad en abstracto; no sabe si el sistema afectado procesa datos críticos, si está expuesto a Internet ni qué controles lo rodean. Las versiones de CVSS incluyen métricas ambientales para ajustar el puntaje al contexto, pero casi ningún reporte las completa.

Dos fuentes complementan la severidad con información sobre explotación:

| Fuente | Qué indica |
| --- | --- |
| Catálogo KEV de CISA (*Known Exploited Vulnerabilities*) | Vulnerabilidades con identificador CVE, evidencia de explotación activa y una remediación clara |
| EPSS de FIRST (*Exploit Prediction Scoring System*) | Probabilidad estimada de que una vulnerabilidad sea explotada en los próximos 30 días |

Una vulnerabilidad con explotación activa conocida merece atención urgente **si está confirmada en un activo propio**. La explotación conocida aumenta la probabilidad; no reemplaza la validación.

## 8. Validar sin intervenir

Validar es confirmar o descartar un hallazgo con evidencia. Las publicaciones de NIST sobre evaluación de controles (SP 800-53A) usan tres métodos: **examinar**, **entrevistar** y **probar**. En esta etapa se privilegian los dos primeros:

| Método | Ejemplos no destructivos |
| --- | --- |
| Examinar | Revisar configuraciones exportadas, registros de cambios, inventario, contratos, avisos del fabricante, comparar el hash o la fecha de un archivo con el publicado |
| Entrevistar | Preguntar al custodio qué se instaló y cuándo; pedir al proveedor confirmación escrita |
| Probar | Solo con autorización explícita, plan y ventana acordada; nunca intentar explotar para «ver si funciona» |

Probar una explotación sin autorización puede interrumpir el servicio, dañar datos y constituir un delito. En un proceso de gestión del riesgo, la duda se resuelve con evidencia documental antes que con ataques.

### Estados de una ficha de validación

| Estado | Cuándo se usa |
| --- | --- |
| Confirmado | La evidencia demuestra que la condición existe en un activo del alcance |
| Por validar | Hay una duda razonable: falta confirmar el parche, la pertenencia del activo o el uso de la función afectada |
| Fuera de alcance | Hay **evidencia** de que el activo no pertenece al alcance vigente |
| Falso positivo | Hay **evidencia** de que la vulnerabilidad no existe |

«Fuera de alcance» y «falso positivo» solo se usan cuando ya existe esa evidencia. Mientras tanto, un hallazgo que parece falso sigue **por validar**. «No está en el inventario» o «TI dice que está corregido» no bastan para cerrar un hallazgo: son el punto de partida de la validación.

### Del hallazgo al escenario

| Hallazgo del escáner | Escenario de riesgo |
| --- | --- |
| Describe una vulnerabilidad en un objetivo técnico | Describe qué podría ocurrir al negocio |
| Trae una severidad técnica | Se valorará después con la escala de la organización |
| Puede ser falso | Se formula sobre condiciones confirmadas o declara la condición pendiente |

Un hallazgo confirmado se convierte en la pieza «vulnerabilidad» de un escenario; el resto de las piezas (fuente, evento, activo, consecuencia) las aporta el análisis, no el escáner.

Un hallazgo **por validar** también puede dar origen a un **escenario provisional**: se declara la condición pendiente, por ejemplo, «si el parche no quedó instalado». Formularlo no confirma la vulnerabilidad. El hallazgo mantiene su estado por validar y cualquier valoración posterior debe reconocer esa incertidumbre.

## 9. El registro inicial de riesgos

| Columna | Contenido |
| --- | --- |
| Identificador | `R-01`, `R-02`… |
| Fuente y evento | Quién o qué, y qué hace |
| Vulnerabilidad o condición | Qué aprovecha |
| Activo | Del inventario |
| Consecuencia | Para un objetivo o requisito del caso |
| Control existente y evidencia | Qué existe y cómo se sabe que opera, o «sin evidencia» |
| Propietario propuesto | Cargo de la organización |

Lo que **todavía no** se registra: probabilidad, impacto, nivel de riesgo ni prioridad. Asignarlos antes de describir bien los escenarios y de validar los hallazgos convierte la matriz en una lista de opiniones.

## 10. Revisión entre pares

Antes de pasar a la valoración, otra persona revisa el registro con preguntas simples:

- ¿Cada escenario tiene las cinco piezas y ninguna está vacía o es genérica?
- ¿La consecuencia nombra un objetivo, una tolerancia o un requisito del caso?
- ¿Hay escenarios duplicados o alguno fuera del alcance?
- ¿Cada control existente tiene evidencia o declara que no la tiene?
- ¿Algún escenario depende de un hallazgo que sigue por validar? ¿Se dice?

## 11. Errores frecuentes

| Error | Por qué ocurre | Corrección |
| --- | --- | --- |
| Inventariar solo equipos | Lo técnico es lo más visible | Partir de la información y los procesos |
| Poner una herramienta o un proveedor como propietario | Son quienes operan el activo | El propietario es un cargo de la organización |
| Escribir «hackeo» como riesgo | Es rápido y suena completo | Descomponer en fuente, evento, vulnerabilidad, activo y consecuencia |
| Confundir vulnerabilidad con riesgo | La vulnerabilidad es lo que se ve | Agregar evento, activo y consecuencia |
| Olvidar fuentes no adversarias | Se piensa solo en atacantes | Revisar fallas de proveedores, errores y eventos ambientales |
| Dar por operativo un control documentado | Existe una política o un contrato | Pedir evidencia de operación |
| Copiar la severidad CVSS como nivel de riesgo | El número está disponible | Valorar después con la escala propia y el contexto |
| Aceptar un hallazgo sin validarlo | El reporte parece técnico y definitivo | Confirmar activo, evidencia y alcance |
| Descartar un hallazgo porque el objetivo no está en el inventario | El inventario parece completo | Confirmar la pertenencia; podría ser un activo olvidado |
| «Validar» explotando | Se busca certeza rápida | Examinar y entrevistar; probar solo con autorización |
| Asignar niveles para adelantar | Se quiere llegar a la matriz | Terminar primero la identificación |

## 12. Ejemplo resuelto - caso VIÑA DEL ESTE (ficticio)

La empresa logística de las lecciones 07 y 08 tiene 60 personas y una sola persona de TI con funciones de seguridad. Su alcance incluye el proceso de despacho, el sistema de seguimiento de carga, la base de datos de clientes, el correo corporativo y el proveedor de rastreo satelital. Eligió ISO/IEC 27005 simplificada con apoyo de NIST SP 800-30 para la evaluación.

### Inventario (extracto)

| Activo | Tipo | Propietario | Depende de | Qué se pierde |
| --- | --- | --- | --- | --- |
| Proceso de despacho | Primario | Gerencia de operaciones | Sistema de seguimiento, correo, proveedor de rastreo, despachadores | D: entregas atrasadas; I: entregas en direcciones equivocadas |
| Base de datos de clientes | Primario | Gerencia comercial | Sistema de seguimiento | C: exposición de datos de contacto y direcciones |
| Correo corporativo | Soporte | Jefatura de tecnología | Servicio de correo en la nube | I: órdenes de despacho falsas; C: datos de clientes en correos |
| Proveedor de rastreo satelital | Soporte | Gerencia de operaciones | Contrato sin nivel de servicio | D: despacho sin seguimiento |

### Hallazgos del reporte y su validación

```text
F-1  Correo corporativo permite autenticación heredada (solo usuario y contraseña).
     Severidad declarada: media.
     Activo: correo corporativo.
     Evidencia: exportación de la configuración del servicio de correo, entregada por TI.
     Demuestra: la opción está habilitada para todas las cuentas.
     No demuestra: que alguna cuenta haya sido usada por un tercero.
     Validación: examinar la configuración (hecho) y los registros de inicio de sesión.
     Estado: confirmado.        Escenario: R-01.

F-2  Biblioteca de generación de PDF del sistema de seguimiento con una falla
     en su función de importación de archivos. Severidad declarada: crítica (CVSS 9,1).
     Activo: sistema de seguimiento de carga.
     Evidencia: versión de la biblioteca listada en el inventario de componentes.
     Demuestra: el inventario registra una versión señalada como vulnerable.
     No demuestra: que el sistema use la función de importación.
     Antecedente: TI indica que el sistema solo genera PDF, nunca los importa.
     Validación: pedir al proveedor del sistema confirmación escrita de que la función
                 no es alcanzable y el plazo de actualización.
     Estado: por validar.       Escenario: R-03, provisional.
```

F-2 tiene la severidad más alta, pero su estado depende de un dato que el escáner no conoce. F-1 tiene severidad media y ya forma parte de un escenario.

Con F-2 se formula un escenario provisional (R-03 en el registro): declara la condición pendiente, «si la función afectada se usa y la falla sigue presente». La condición debe verificarse y el hallazgo sigue por validar.

### Registro inicial (extracto)

| ID | Fuente y evento | Vulnerabilidad o condición | Activo | Consecuencia | Control existente y evidencia | Propietario |
| --- | --- | --- | --- | --- | --- | --- |
| R-01 | Atacante externo con credenciales filtradas entra al correo de un despachador y envía órdenes falsas | Autenticación heredada sin segundo factor (F-1) | Correo corporativo, soporte del despacho | Entregas desviadas y plazos incumplidos con el cliente certificador | Filtro de correo no deseado; sin evidencia de revisión de inicios de sesión | Gerencia de operaciones |
| R-02 | El proveedor de rastreo interrumpe su servicio por una falla propia | Contrato sin nivel de servicio; dos interrupciones en el último año | Proveedor de rastreo satelital | Despacho sin seguimiento más de ocho horas; incumplimiento de plazos | Sin control contractual; sin procedimiento manual probado | Gerencia de operaciones |
| R-03 (provisional) | Atacante externo envía un archivo manipulado al sistema de seguimiento, si la función de importación se usa y la falla sigue presente | Falla de la biblioteca de PDF (F-2, por validar) | Sistema de seguimiento de carga | Datos del despacho alterados; entregas incorrectas | Sin evidencia; condición pendiente de confirmar con el proveedor | Gerencia de operaciones |

R-02 no tiene atacante: es una fuente estructural. R-03 es provisional: se mantiene en el registro con su condición, pero no confirma la vulnerabilidad. No se asigna ningún nivel: la valoración ocurrirá con la escala definida en la Lección 07.

### Conclusión de la etapa

> VIÑA DEL ESTE inventarió sus activos de despacho con propietarios y dependencias, registró dos escenarios completos y uno provisional, y revisó dos hallazgos del escáner: uno confirmado, que alimenta R-01, y uno por validar, que alimenta el escenario provisional R-03 con su condición pendiente explícita. Ningún escenario tiene nivel asignado; los controles sin evidencia se declararon como tales.

## 13. Preguntas para consultar y repasar

Durante la práctica se continuará con PACÍFICO RETAIL. Estas preguntas orientan la consulta opcional; no son una tarea ni requieren entrega:

1. ¿Qué diferencia hay entre un activo primario y uno de soporte?
2. ¿Por qué un proveedor puede ser custodio, pero no propietario del riesgo?
3. ¿Qué piezas tiene un escenario de riesgo completo?
4. ¿Qué tipos de fuente de amenaza no tienen un atacante detrás?
5. ¿Qué demuestra y qué no demuestra una detección basada en el número de versión?
6. ¿Por qué un objetivo que no está en el inventario no se descarta de inmediato?
7. ¿Por qué un CVSS de 9,8 no significa que ese sea el riesgo más alto de la organización?
8. ¿Qué métodos permiten validar un hallazgo sin intervenir el sistema?

## 14. Glosario

| Término | Definición |
| --- | --- |
| Activo | Elemento con valor para la organización cuya afectación compromete un objetivo. |
| Activo de soporte | Tecnología, servicio, persona o instalación de la que dependen los activos primarios. |
| Activo primario | Información o proceso de negocio. |
| *Backport* | Corrección de una falla aplicada a una versión antigua sin cambiar su número de versión. |
| Condición predisponente | Característica de la organización o del entorno que hace más o menos probable el éxito de un evento. |
| Control | Medida que impide, detecta o ayuda a recuperarse de un evento. |
| Custodio | Quien opera o administra un activo por cuenta del propietario. |
| CVSS | Sistema de puntaje de severidad técnica de vulnerabilidades, de 0 a 10. |
| EPSS | Estimación de la probabilidad de que una vulnerabilidad sea explotada en los próximos 30 días. |
| Escenario de riesgo | Descripción de una fuente que, mediante un evento, aprovecha una vulnerabilidad de un activo y genera una consecuencia. |
| Evento de amenaza | Lo que ocurre o lo que hace la fuente de amenaza. |
| Falso negativo | Vulnerabilidad existente que el escáner no informa. |
| Falso positivo | Vulnerabilidad informada por el escáner que no existe. |
| Fuente de amenaza | Persona, organización, falla o fenómeno que puede causar un evento. |
| KEV | Catálogo de CISA de vulnerabilidades con explotación activa conocida. |
| Propietario | Cargo que responde por un activo o un riesgo y decide sobre él. |
| Registro de riesgos | Lista estructurada de escenarios con sus piezas, controles y propietarios. |
| Validación no destructiva | Confirmación de un hallazgo mediante revisión de documentos, configuraciones o entrevistas, sin atacar el sistema. |
| Vulnerabilidad | Debilidad que una amenaza puede aprovechar. |

## Fuentes

- [ISO/IEC 27005:2022 - Guidance on managing information security risks](https://www.iso.org/standard/80585.html). Enfoques basados en eventos y en activos para identificar riesgos.
- [NIST SP 800-30 Rev. 1 - Guide for Conducting Risk Assessments](https://csrc.nist.gov/pubs/sp/800/30/r1/final). Fuentes y eventos de amenaza, vulnerabilidades y condiciones predisponentes.
- [NIST SP 800-53A Rev. 5 - Assessing Security and Privacy Controls](https://csrc.nist.gov/pubs/sp/800/53/a/r5/final). Métodos de evaluación: examinar, entrevistar y probar.
- [NIST SP 800-115 - Technical Guide to Information Security Testing and Assessment](https://csrc.nist.gov/pubs/sp/800/115/final). Técnicas de revisión, identificación y validación de vulnerabilidades.
- [NIST Cybersecurity Framework 2.0](https://www.nist.gov/cyberframework). Categorías de gestión de activos (ID.AM) y evaluación de riesgos (ID.RA).
- [MITRE ATT&CK Enterprise](https://attack.mitre.org/matrices/enterprise/). Tácticas y técnicas de adversarios observadas en ataques reales.
- [FIRST - CVSS v4.0 Specification](https://www.first.org/cvss/v4.0/specification-document). Qué mide el puntaje y sus grupos de métricas.
- [CISA - Known Exploited Vulnerabilities Catalog](https://www.cisa.gov/known-exploited-vulnerabilities-catalog). Catálogo y criterios de inclusión.
- [FIRST - Exploit Prediction Scoring System (EPSS)](https://www.first.org/epss/). Probabilidad estimada de explotación.
