---
title: "Contexto, criterios y gobierno del riesgo"
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
lesson: "07"
author: Jordy
start: 2026-09-21
end: 2026-09-22
created_at: 2026-09-18
aliases:
  - "Contexto, criterios y gobierno del riesgo"
  - "Materia y guía de lectura - Contexto y criterios de riesgo"
---
# Contexto, criterios y gobierno del riesgo

```toc
```

## Por qué el contexto va antes que la puntuación

Aplicar un control y comprobar que funciona es una pregunta técnica. Decidir cuáles de todos los riesgos posibles merecen ese control es una pregunta distinta:

> ¿Qué riesgos importan para **esta** organización, quién decide sobre ellos y con qué criterio se compara un riesgo con otro?

Es un cambio de nivel, no de tema. La misma falla técnica puede ser intolerable en una organización e irrelevante en otra, porque el riesgo no es una propiedad del sistema: es la relación entre un evento posible y los **objetivos** de quien lo sufre.

De ahí la regla que ordena esta materia:

```text
Sin contexto no hay criterio.
Sin criterio, una puntuación es una opinión con número.
```

Una matriz de colores construida sin definir escalas, apetito ni propietarios produce cifras que nadie puede discutir ni auditar. Parecen objetivas porque son numéricas, y esa apariencia es precisamente el problema.

## 1. Vocabulario mínimo

| Término | Definición operativa | Error frecuente |
| --- | --- | --- |
| Activo | Algo que tiene valor para la organización: un proceso, un dato, un servicio, una reputación | Listar solo equipos y olvidar procesos y datos |
| Amenaza | Fuente o evento con potencial de causar daño | Confundir la amenaza con la técnica que usa |
| Vulnerabilidad | Debilidad que una amenaza puede aprovechar | Tratar toda vulnerabilidad como un riesgo |
| Evento de riesgo | Lo que podría ocurrir | Redactarlo tan general que no se puede evaluar |
| Consecuencia | Efecto sobre un objetivo si el evento ocurre | Describirla solo como «pérdida de información» |
| Probabilidad | Verosimilitud de que el evento ocurra en un periodo | Confundir «posible» con «probable» |
| Riesgo | Efecto de la incertidumbre sobre los objetivos | Usar «riesgo» como sinónimo de amenaza o de vulnerabilidad |
| Riesgo residual | Riesgo que permanece después del tratamiento | Suponer que un control lo lleva a cero |

### Escenario de riesgo

Un riesgo no se enuncia como una palabra, sino como un **escenario** que se pueda evaluar. La forma mínima es:

```text
Si [fuente o evento] aprovecha [condición o debilidad] sobre [activo o proceso],
entonces [consecuencia] afectando [objetivo], con un efecto de [dimensión].
```

Comparación:

| Enunciado deficiente | Escenario evaluable |
| --- | --- |
| «Ransomware» | «Si un cifrado malicioso se propaga a los equipos de punto de venta durante la campaña, entonces los locales no pueden vender durante horas, afectando el objetivo de sostener la operación de noviembre, con efecto operativo y financiero.» |
| «Falta de respaldos» | «Si el respaldo declarado por el proveedor no es restaurable, entonces la recuperación tras un incidente no es posible en el plazo comprometido, afectando la continuidad del servicio.» |
| «Riesgo de datos personales» | «Si una exportación de despacho se envía al destinatario equivocado, entonces se divulgan datos de contacto de clientes, afectando obligaciones legales y confianza.» |

Un escenario mal redactado no se puede puntuar, no se puede asignar a un propietario y no se puede tratar. La mayor parte del trabajo de un registro de riesgos ocurre al escribir esta oración.

### El riesgo de ciberseguridad es riesgo del negocio

Una organización ya gestiona riesgos: financieros, laborales, de cumplimiento, de proveedores. El riesgo de ciberseguridad no es una categoría aparte que se administre con reglas propias: es una fuente más de riesgo para los mismos objetivos, y debe expresarse en términos que la dirección pueda comparar con los demás. Esa integración es el propósito de la guía NIST IR 8286.

