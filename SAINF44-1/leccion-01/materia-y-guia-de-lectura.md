---
title: "Materia y guía de lectura - Cyber Kill Chain y controles"
tags:
  - nota
  - course
  - curso
  - materia-y-guia-de-lectura
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "01"
author: Jordy
start: 2026-08-10
end: 2026-08-11
created_at: "2026-08-06 17:21"
aliases:
  - "Materia y guía de lectura - Cyber Kill Chain y controles"
---

# Materia y guía de lectura - Cyber Kill Chain y controles

```toc
```

## Propósito de esta guía

Esta guía contiene todo el contenido conceptual necesario para la primera lección. Utiliza la Cyber Kill Chain para contar la historia de una intrusión, reconocer oportunidades defensivas y relacionar cada control con una prueba sencilla de funcionamiento.

No se requiere experiencia previa ni memorizar los nombres en inglés. Las fuentes externas del final son respaldo y profundización opcional. La finalidad es aprender a analizar ataques desde la defensa; no se incluyen instrucciones para ejecutarlos.

## Ruta mínima de preparación

Estudia en este orden:

1. Para qué sirve una cadena de ataque.
2. Conceptos esenciales: activo, amenaza, vulnerabilidad, riesgo y control.
3. Las siete fases mediante el caso BAHÍA LOGÍSTICA.
4. Controles preventivos y detectivos.
5. Evidencia de funcionamiento.
6. Límites de la Kill Chain y diferencia básica con MITRE ATT&CK.
7. Autoevaluación.

### Criterio de suficiencia

Estás preparado cuando puedes:

- Explicar para qué sirve la Cyber Kill Chain.
- Ordenar y describir las siete fases con apoyo visual.
- Relacionar al menos cinco hechos del caso con fases razonables.
- Proponer dos controles coherentes, uno preventivo o detectivo.
- Indicar un registro, alerta o prueba que permita comprobar cada control.
- Reconocer que un ataque real puede omitir, repetir o mezclar fases.

## Objetivos de estudio

Al finalizar deberías poder:

- Usar la Cyber Kill Chain para organizar hechos de una intrusión.
- Distinguir activo, amenaza, vulnerabilidad, consecuencia y control.
- Explicar las siete fases con palabras sencillas.
- Identificar puntos donde un ataque puede prevenirse, detectarse o limitarse.
- Diferenciar un control declarado de un control verificable.
- Reconocer el carácter simplificado y no universal del modelo.

## 1. ¿Para qué sirve una cadena de ataque?

Un incidente suele presentarse como hechos desordenados: un correo, una autenticación, un proceso, una conexión y una descarga. Una cadena de ataque ayuda a convertir esos hechos en una historia comprensible:

1. ¿Qué preparó el adversario?
2. ¿Cómo llegó a la organización?
3. ¿Qué le permitió avanzar?
4. ¿Cómo mantuvo el acceso?
5. ¿Qué objetivo intentó alcanzar?

La **Cyber Kill Chain** organiza una intrusión en siete fases. Desde la perspectiva defensiva, su valor principal es mostrar que no es necesario esperar al daño final: se puede prevenir, detectar o interrumpir el avance en distintos momentos.

Por ejemplo, ante un correo de phishing se podría:

- Reducir la información pública utilizada para personalizar el engaño.
- Detectar un dominio que suplanta a un proveedor.
- Bloquear el mensaje o la página falsa.
- Evitar el uso de credenciales robadas mediante MFA.
- Detectar una herramienta remota no autorizada.
- Limitar el acceso a la base de clientes.

Interrumpir una fase dificulta el ataque, pero no garantiza que el adversario no utilice otra vía. Por eso la Kill Chain es una herramienta para razonar, no una receta infalible.

## 2. Conceptos esenciales

| Concepto | Explicación sencilla | Ejemplo en BAHÍA LOGÍSTICA |
| --- | --- | --- |
| Activo | Recurso con valor que debe protegerse. | Cuenta de Finanzas y base de clientes. |
| Amenaza | Actor, circunstancia o evento capaz de causar daño. | Persona que intenta obtener acceso no autorizado. |
| Vulnerabilidad o condición habilitante | Debilidad que puede ser aprovechada. | Proceso débil para verificar facturas o autenticación insuficiente. |
| Ataque | Conjunto de acciones destinadas a aprovechar condiciones y alcanzar un objetivo. | Phishing seguido de uso de credenciales. |
| Consecuencia | Efecto que la organización podría sufrir. | Exposición de datos de clientes. |
| Riesgo | Posibilidad de que una amenaza aproveche una vulnerabilidad y produzca consecuencias. | Acceso indebido a datos mediante una cuenta comprometida. |
| Control | Medida que modifica el riesgo. | Filtro de correo, MFA, EDR o mínimo privilegio. |
| Evidencia de funcionamiento | Información que permite comprobar que el control opera. | Log de bloqueo, alerta, resultado de prueba o configuración revisada. |

