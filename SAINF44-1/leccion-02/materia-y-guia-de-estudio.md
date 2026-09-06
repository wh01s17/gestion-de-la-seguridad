---
title: "Materia y guía de estudio - Vectores de ataque"
tags:
  - nota
  - course
  - curso
  - materia
  - guia-de-estudio
  - vectores-de-ataque
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "02"
author: Jordy
start: 2026-08-17
end: 2026-08-18
created_at: "2026-08-06 17:32"
aliases:
  - "Materia y guía de estudio - Vectores de ataque"
---

# Materia y guía de estudio - Vectores de ataque

```toc
```

## Propósito de esta guía

Esta guía contiene todo el contenido necesario para la lección 02. Su propósito es aprender a reconocer **por dónde o mediante qué condición** una amenaza puede alcanzar un activo, justificar una clasificación y proponer un control inicial verificable.

Los 13 vectores utilizados corresponden a una agrupación pedagógica del programa. No constituyen una taxonomía oficial, universal ni cerrada. Un escenario puede combinar varios vectores.

La guía sirve por igual para la actividad A (`actividad.md`) y la actividad B (`actividad-02.md`). Cada sección resolverá solo una versión.

### Alcance de esta lección

En esta sesión se reconocen vectores, activos, condiciones y consecuencias; luego se realiza un **triage cualitativo inicial**. Todavía no se clasifican controles por naturaleza o función, no se configuran controles, no se calculan niveles de riesgo y no se construyen matrices. Esos contenidos corresponden a las lecciones 03–05 y 07–10.

## Ruta mínima de preparación

Estudia en este orden:

1. Vocabulario: activo, amenaza, vector, vulnerabilidad, técnica e impacto.
2. Método para analizar un escenario.
3. Los 13 vectores y sus diferencias.
4. Vectores combinados y clasificación justificada.
5. Triage cualitativo y evidencia básica de controles.
6. Uso introductorio de OWASP y ATT&CK.
7. Actividad y autoevaluación.

### Criterio de suficiencia

Estás preparado cuando puedes:

- Diferenciar vector, amenaza, vulnerabilidad, técnica e impacto.
- Reconocer los 13 vectores mediante ejemplos sencillos.
- Proponer un vector principal y uno secundario con justificación.
- Vincular vector, activo, condición e impacto.
- Proponer un control que responda a la condición concreta.
- Indicar un registro o prueba que permita verificar ese control.

## Objetivos de estudio

Al finalizar deberías poder:

- Definir vector y superficie de ataque.
- Clasificar escenarios sin tratar las categorías como etiquetas exclusivas.
- Relacionar personas, tecnología, terceros y espacios físicos con la exposición.
- Distinguir malware como capacidad o carga de su posible vía de entrada.
- Utilizar OWASP como lenguaje de riesgo y ATT&CK como detalle conductual.
- Ordenar inicialmente dos escenarios según exposición descrita, consecuencia y medida inmediata, sin aplicar una metodología formal de riesgos.

## 1. Vocabulario fundamental

| Concepto | Explicación | Ejemplo |
| --- | --- | --- |
| Activo | Recurso con valor que debe protegerse. | Cuenta, datos, servicio, persona o instalación. |
| Amenaza | Actor, evento o circunstancia capaz de causar daño. | Delincuente, error humano, incendio o cuenta comprometida. |
| Vulnerabilidad | Debilidad técnica, física, humana u organizacional. | Contraseña débil, software sin parche o puerta abierta. |
| Condición predisponente | Situación que aumenta exposición o consecuencia. | Red plana, dependencia de un proveedor o falta de personal. |
| Vector de ataque | Vía o mecanismo general utilizado para alcanzar un activo. | Correo engañoso, servicio público o acceso físico. |
| Superficie de ataque | Conjunto de puntos potenciales de interacción o entrada. | Personas, aplicaciones, dispositivos, proveedores e instalaciones. |
| Técnica | Comportamiento utilizado para lograr un objetivo. | Capturar credenciales o ejecutar una macro. |
| Exploit | Código o método que aprovecha una vulnerabilidad específica. | Aprovechar una falla de software. |
| Impacto | Consecuencia para la organización. | Fuga de datos, fraude o interrupción. |
| Riesgo | Posibilidad de que un escenario afecte los objetivos. | Acceso no autorizado mediante credenciales robadas. |

En esta lección el término **riesgo** ayuda a comprender el contexto, pero no se evalúan escalas, fórmulas, matrices ni tratamientos. Esa metodología comienza en la UA2.

### La diferencia esencial