Consecuencia práctica: un informe que solo dice «hay 47 vulnerabilidades críticas» no permite decidir nada. Un informe que dice «tres escenarios pueden detener la venta en campaña, con este efecto estimado y este propietario» sí.

## 2. El proceso completo y el lugar de la preparación

Las metodologías difieren en el nombre de las etapas, no en su lógica.

| Etapa | ISO/IEC 27005 e ISO 31000 | NIST SP 800-30 |
| --- | --- | --- |
| Preparar | Establecimiento del contexto | Preparar la evaluación |
| Identificar | Identificación del riesgo | Identificar fuentes, eventos y vulnerabilidades |
| Analizar | Análisis del riesgo | Determinar probabilidad e impacto |
| Evaluar | Evaluación del riesgo | Determinar el riesgo |
| Tratar | Tratamiento del riesgo | Responder al riesgo |
| Comunicar | Comunicación y consulta | Comunicar resultados |
| Supervisar | Seguimiento y revisión | Mantener la evaluación |

La primera fila condiciona todas las demás. Si el contexto está mal definido, el resto del trabajo se ejecuta correctamente sobre el problema equivocado.

## 3. Establecer el contexto

Establecer el contexto significa responder cuatro preguntas antes de mirar un solo riesgo.

### 3.1 Contexto externo

Qué ocurre fuera de la organización y la condiciona: obligaciones legales, exigencias contractuales, expectativas de clientes, dependencia de proveedores, situación del sector.

| Elemento | Pregunta | Efecto en el análisis |
| --- | --- | --- |
| Obligaciones legales | ¿Qué normas aplican al tratamiento de datos y a la operación? | Fijan un mínimo que no se puede aceptar como riesgo |
| Requisitos contractuales | ¿Qué exigen los contratos vigentes? | Pueden pesar más que una preferencia interna |
| Terceros | ¿De quién depende un proceso crítico? | Introducen riesgo que no se controla directamente |
| Expectativas | ¿Qué esperan clientes y usuarios? | Definen el daño reputacional |

### 3.2 Contexto interno

Objetivos, estructura, procesos, capacidades, cultura y **restricciones**. Las restricciones son el elemento que más se omite y el que más afecta la utilidad del resultado: presupuesto cerrado, una sola persona dedicada, ventanas de congelamiento de cambios, sistemas que no se pueden modificar.

Un análisis que ignora las restricciones produce recomendaciones que nadie puede ejecutar. Declararlas no es resignación: es la diferencia entre un plan y una lista de deseos.

### 3.3 Alcance

El alcance define qué entra y qué queda fuera. Se escribe con tres partes:

```text
Incluye:   procesos, sistemas, datos, ubicaciones y periodo.
Excluye:   lo mismo, en negativo.
Por cada exclusión: qué riesgo introduce y quién lo cubre.
```

La tercera parte es obligatoria. Excluir el sistema de punto de venta porque no se puede modificar es una decisión legítima; excluirlo sin declarar que eso deja sin analizar la venta presencial es un vacío que aparecerá más tarde como sorpresa.

Una solicitud como «evaluar todos los riesgos de la empresa en tres semanas» no es un alcance: es una expectativa. Traducirla en un objetivo verificable, acotado en procesos y periodo, es parte del trabajo profesional y se hace por escrito.

### 3.4 Criterios

Los criterios son las reglas con que se medirá y comparará. Incluyen las escalas de probabilidad e impacto, las dimensiones de impacto, el apetito y la tolerancia, y las condiciones de aceptación y escalamiento. Se definen **antes** de evaluar el primer riesgo, por una razón simple: definirlos después permite ajustarlos para que el resultado coincida con la conclusión deseada.

## 4. De los objetivos a los procesos críticos

El contexto se hace concreto siguiendo una cadena:

```text
objetivo organizacional -> proceso que lo sostiene -> sistema o dato que soporta el proceso
  -> dependencia externa -> ventana de tiempo en que importa
```

Ejemplo aplicado:

| Eslabón | Contenido |
| --- | --- |
| Objetivo | Sostener la venta de la campaña de noviembre |
| Proceso | Venta en línea y despacho |
| Soporte | Sitio y base de datos alojados en un proveedor |
| Dependencia | El proveedor controla la infraestructura y los respaldos |
| Ventana | Del 1 al 30 de noviembre, con máxima concentración de ingreso |