### No confundir herramienta con control efectivo

Decir “tenemos un firewall” solo indica que existe una tecnología. Para hablar de un control se necesita, como mínimo:

- Un objetivo: qué se desea impedir o detectar.
- Un alcance: qué activos, usuarios o tráfico cubre.
- Una configuración o procedimiento.
- Una persona responsable.
- Una prueba, alerta, registro o métrica que demuestre su operación.

## 3. Las siete fases mediante un solo caso

Usaremos durante toda la lección este caso:

> Un atacante recopila nombres de empleados de BAHÍA LOGÍSTICA en redes profesionales y registra un dominio parecido al de un proveedor. Envía a Finanzas una “factura urgente” con un enlace a una página falsa. Un usuario entrega sus credenciales; después se inicia sesión desde un país no habitual, aparece una herramienta de acceso remoto y se descarga una base de clientes.

### 3.1 Reconocimiento

**Pregunta:** ¿qué información busca el adversario para preparar el ataque?

El adversario reúne datos sobre personas, tecnologías, proveedores, servicios expuestos o hábitos. En el caso, recopila nombres y cargos de empleados.

- **Señal posible:** consultas, escaneos o solicitudes inusuales de información.
- **Control posible:** reducir exposición innecesaria y monitorear marca o superficie pública.
- **Evidencia:** revisión de exposición, alerta o registro de la gestión realizada.

Gran parte del reconocimiento ocurre fuera de la organización y puede ser difícil de observar.

### 3.2 Armamentización o preparación

**Pregunta:** ¿qué recurso prepara para engañar o atacar?

El adversario crea o adapta infraestructura, contenido o herramientas. En el caso, registra un dominio parecido y prepara una página falsa.

- **Señal posible:** dominio o certificado que imita a la organización o a un proveedor.
- **Control posible:** monitoreo de dominios similares y proceso de reporte o retiro.
- **Evidencia:** alerta de suplantación y ticket con las acciones realizadas.

Esta fase también puede ocurrir completamente fuera de la visibilidad interna.

### 3.3 Entrega

**Pregunta:** ¿cómo llega el recurso al objetivo?

El adversario utiliza un canal: correo, enlace, sitio web, medio removible, tercero o acceso físico. En el caso, envía la factura urgente a Finanzas.

- **Señal posible:** mensaje, enlace o archivo inesperado.
- **Control posible:** filtro de correo, autenticación de dominio, filtrado web y canal de reporte.
- **Evidencia:** log que muestra si el mensaje fue bloqueado o permitido.

### 3.4 Explotación

**Pregunta:** ¿qué debilidad o interacción le permite avanzar?

El adversario aprovecha una vulnerabilidad técnica, una credencial o una interacción humana para obtener acceso o ejecución. En el caso, la página falsa captura las credenciales.

No toda explotación utiliza software malicioso. Engañar a una persona para que entregue una contraseña también puede habilitar el acceso.

- **Señal posible:** autenticación desde un contexto inusual después del phishing.
- **Control posible:** MFA resistente a phishing, filtrado web y verificación del proceso de facturas.
- **Evidencia:** log de desafío o bloqueo y resultado de una prueba controlada.

### 3.5 Instalación

**Pregunta:** ¿qué capacidad deja instalada o habilitada?

El adversario intenta establecer persistencia o una capacidad para seguir actuando. En el caso, aparece una herramienta de acceso remoto no autorizada.

- **Señal posible:** nuevo servicio, tarea, aplicación, cuenta o cambio de configuración.
- **Control posible:** allowlisting, EDR, mínimo privilegio y monitoreo de cambios.
- **Evidencia:** alerta o bloqueo de la ejecución y revisión de cobertura del agente.

Algunos ataques no necesitan instalar nada: pueden abusar de cuentas, servicios cloud o herramientas legítimas.

### 3.6 Comando y control — C2

**Pregunta:** ¿cómo mantiene la comunicación o dirige la capacidad comprometida?

El adversario establece un canal para enviar instrucciones o recibir resultados. En el caso, la herramienta y la sesión remota podrían ofrecer ese canal.