En el escenario “RDP público con contraseña débil”:

- **Activo:** servidor y datos accesibles.
- **Amenaza:** actor que busca acceso no autorizado.
- **Vector:** servicio expuesto y posible ataque a credenciales.
- **Vulnerabilidad:** contraseña débil y exposición innecesaria.
- **Técnica:** intento de autenticación o reutilización de credenciales.
- **Impacto:** acceso, modificación o interrupción.

Usar todos los conceptos como sinónimos impide seleccionar un control pertinente.

## 2. Método para analizar un escenario

Utiliza esta cadena:

> **hecho → activo → amenaza → vector → vulnerabilidad o condición → técnica → impacto → control → evidencia**

### Ejemplo

- **Hecho:** una persona entrega su contraseña en un sitio falso recibido por correo.
- **Activo:** cuenta corporativa.
- **Amenaza:** actor que busca acceso.
- **Vector principal:** phishing.
- **Vector secundario:** ataque a credenciales o ingeniería social.
- **Condición:** falta de verificación y MFA inadecuado.
- **Impacto:** acceso no autorizado y posible fraude.
- **Control:** filtro, MFA resistente a phishing y procedimiento de verificación.
- **Evidencia:** logs de bloqueo, cobertura MFA y prueba del procedimiento.

Una etiqueta aislada como “phishing” no constituye un análisis. La justificación debe citar hechos del escenario.

## 3. Los 13 vectores

### 3.1 Phishing

Mensajes o servicios engañosos que inducen a revelar información, abrir contenido o aprobar una acción.

- **Ejemplo:** factura urgente con enlace a un sitio falso.
- **Condiciones:** urgencia, suplantación, filtrado insuficiente o autenticación débil.
- **Controles:** filtrado, autenticación de correo, MFA, verificación independiente y canal de reporte.
- **Evidencia:** logs de entrega/bloqueo, reportes y pruebas controladas.

### 3.2 Ingeniería social

Manipulación de personas o procesos para obtener información, acceso o una acción favorable.

- **Ejemplo:** convencer a soporte para restablecer la contraseña de otra persona.
- **Condiciones:** procesos informales, presión por rapidez y verificación débil.
- **Controles:** procedimiento de identidad, doble aprobación, capacitación y registro de visitas.
- **Evidencia:** tickets, verificaciones, resultados de ejercicios y revisiones.

Phishing es una forma de ingeniería social, pero la ingeniería social también ocurre por voz, presencialmente o mediante soporte.

### 3.3 Malware

Código utilizado para ejecutar acciones no autorizadas, mantener acceso, robar información, sabotear o extorsionar.

- **Ejemplo:** documento que ejecuta código al habilitar macros.
- **Condiciones:** ejecución permitida, privilegios excesivos, falta de parches o segmentación.
- **Controles:** EDR, allowlisting, mínimo privilegio, parches, segmentación y respaldos probados.
- **Evidencia:** cobertura de agentes, alertas, bloqueos y pruebas de restauración.

Malware suele ser la **carga o capacidad**, no necesariamente la vía inicial. Puede llegar por phishing, web, terceros o medios removibles.

### 3.4 Vulnerabilidades de aplicaciones web

Debilidades de diseño, código, configuración u operación de aplicaciones y APIs.

- **Ejemplo:** concatenar entradas del usuario en una consulta SQL.
- **Condiciones:** validación insuficiente, control de acceso defectuoso o componentes vulnerables.
- **Controles:** consultas parametrizadas, autorización por operación, revisión y pruebas de seguridad.
- **Evidencia:** código revisado, resultado de pruebas, ticket de corrección y validación posterior.

### 3.5 Ataques a credenciales

Obtención, adivinación, reutilización o abuso de contraseñas, claves, tokens y sesiones.

- **Ejemplo:** password spraying, credencial predeterminada o token robado.
- **Condiciones:** reutilización, MFA ausente, secretos expuestos o sesiones largas.
- **Controles:** MFA, gestores de contraseñas, detección adaptativa, rotación y revisión de sesiones.
- **Evidencia:** logs de identidad, cobertura MFA, alertas, revocaciones y pruebas de acceso.

### 3.6 Servicios expuestos

Servicios accesibles desde redes no confiables que pueden ser descubiertos y atacados.

- **Ejemplo:** RDP o panel de administración abierto a Internet.
- **Condiciones:** inventario incompleto, servicios innecesarios, autenticación débil o parches ausentes.
- **Controles:** retirar exposición, restringir origen, VPN o acceso de confianza cero, MFA y monitoreo.
- **Evidencia:** inventario, escaneo autorizado, reglas revisadas y prueba de conexión.