Esta cadena permite dos cosas que después serán decisivas: justificar por qué un proceso se incluye en el alcance y explicar por qué la misma indisponibilidad tiene efectos distintos según la fecha.

**Criticidad no es lo mismo que importancia percibida.** Un proceso es crítico cuando su interrupción afecta un objetivo declarado dentro de una ventana conocida. La analítica comercial puede ser muy valorada y no ser crítica.

## 5. Partes interesadas y comunicación

Una parte interesada es cualquier persona o entidad que afecta la decisión o se ve afectada por ella. Identificarlas tiene una consecuencia operativa: define a quién se consulta, a quién se informa y quién decide.

| Pregunta | Para qué sirve |
| --- | --- |
| ¿Qué espera de este análisis? | Evita entregar un producto que nadie pidió |
| ¿Qué decide realmente? | Distingue opinión de autoridad |
| ¿Qué información necesita y en qué lenguaje? | La dirección necesita efecto sobre objetivos, no detalle técnico |
| ¿Con qué frecuencia debe informarse? | Convierte la comunicación en un compromiso verificable |

Confundir «tener interés» con «tener autoridad» genera un problema recurrente: se consulta mucho y no se decide nada. En el registro de riesgos, la autoridad se declara de forma explícita.

## 6. Apetito y tolerancia al riesgo

Estos dos términos se confunden con frecuencia y son distintos.

| Concepto | Qué es | Quién lo fija | Cómo se expresa |
| --- | --- | --- | --- |
| Apetito | Cantidad y tipo de riesgo que la organización está dispuesta a asumir para perseguir sus objetivos | La dirección, de forma estratégica | Declaración cualitativa amplia, por categoría de riesgo |
| Tolerancia | Variación aceptable respecto de un objetivo concreto | La dirección o el propietario del riesgo, sobre un objetivo específico | Umbral medible, con indicador y periodo |
| Capacidad | Máximo que la organización podría soportar sin comprometer su existencia | Determinada por su tamaño y solvencia | Límite superior, rara vez alcanzado |

Ejemplo de la diferencia:

```text
Apetito:     «No aceptamos riesgos que expongan datos personales de clientes.»
Tolerancia:  «Ningún incidente de privacidad notificable por trimestre; una exportación
              con destinatario erróneo obliga a revisión del proceso en 5 días hábiles.»
```

El apetito orienta; la tolerancia permite detectar cuándo se cruzó un límite. Una declaración de apetito sin tolerancias asociadas no cambia ninguna decisión.

### Un apetito que sirve es diferenciado

Una organización no tiene un solo apetito. Suele aceptar más riesgo donde compite y menos donde puede perder su licencia para operar:

| Tipo de riesgo | Apetito habitual | Razón |
| --- | --- | --- |
| Indisponibilidad en campaña | Muy bajo | Afecta directamente el objetivo de ingreso |
| Fraude en pagos | Bajo, con umbral definido | Existe un límite contractual y un costo conocido |
| Retraso en analítica interna | Alto | No afecta compromisos externos |
| Exposición de datos personales | Muy bajo | Obligación legal, no preferencia |

Cuando una obligación legal es el origen de la restricción, no se trata de apetito: no se puede «aceptar» incumplir la ley. Se declara como requisito mínimo.

## 7. Criterios de evaluación: escalas que se pueden defender

### 7.1 Escalas de probabilidad

Una escala de cinco niveles sin descriptores es inútil, porque cada persona interpreta «medio» de manera distinta. El descriptor debe ser **observable**: una frecuencia, una condición verificable o una referencia histórica.

| Nivel | Etiqueta | Descriptor observable |
| ---: | --- | --- |
| 1 | Muy baja | Cero ocurrencias en los últimos 24 meses y la condición necesaria no está presente |
| 2 | Baja | Cero ocurrencias en los últimos 24 meses, pero existe una condición o dependencia que lo hace posible |
| 3 | Media | Una ocurrencia registrada en los últimos 24 meses |
| 4 | Alta | Entre dos y nueve ocurrencias registradas en los últimos 24 meses |
| 5 | Muy alta | Diez o más ocurrencias en los últimos 24 meses, o la condición ya está activa |