- **Señal posible:** conexión periódica, destino inusual o sesión fuera del contexto esperado.
- **Control posible:** filtrado de salida, proxy, segmentación y detección de comportamiento.
- **Evidencia:** log de conexión bloqueada o alerta correlacionada.

Una sesión anómala no demuestra automáticamente C2. El mapeo depende de lo que realmente permita observar la fuente.

### 3.7 Acciones sobre los objetivos

**Pregunta:** ¿qué resultado busca finalmente?

El adversario accede, extrae, modifica, destruye o utiliza activos para obtener un beneficio o causar impacto. En el caso, descarga la base de clientes.

- **Señal posible:** acceso masivo, compresión, transferencia o modificación inusual de datos.
- **Control posible:** mínimo privilegio, segmentación, auditoría de datos, DLP y respaldos.
- **Evidencia:** registro de acceso, alerta de volumen, evento DLP o prueba de restauración.

## 4. Tabla de estudio rápido

| Fase | Pregunta sencilla | Hecho principal del caso |
| --- | --- | --- |
| Reconocimiento | ¿Qué información busca? | Nombres y cargos públicos. |
| Armamentización | ¿Qué prepara? | Dominio parecido y página falsa. |
| Entrega | ¿Cómo llega? | Correo con factura urgente. |
| Explotación | ¿Qué le permite avanzar? | Entrega de credenciales. |
| Instalación | ¿Qué deja habilitado? | Herramienta de acceso remoto. |
| Comando y control | ¿Cómo mantiene comunicación o acceso? | Canal o sesión remota. |
| Acciones sobre objetivos | ¿Qué hace finalmente? | Descarga de la base de clientes. |

Una forma sencilla de recordarlas es:

> **Busca → prepara → entrega → aprovecha → se instala → se comunica → actúa.**

El objetivo no es recitar los nombres, sino reconstruir la historia y encontrar puntos de defensa.

## 5. Relacionar fase, control y evidencia

Para evitar recomendaciones vagas, utiliza esta secuencia:

**hecho observado → fase razonable → activo afectado → control → evidencia de funcionamiento**

### Ejemplo

- **Hecho:** llega un correo con una factura falsa.
- **Fase:** entrega.
- **Activo:** cuenta y proceso de Finanzas.
- **Control:** filtro de correo.
- **Evidencia:** registro que muestra si el mensaje fue bloqueado, puesto en cuarentena o permitido.

Una recomendación débil sería “comprar una solución de inteligencia artificial”. No explica qué conducta modifica, qué activo protege ni cómo se comprobará el resultado.

### Preguntas para evaluar una propuesta

1. ¿Qué hecho del caso respalda la fase seleccionada?
2. ¿Qué activo intenta proteger el control?
3. ¿El control busca prevenir, detectar, corregir o recuperar?
4. ¿Qué log, alerta, configuración o prueba mostraría que funciona?
5. ¿Quién debería revisar esa evidencia y actuar?

## 6. Clasificación inicial de controles

Para esta primera clase basta comprender cuatro funciones:

| Función | Propósito | Ejemplo |
| --- | --- | --- |
| Preventivo | Intenta impedir o reducir la probabilidad. | MFA o filtro de correo. |
| Detectivo | Descubre una actividad o desviación. | Alerta de dominio similar o EDR. |
| Correctivo | Corrige una condición después de detectarla. | Revocar credenciales o retirar persistencia. |
| Recuperación | Restablece capacidades o datos. | Restaurar un respaldo probado. |

Una medida puede cumplir más de una función. Por ejemplo, un EDR puede bloquear una ejecución y también generar una alerta. Lo importante es declarar qué se espera que haga en el contexto analizado.

### Defensa en profundidad

Ningún control es perfecto. La defensa en profundidad combina capas para que el fallo de una no deje el activo sin protección:

- El filtro intenta detener la entrega.
- La capacitación facilita que el usuario reconozca y reporte.
- MFA reduce la utilidad de una contraseña robada.
- EDR intenta bloquear o detectar ejecución e instalación.
- Mínimo privilegio limita el acceso a datos.
- Monitoreo permite investigar y responder.

## 7. Evidencia de funcionamiento

Un control efectivo no se demuestra con su nombre ni con una captura aislada. Se necesita evidencia vinculada con el resultado esperado.

| Control | Evidencia sencilla |
| --- | --- |
| Filtro de correo | Logs de mensajes bloqueados y una prueba controlada. |
| MFA | Política aplicada, registros de desafíos y prueba de acceso denegado. |
| EDR | Cobertura de agentes, alerta y resultado de una prueba autorizada. |
| Mínimo privilegio | Matriz de acceso revisada y prueba de denegación. |
| Respaldo | Registro de ejecución y restauración comprobada. |