### 3.7 Configuraciones inseguras

Parámetros, permisos o valores predeterminados que exponen un activo más de lo necesario.

- **Ejemplo:** credenciales predeterminadas, almacenamiento público o logging deshabilitado.
- **Condiciones:** despliegue apresurado, falta de línea base y cambios sin control.
- **Controles:** configuración segura, mínimo privilegio, revisión automatizada y gestión de cambios.
- **Evidencia:** línea base, comparación efectiva, ticket y prueba del parámetro.

Un servicio puede estar expuesto y además mal configurado. Son perspectivas diferentes y pueden coexistir.

### 3.8 Amenazas internas

Riesgos originados por personas o cuentas con acceso legítimo. Pueden ser intencionales, negligentes, accidentales o producto de una cuenta comprometida.

- **Ejemplo:** copiar información a almacenamiento personal.
- **Condiciones:** privilegios excesivos, bajas incompletas o falta de segregación.
- **Controles:** mínimo privilegio, revisión de accesos, DLP y procesos de alta/cambio/baja.
- **Evidencia:** revisiones, logs, tickets de baja y alertas investigadas.

Comportamiento inusual no demuestra intención maliciosa. El monitoreo debe ser autorizado y proporcional.

### 3.9 Terceros y cadena de suministro

Dependencias externas que incorporan software, servicios, acceso, hardware o datos.

- **Ejemplo:** actualización firmada pero comprometida o cuenta de proveedor abusada.
- **Condiciones:** acceso permanente, confianza implícita, contrato débil o dependencias no inventariadas.
- **Controles:** evaluación, requisitos contractuales, acceso temporal, verificación de integridad y monitoreo.
- **Evidencia:** contratos, inventario, evaluaciones, logs y pruebas de coordinación.

### 3.10 Dispositivos móviles

Teléfonos y tabletas combinan identidad, datos, aplicaciones y conectividad fuera del perímetro tradicional.

- **Ejemplo:** teléfono corporativo sin bloqueo que se extravía.
- **Condiciones:** cifrado ausente, sistema desactualizado o mezcla de datos.
- **Controles:** bloqueo, cifrado, MDM/MAM, actualizaciones, acceso condicional y borrado autorizado.
- **Evidencia:** estado de cumplimiento, inventario, versión y prueba de revocación.

### 3.11 Redes inalámbricas

Acceso mediante Wi-Fi u otras comunicaciones que extienden la superficie más allá de los límites físicos.

- **Ejemplo:** clave compartida conocida por exempleados.
- **Condiciones:** autenticación compartida, cifrado débil o invitados sin segmentar.
- **Controles:** identidades individuales, cifrado adecuado, rotación, segmentación y monitoreo.
- **Evidencia:** configuración, logs de autenticación y prueba de segmentación.

### 3.12 Medios removibles

Dispositivos que trasladan datos o código entre entornos.

- **Ejemplo:** pendrives rotulados “Remuneraciones” abandonados en recepción.
- **Condiciones:** conexión automática, puertos abiertos, ausencia de política o curiosidad inducida.
- **Controles:** bloqueo o autorización, cifrado, revisión controlada, DLP y capacitación.
- **Evidencia:** logs de conexión, lista autorizada, alertas y registros de custodia.

### 3.13 Ataques físicos

Acciones sobre instalaciones, equipos, personas o soportes para obtener acceso, sustraer información o causar daño.

- **Ejemplo:** visitante conecta un equipo a un puerto o entra a una sala sin control.
- **Condiciones:** puertas abiertas, visitas sin acompañamiento, puertos activos o inventario deficiente.
- **Controles:** zonas, control de acceso, visitas, alarmas, protección de racks y puertos.
- **Evidencia:** registros, alertas, inventario e inspecciones.

## 4. Tabla de comparación rápida

| Vector | Pregunta para reconocerlo |
| --- | --- |
| Phishing | ¿El engaño llegó mediante un mensaje o servicio? |
| Ingeniería social | ¿Se manipuló a una persona o proceso? |
| Malware | ¿Se utilizó código para realizar acciones no autorizadas? |
| Aplicación web | ¿La vía depende de una debilidad de web o API? |
| Credenciales | ¿Se obtuvo, adivinó o abusó una identidad o sesión? |
| Servicio expuesto | ¿El activo era accesible desde una red no confiable? |
| Configuración insegura | ¿Un parámetro o permiso aumentó la exposición? |
| Amenaza interna | ¿El acceso legítimo o aparentemente interno habilitó el hecho? |
| Terceros | ¿La dependencia externa introdujo acceso o software? |
| Móvil | ¿El dispositivo móvil y su contexto son la vía dominante? |
| Inalámbrico | ¿La conectividad inalámbrica habilitó el acceso? |
| Medio removible | ¿Un soporte transportó datos o código? |
| Físico | ¿Se intervino una instalación, equipo o soporte material? |