La escala se **calibra** con datos: si un tipo de evento tiene tres ocurrencias en 24 meses, ubicarlo en el nivel 1 obliga a explicar por qué.

### 7.2 Dimensiones de impacto

El impacto no es un número único. Se descompone en dimensiones, y el nivel del escenario es normalmente el mayor de sus dimensiones.

| Dimensión | Qué mide | Ejemplo de descriptor de nivel 4 |
| --- | --- | --- |
| Financiero | Pérdida directa o ingreso no realizado | Entre 30 y 80 millones de pesos |
| Operativo | Interrupción de un proceso crítico | Un proceso crítico detenido entre 4 y 24 horas |
| Legal y privacidad | Incumplimiento u obligación de notificar | Incidente notificable a la autoridad de protección de datos |
| Reputacional | Pérdida de confianza | Cobertura pública o reclamos masivos de clientes |
| Personas | Daño a la seguridad de personas | Se incorpora solo si el proceso puede afectarla |

Dos exigencias:

1. Los descriptores financieros deben usar cifras coherentes con el tamaño de la organización. Un umbral de «más de 1.000 millones» en una empresa cuyo ingreso anual es de 18.000 millones deja todo en nivel 1.
2. Una dimensión que no aplica se declara «no aplica», no se rellena con un valor bajo.

### 7.3 Límites de las matrices

La matriz de probabilidad por impacto es una herramienta de comunicación, no un cálculo. Sus límites conocidos son:

- Los niveles son **ordinales**: el 4 no vale el doble que el 2, y multiplicarlos produce un número sin significado real.
- Distintos escenarios pueden caer en la misma celda y requerir decisiones muy distintas.
- Rangos mal diseñados concentran todo en el centro y ocultan las diferencias.

Por eso el resultado se acompaña siempre del escenario redactado, del supuesto usado y de la dimensión que determinó el nivel. La celda resume; no reemplaza el razonamiento.

### 7.4 Criterios de aceptación y escalamiento

| Criterio | Contenido | Ejemplo |
| --- | --- | --- |
| Aceptación | Bajo qué condición un riesgo puede quedar sin tratamiento | Riesgos de nivel bajo, con revisión semestral y registro firmado |
| Escalamiento | Qué obliga a subir la decisión | Todo riesgo que afecte datos personales o la ventana de campaña |
| Autoridad | Quién puede aceptar y hasta qué nivel | La jefatura de tecnología acepta riesgos operativos bajos; la gerencia general, los demás |
| Revisión | Cuándo se vuelve a mirar | Antes de la campaña y ante cambio de proveedor |

Aceptar un riesgo es una decisión formal y trazable, no la ausencia de decisión. Un riesgo que nadie trata y que nadie aceptó por escrito está simplemente ignorado.

## 8. Quién responde: propiedad del riesgo

| Rol | Responsabilidad | Requisito |
| --- | --- | --- |
| Propietario del riesgo | Decide sobre el riesgo, acepta o exige tratamiento y responde por el resultado | Debe tener autoridad sobre el proceso y acceso a recursos |
| Responsable del control | Ejecuta e implementa la medida | Debe tener capacidad técnica y tiempo asignado |
| Área de seguridad | Facilita el método, consolida el registro y advierte | No es propietaria de riesgos que no controla |
| Dirección | Fija apetito, aprueba criterios y supervisa | Responde por la estrategia, no por cada riesgo |

El error más común es asignar todos los riesgos al área de seguridad. Si el riesgo es que la venta en línea se detenga en campaña, el propietario es quien responde por la venta en línea; seguridad aporta el análisis y el control, no la decisión.

Un buen indicador de que la asignación está mal hecha: el propietario declarado no puede autorizar el gasto ni detener el proceso. En ese caso, el propietario real es otra persona.

## 9. El registro de riesgos

El registro es el producto vivo del proceso. Sus campos mínimos:

| Campo | Contenido | Por qué es necesario |
| --- | --- | --- |
| Identificador | `R-01`, `R-02` | Permite referirse al riesgo sin repetir su texto |
| Escenario | Enunciado completo con evento, activo y consecuencia | Es lo que realmente se evalúa |
| Proceso u objetivo afectado | Vínculo con el contexto | Justifica por qué está en el registro |
| Categoría | Operativo, legal, fraude, terceros, continuidad | Permite agrupar y comparar |
| Propietario del riesgo | Persona con autoridad | Sin propietario no hay decisión |
| Responsable del control | Quien ejecuta | Separa decisión de ejecución |
| Dimensiones de impacto | Cuáles aplican | Evita comparar cosas distintas |
| Probabilidad e impacto | Niveles según las escalas definidas | Permite comparar y priorizar |
| Respuesta | Evitar, reducir, transferir o aceptar | Declara qué se hará con el riesgo |
| Supuestos y datos faltantes | Lo que se asumió y lo que no se sabe | Hace revisable el resultado |
| Estado y fecha de revisión | Identificado, en tratamiento, aceptado, cerrado | Convierte el registro en un instrumento de seguimiento |

Durante la preparación del contexto se completan los campos de identificación, propiedad y supuestos. La valoración llega después: puntuar antes de tener escalas definidas produce cifras que nadie puede defender.

### Supuestos y datos faltantes

Un análisis honesto declara lo que no sabe. El formato es fijo:

```text
Dato que falta:
Supuesto provisional adoptado:
Quién puede entregar el dato:
Qué cambiaría si el supuesto resulta falso:
```

La última línea es la que da valor al registro: identifica qué conclusiones son frágiles y merecen verificarse primero.

## 10. Riesgo de terceros dentro del contexto

Cuando un proceso crítico depende de un proveedor, la organización transfiere la **operación**, no la responsabilidad frente a sus clientes ni frente a la ley. El contexto debe registrar, por cada dependencia:

| Pregunta | Efecto |
| --- | --- |
| ¿Qué proceso soporta y en qué ventana? | Determina la criticidad de la dependencia |
| ¿Qué controla el proveedor y qué controlamos nosotros? | Delimita qué se puede exigir y qué no |
| ¿Qué dice el contrato sobre disponibilidad, incidentes y datos? | Define el poder real de exigir |
| ¿Qué evidencia entrega y con qué periodicidad? | Sustituye a la verificación directa cuando no es posible |
| ¿Qué ocurre si el servicio se interrumpe o el contrato termina? | Es un riesgo propio, no del proveedor |

Un contrato estándar sin acuerdo de nivel de servicio negociado no es un vacío del proveedor: es un riesgo aceptado por la organización, aunque nadie lo haya declarado.

## 11. Conexión con el marco CSF 2.0

El marco de ciberseguridad del NIST, en su versión 2.0, organiza los resultados esperados en seis funciones: **GOVERN, IDENTIFY, PROTECT, DETECT, RESPOND y RECOVER**. La función GOVERN se incorporó en esa versión y reúne precisamente los elementos que definen el contexto y los criterios.

| Categoría de GOVERN | Contenido | Elemento del contexto al que corresponde |
| --- | --- | --- |
| Contexto organizacional | Misión, expectativas, obligaciones y dependencias | Contexto externo e interno |
| Estrategia de gestión del riesgo | Apetito, tolerancia y criterios | Escalas y umbrales de tolerancia |
| Roles, responsabilidades y autoridades | Quién decide y quién ejecuta | Propietario del riesgo y responsable del control |
| Política | Reglas formalizadas | Documento de política, posterior a la definición de criterios |
| Supervisión | Revisión de la estrategia por la dirección | Criterios de revisión y escalamiento |
| Riesgo de la cadena de suministro | Gestión de terceros | Dependencias externas declaradas |

### Perfil actual y perfil objetivo

Un **perfil** describe los resultados del marco que una organización efectivamente logra o pretende lograr.

| Perfil | Pregunta | Uso |
| --- | --- | --- |
| Actual | ¿Qué resultados se cumplen hoy y con qué evidencia? | Punto de partida honesto |
| Objetivo | ¿Qué resultados se quieren alcanzar y para cuándo? | Depende del contexto, del apetito y de las restricciones |

La distancia entre ambos perfiles es la base del plan de acción. Un perfil objetivo definido sin considerar las restricciones produce un plan imposible; definido sin considerar las obligaciones legales, produce un plan inaceptable.