Conviene distinguir:

- **Diseño:** explica cómo debería funcionar el control.
- **Implementación:** confirma que está configurado en el alcance correcto.
- **Operación:** demuestra que funciona de manera sostenida.
- **Efectividad:** muestra que reduce el riesgo esperado.

En la primera clase solo se exige proponer una evidencia concreta, no evaluar exhaustivamente los cuatro niveles.

## 8. Límites de la Cyber Kill Chain

La Kill Chain es útil, pero simplifica la realidad:

- Presenta una secuencia lineal; los ataques pueden repetir, mezclar u omitir fases.
- Algunas fases ocurren fuera de la visibilidad de la organización.
- El abuso de cuentas válidas, los servicios cloud o una amenaza interna pueden no seguir la secuencia clásica.
- Un hecho puede relacionarse razonablemente con más de una fase.
- Mapear fases no demuestra quién realizó el ataque.
- El modelo no calcula por sí solo probabilidad, impacto, costo ni prioridad.

No se debe forzar un hecho dentro de una fase. Es válido indicar “no observable”, “información insuficiente” o proponer más de un mapeo si se explica la ambigüedad.

## 9. Diferencia básica con MITRE ATT&CK

| Cyber Kill Chain | MITRE ATT&CK |
| --- | --- |
| Organiza una intrusión en siete fases generales. | Organiza comportamientos adversarios conocidos con mayor detalle. |
| Ayuda a contar la historia y localizar puntos de interrupción. | Ayuda a describir objetivos y técnicas específicas. |
| Tiene forma de secuencia simplificada. | No es una secuencia obligatoria. |

En ATT&CK:

- **Táctica:** objetivo del adversario, el “por qué”.
- **Técnica:** forma general de alcanzar ese objetivo, el “cómo”.

ATT&CK se menciona en esta clase solo como complemento. No es necesario navegar ni memorizar la matriz para cumplir el objetivo de la sesión.

## 10. Aplicación al caso BAHÍA LOGÍSTICA

### Hechos que deben ordenarse

1. Se recopilan nombres públicos.
2. Se prepara un dominio similar y una página falsa.
3. Llega un correo de factura urgente.
4. Un usuario entrega credenciales.
5. Se observa un inicio de sesión desde un país no habitual.
6. Aparece una herramienta de acceso remoto.
7. Se descarga una base de clientes.

### Preguntas para razonar

1. ¿Qué hecho respalda cada fase?
2. ¿Qué hecho podría corresponder a más de una fase?
3. ¿En qué dos puntos sería más sencillo prevenir o detectar el avance?
4. ¿Qué activo protege cada control propuesto?
5. ¿Qué registro o prueba permitiría verificarlo?
6. ¿Qué fase podría resultar difícil de observar internamente?

### Posibles puntos de defensa

- Monitoreo de dominios similares durante la preparación.
- Filtro de correo y procedimiento de verificación durante la entrega.
- MFA y filtrado web frente al uso de credenciales.
- EDR y mínimo privilegio frente a la herramienta remota.
- Auditoría de acceso, segmentación y DLP sobre la base de clientes.

No existe una única combinación correcta. La respuesta debe vincular el control con un hecho, un activo y una evidencia verificable.

## 11. Errores frecuentes

### “Cada hecho corresponde exactamente a una fase”

No siempre. Una sesión anómala puede representar acceso obtenido, actividad posterior o canal remoto. El contexto y la evidencia determinan el mapeo.

### “Explotación siempre significa usar un exploit técnico”

No. Una interacción humana o una credencial robada también puede permitir avanzar.

### “Instalación siempre significa malware”

No. Puede existir persistencia mediante una cuenta, una aplicación legítima, una regla cloud o una herramienta remota.

### “Si tenemos una herramienta, el control funciona”

La tecnología debe estar configurada, cubrir el activo, operar y producir evidencia revisable.

### “La Kill Chain identifica al atacante”

El modelo ordena comportamientos y oportunidades defensivas; no prueba identidad ni atribución.

### “ATT&CK es otra cadena de ataque”

ATT&CK es una base de conocimiento de comportamientos. Sus tácticas no deben leerse como pasos obligatorios de izquierda a derecha.

## 12. Qué se estudiará después

Para mantener la primera lección enfocada, estos contenidos se desarrollarán más adelante:

| Tema | Lección posterior |
| --- | --- |
| Vectores de ataque | Lección 02. |
| Clasificación completa y controles CIS | Lección 03. |
| AAA, control de acceso y firewall | Lección 04. |
| IDS/IPS y reglas Snort | Lección 05. |
| Gestión y valoración de riesgos | Lecciones 07 a 10. |
| Políticas, auditoría y métricas | Lección 11. |
| Respuesta, continuidad y recuperación | Lecciones 13 a 16. |

No es necesario estudiar todavía el catálogo CIS, configurar herramientas ni realizar un análisis formal de riesgos.

## 13. Guía de estudio

### Paso 1 - Contar la historia

Dibuja siete cajas y escribe, sin mirar:

1. El nombre de cada fase.
2. Su pregunta sencilla.
3. El hecho correspondiente del caso.

Después revisa la tabla de estudio rápido.

### Paso 2 - Pensar como defensor

Elige dos fases y completa:

| Fase | Activo | Control | Función | Evidencia de funcionamiento |
| --- | --- | --- | --- | --- |
|  |  |  |  |  |
|  |  |  |  |  |

Evita utilizar solo el nombre de una herramienta. Explica qué debería impedir o detectar.

### Paso 3 - Aplicar y explicar

1. Completa [[gestion-de-la-seguridad/leccion-01/actividad]].
2. Explica el caso en tres minutos sin leer.
3. Menciona una ambigüedad del mapeo.
4. Explica por qué los ataques reales pueden desviarse de la secuencia.

## Autoevaluación

### Preguntas

1. ¿Para qué sirve la Cyber Kill Chain desde la perspectiva defensiva?
2. Enumera y explica las siete fases con palabras sencillas.
3. ¿Por qué la armamentización puede ser difícil de observar internamente?
4. ¿Qué diferencia existe entre explotación e instalación?
5. Da un control preventivo y uno detectivo para la fase de entrega.
6. ¿Qué evidencia permitiría verificar que MFA está operando?
7. ¿Por qué una sesión anómala podría relacionarse con más de una fase?
8. ¿Qué significa defensa en profundidad?
9. ¿Cuál es la diferencia básica entre Kill Chain y ATT&CK?
10. Mejora esta recomendación: “Para detener el phishing hay que comprar un antivirus”.

### Respuestas orientativas

1. Sirve para ordenar hechos de una intrusión y localizar oportunidades de prevención, detección o interrupción.
2. Reconocimiento, armamentización, entrega, explotación, instalación, comando y control y acciones sobre objetivos; respectivamente: busca, prepara, entrega, aprovecha, se instala, se comunica y actúa.
3. Porque la preparación del dominio, contenido o infraestructura puede ocurrir fuera de los sistemas de la víctima.
4. Explotación obtiene ejecución, acceso o credenciales; instalación establece o habilita una capacidad posterior, con frecuencia persistente.
5. Preventivo: filtrado o autenticación de correo. Detectivo: alerta del gateway o canal de reporte del usuario.
6. Política aplicada al alcance, registros de desafío o bloqueo y resultados de pruebas autorizadas.
7. Porque puede representar el uso inicial de credenciales, actividad posterior o un canal remoto; se necesita contexto adicional.
8. Combinar capas para que el fallo de un control no deje el activo sin protección.
9. Kill Chain narra una secuencia general; ATT&CK describe comportamientos detallados y no funciona como una secuencia obligatoria.
10. “El phishing debe reducirse con controles sobre correo, navegación, identidad, reporte y endpoint; cada control debe asociarse con una prueba o registro de funcionamiento”.

## Fuentes base y profundización opcional

Estas fuentes respaldan el contenido. Su lectura no es obligatoria para esta lección.

- [Lockheed Martin - Cyber Kill Chain](https://www.lockheedmartin.com/en-us/capabilities/cyber/cyber-kill-chain.html): presentación general del modelo.
- [Lockheed Martin - Intelligence-Driven Computer Network Defense](https://www.lockheedmartin.com/content/dam/lockheed-martin/rms/documents/cyber/LM-White-Paper-Intel-Driven-Defense.pdf): documento técnico original sobre la intrusion kill chain.
- [MITRE ATT&CK - Get Started](https://attack.mitre.org/resources/): conceptos de tácticas, técnicas y procedimientos.
- [MITRE ATT&CK - Enterprise Matrix](https://attack.mitre.org/matrices/enterprise/): matriz de comportamientos para profundización posterior.

Fecha de consulta de recursos vivos: 06-08-2026.