## 5. Vectores combinados

Los escenarios reales rara vez caben en una sola categoría.

### Pendrive rotulado “Sueldos”

- Medio removible: transporta código o datos.
- Ingeniería social: induce a conectarlo.
- Malware: puede ser la carga.
- Físico: el dispositivo se introduce en el recinto.

### Proveedor con cuenta comprometida

- Tercero: la relación de confianza habilita el acceso.
- Credenciales: se abusa de una identidad válida.
- Configuración insegura: el acceso puede ser permanente o excesivo.

El **vector principal** suele describir la vía inicial o condición dominante; el secundario añade mecanismos relevantes. Si otra clasificación está bien fundamentada y conduce a controles pertinentes, puede ser válida.

## 6. Relación con Kill Chain y ATT&CK

- **Vector:** describe la vía o mecanismo general.
- **Kill Chain:** organiza momentos de una intrusión.
- **ATT&CK:** describe objetivos y comportamientos con mayor detalle.

Phishing puede aparecer en entrega; malware puede participar en preparación, entrega, instalación o C2; una amenaza interna puede comenzar dentro y omitir fases visibles.

ATT&CK ayuda a precisar una técnica, pero no existe una correspondencia uno a uno con estos 13 vectores. No es necesario memorizar la matriz para esta clase.

## 7. OWASP como lenguaje de riesgo

OWASP Top 10 agrupa riesgos frecuentes de aplicaciones web. En esta asignatura se usa para **nombrar una categoría de referencia**, no para demostrar que existe una vulnerabilidad ni para autorizar pruebas ofensivas.

Ante un escenario web se debe separar:

1. Categoría OWASP de referencia.
2. Vulnerabilidad concreta que podría existir.
3. Evidencia necesaria para confirmarla.
4. Activo e impacto.
5. Control de desarrollo seguro.

Ejemplos utilizados en la actividad:

- Concatenar entradas en una consulta puede asociarse con una categoría de **inyección**; se requiere revisar el código o evidencia entregada.
- Credenciales predeterminadas y servicios innecesarios pueden asociarse con **configuración insegura**; se debe verificar la configuración efectiva.

La categoría orienta la comunicación. No reemplaza la evidencia.

## 8. Seleccionar controles y evidencia

Un control debe modificar la condición identificada.

| Control declarado | Evidencia insuficiente | Evidencia más útil |
| --- | --- | --- |
| MFA | “Está habilitado”. | Cobertura, política, logs y prueba de bloqueo. |
| Firewall | Captura de una regla. | Configuración efectiva y prueba permitida/denegada. |
| Capacitación | Lista de asistencia. | Evaluación, reportes y mejora observada. |
| Respaldo | Existe un archivo. | Restauración probada y resultado documentado. |
| MDM | Aplicación instalada. | Inventario, estado de cumplimiento y prueba de revocación. |

La próxima lección profundizará la clasificación de controles. En esta sesión basta indicar una medida pertinente y cómo comprobarla.

## 9. Triage inicial, no evaluación formal de riesgos

El triage permite decidir qué situación revisar primero con la información inmediata del caso. Para esta lección se utilizan solo tres preguntas:

1. ¿Qué exposición describe explícitamente el caso?
2. ¿Qué consecuencia podría sufrir el activo?
3. ¿Existe una medida inicial inmediata que limite esa condición?

Una respuesta defendible podría expresarse así:

> “Revisaría primero el RDP público porque el caso declara acceso directo desde Internet, una contraseña predeterminada y una medida inmediata: retirar la exposición mientras se corrige el acceso”.

Siempre debe declararse un dato faltante que podría cambiar el orden. No se asignan valores de probabilidad, no se calcula criticidad, no se estima riesgo inherente o residual y no se selecciona un tratamiento formal; esos contenidos se desarrollan en las lecciones 07–10.

## 10. Aplicación a la actividad asignada

Para cada uno de los ocho casos de la versión asignada:

1. Subraya el hecho observable.
2. Identifica el activo.
3. Propón vector principal y secundario.
4. Explica la vulnerabilidad o condición.
5. Describe la consecuencia posible.