El marco también describe **niveles de implementación** (del 1 al 4) que caracterizan cuán formal y coordinada es la gestión del riesgo. No son una calificación ni una meta obligatoria: subir de nivel solo tiene sentido si el contexto lo justifica.

## 12. Errores frecuentes

| Error | Consecuencia | Corrección |
| --- | --- | --- |
| Puntuar antes de definir escalas | Los números no significan lo mismo para dos personas | Definir descriptores observables primero |
| Escalas sin descriptor | La evaluación no es reproducible | Asociar frecuencia o condición a cada nivel |
| Umbrales financieros desproporcionados | Todo queda en nivel bajo | Calibrar con el tamaño de la organización |
| Aceptar «evaluar todo» como alcance | El análisis no termina o queda superficial | Traducir a objetivo verificable y acotado |
| Exclusiones sin declarar su riesgo | Aparecen vacíos inesperados | Registrar qué deja de cubrirse y quién lo asume |
| Un solo apetito para toda la organización | No orienta ninguna decisión | Diferenciar por tipo de riesgo |
| Confundir apetito con tolerancia | No hay umbral que permita detectar el exceso | Declarar un indicador medible por objetivo |
| Asignar todos los riesgos a seguridad | Nadie con autoridad decide | Asignar a quien responde por el proceso |
| Propietario sin autoridad ni presupuesto | La decisión nunca se toma | Elevar la asignación |
| Tratar un requisito legal como apetito | Se «acepta» un incumplimiento | Declararlo como mínimo no negociable |
| Omitir supuestos | El resultado no se puede revisar | Declarar dato faltante y supuesto provisional |
| Ignorar restricciones | Recomendaciones inaplicables | Registrar presupuesto, personal y ventanas |

## 13. Ejemplo resuelto - caso VIÑA DEL ESTE (ficticio)

Una empresa de servicios logísticos con 60 personas pide «un análisis de riesgos de ciberseguridad». La dirección declara dos objetivos: cumplir los plazos de entrega comprometidos y mantener la certificación de un cliente importante.

### Objetivo y alcance

```text
Objetivo:  establecer el contexto y los criterios con que posteriormente se identificarán
           y priorizarán los riesgos que puedan interrumpir el despacho o comprometer datos
           de clientes, entre octubre y diciembre de 2026.
Incluye:   proceso de despacho, sistema de seguimiento de carga, base de datos de clientes,
           correo corporativo y el proveedor de rastreo satelital.
Excluye:   la red de las oficinas administrativas, porque no soporta el proceso de despacho.
           Riesgo que introduce: un compromiso en oficinas podría alcanzar el correo; se
           mitiga incluyendo el correo en el alcance. Cubre: jefatura de tecnología.
Autoriza:  gerencia de operaciones.
```

### Escalas calibradas con datos propios

| Nivel | Probabilidad | Impacto operativo |
| ---: | --- | --- |
| 1 | No registrado en el sector ni en la empresa | Sin efecto perceptible en el despacho |
| 3 | Un caso en los últimos 24 meses | Despacho degradado entre 2 y 8 horas |
| 5 | Diez o más casos en 24 meses, o condición activa | Despacho detenido más de 24 horas |

La empresa registró dos interrupciones del proveedor de rastreo en el último año; ese dato fija el nivel 4 de probabilidad para ese escenario y evita una discusión de opiniones.

### Apetito y tolerancia

```text
Apetito:    bajo para interrupciones del despacho; muy bajo para pérdida de datos de clientes;
            medio para indisponibilidad de herramientas internas de apoyo.
Tolerancia: ninguna interrupción del seguimiento de carga superior a 4 horas por trimestre;
            ningún incidente de datos de clientes notificable.
Escala a:   gerencia de operaciones cuando se supere el umbral o el tratamiento exceda
            el presupuesto aprobado.
```

### Propiedad

| Escenario | Propietario del riesgo | Responsable del control |
| --- | --- | --- |
| Interrupción del proveedor de rastreo | Gerencia de operaciones | Jefatura de tecnología |
| Exposición de datos de clientes | Gerencia general | Jefatura de tecnología con asesoría legal |
| Cuentas de personas desvinculadas activas | Jefatura de personas | Jefatura de tecnología |