Después, en los cuatro casos indicados por la actividad:

6. Propón un control inicial.
7. Indica una evidencia concreta.

Después elige dos casos para un triage inicial y responde:

- ¿Por qué este escenario va antes que otro?
- ¿Qué información faltante podría cambiar la decisión?
- ¿Qué medida inmediata responde a la condición descrita?

## 11. Errores frecuentes

- Confundir vector con vulnerabilidad.
- Tratar “hacker” o “malware” como explicación completa.
- Presentar los 13 vectores como estándar internacional.
- Forzar una sola etiqueta cuando existen vías combinadas.
- Suponer que una amenaza interna siempre es maliciosa.
- Nombrar una categoría OWASP como si probara una falla.
- Proponer una herramienta sin relacionarla con la condición.
- Convertir el triage introductorio en una matriz o cálculo formal de riesgo.
- Suponer que nombrar un control demuestra que está funcionando.
- Utilizar ATT&CK como cadena lineal o lista para memorizar.

## 12. Qué se estudiará después

| Tema | Lección posterior |
| --- | --- |
| Naturaleza y función de controles | Lección 03. |
| CIS Controls y defensa en profundidad | Lección 03. |
| AAA y firewall | Lección 04. |
| IDS/IPS y Snort | Lección 05. |
| Gestión formal de riesgos | UA2. |

Esta lección reconoce vías y prioridades iniciales; no ejecuta pruebas ofensivas ni configura controles.

## 13. Guía de estudio

1. Explica vector, amenaza, vulnerabilidad, técnica e impacto con un solo ejemplo.
2. Crea trece tarjetas: definición breve, ejemplo, control y evidencia.
3. Compara phishing con ingeniería social, servicio expuesto con configuración insegura y tercero con amenaza interna.
4. Completa solo la versión asignada: actividad A (`actividad.md`) o actividad B (`actividad-02.md`).
5. Ordena dos escenarios mediante triage y ensaya una defensa de un minuto.
6. Resuelve la autoevaluación.

## Autoevaluación

### Preguntas

1. Diferencia vector, amenaza y vulnerabilidad.
2. ¿Por qué phishing e ingeniería social no son sinónimos exactos?
3. ¿Por qué malware no siempre es el vector inicial?
4. Da dos ejemplos de ataque a credenciales y un control para cada uno.
5. ¿Qué diferencia existe entre servicio expuesto y configuración insegura?
6. ¿Por qué amenaza interna no implica necesariamente malicia?
7. Explica cómo un tercero aumenta la superficie de ataque.
8. ¿Por qué los 13 vectores no deben tratarse como lista oficial cerrada?
9. ¿Qué tres preguntas utiliza el triage inicial de esta lección?
10. Corrige: “Tenemos EDR; por lo tanto el riesgo de malware es cero”.

### Respuestas orientativas

1. Vector es la vía; amenaza es el actor o evento; vulnerabilidad es la debilidad aprovechable.
2. Phishing utiliza mensajes o servicios engañosos; ingeniería social incluye otras formas de manipulación de personas y procesos.
3. Puede ser la carga entregada mediante correo, web, tercero, servicio expuesto o medio removible.
4. Spraying y reutilización de credenciales; controles posibles: MFA, detección adaptativa, gestores y bloqueo.
5. Exposición describe accesibilidad; configuración insegura describe parámetros débiles. Pueden coexistir.
6. Puede originarse por error, negligencia o una cuenta comprometida, además de intención maliciosa.
7. Añade accesos, software, servicios, dependencias y datos fuera del control directo.
8. Es una agrupación didáctica; otros marcos organizan vías y comportamientos de otras formas.
9. Qué exposición describe el caso, qué consecuencia podría sufrir el activo y qué medida inicial puede limitar la condición.
10. “EDR puede reducir o detectar parte del riesgo; deben comprobarse cobertura, configuración, respuesta y controles complementarios”.

## Fuentes base y profundización opcional

- [MITRE ATT&CK Enterprise](https://attack.mitre.org/matrices/enterprise/): tácticas y técnicas observadas.
- [MITRE ATT&CK - Get Started](https://attack.mitre.org/resources/): conceptos y usos.
- [CISA Cybersecurity Scenarios](https://www.cisa.gov/resources-tools/resources/cybersecurity-scenarios): escenarios de discusión.
- [OWASP Top 10](https://owasp.org/www-project-top-ten/): categorías de referencia para aplicaciones web.

Fecha de consulta de recursos vivos: 06-08-2026.