### Supuestos declarados

```text
Dato que falta: cláusula de disponibilidad del contrato de rastreo satelital.
Supuesto provisional: no existe compromiso formal de disponibilidad.
Quién lo entrega: administración de contratos.
Qué cambiaría: si existe un compromiso con penalización, la respuesta puede ser exigir
               su cumplimiento en lugar de financiar una alternativa.
```

### Conclusión de la etapa

> El análisis quedó acotado al proceso de despacho y a los datos de clientes entre octubre y diciembre de 2026, con escalas calibradas mediante los eventos registrados en los últimos 24 meses. La organización declara tolerancia nula ante incidentes de datos de clientes y un umbral de 4 horas para la interrupción del seguimiento de carga. Tres escenarios tienen propietario asignado con autoridad sobre su proceso. Esta ficha no evalúa todavía la magnitud de los riesgos: fija las reglas con las que se evaluarán en la etapa siguiente.

## 14. Glosario

| Término | Definición |
| --- | --- |
| Alcance | Delimitación explícita de qué se analiza, qué queda fuera y en qué periodo. |
| Apetito al riesgo | Cantidad y tipo de riesgo que la organización está dispuesta a asumir para lograr sus objetivos. |
| Capacidad de riesgo | Máximo que la organización puede soportar sin comprometer su viabilidad. |
| Criterio de aceptación | Condición bajo la cual un riesgo puede permanecer sin tratamiento, con decisión registrada. |
| Descriptor observable | Frecuencia o condición verificable que define un nivel de una escala. |
| Escenario de riesgo | Enunciado que relaciona un evento posible, un activo o proceso y una consecuencia sobre un objetivo. |
| Escalamiento | Regla que obliga a elevar una decisión a un nivel de autoridad superior. |
| Perfil | Descripción de los resultados del marco que una organización logra (actual) o pretende lograr (objetivo). |
| Propietario del riesgo | Persona con autoridad para decidir sobre un riesgo y responsable de su resultado. |
| Registro de riesgos | Documento vivo donde se identifican, evalúan, asignan y siguen los riesgos. |
| Riesgo residual | Riesgo que permanece después de aplicar el tratamiento. |
| Tolerancia al riesgo | Variación aceptable respecto de un objetivo concreto, expresada con un umbral medible. |

## Fuentes

- [NIST IR 8286 Rev. 1 - Integrating Cybersecurity and Enterprise Risk Management](https://csrc.nist.gov/pubs/ir/8286/r1/final). Apetito, tolerancia, registro de riesgos y comunicación con la dirección.
- [NIST Cybersecurity Framework 2.0](https://www.nist.gov/cyberframework). Función GOVERN, contexto organizacional, perfiles actual y objetivo.
- [NIST SP 800-30 Rev. 1 - Guide for Conducting Risk Assessments](https://csrc.nist.gov/pubs/sp/800/30/r1/final). Preparación de la evaluación y determinación de probabilidad e impacto.
- [ISO/IEC 27005:2022 - Guidance on managing information security risks](https://www.iso.org/standard/80585.html). Establecimiento del contexto y criterios de riesgo.
- [ISO 31000:2018 - Risk management guidelines](https://www.iso.org/standard/65694.html). Principios, marco y proceso de gestión del riesgo.
- [Ley 19.628 - Protección de la vida privada](https://www.bcn.cl/leychile/Navegar?idNorma=141599&idParte=8642680). Texto vigente al momento de la clase y modificaciones diferidas.
- [Ley 21.096 - Derecho a la protección de los datos personales](https://www.bcn.cl/leychile/navegar?i=1119730&f=2018-06-16). Protección constitucional.
- [Ley 21.719 - Protección y tratamiento de datos personales](https://www.bcn.cl/leychile/navegar?i=1209272). Reforma con entrada en vigencia el 1 de diciembre de 2026.
- [Ley 21.663 - Ley Marco de Ciberseguridad](https://www.bcn.cl/leychile/navegar?i=1202434). Ámbito de aplicación y calificación formal de operadores de importancia vital.
