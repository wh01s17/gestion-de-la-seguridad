---
title: Materia y guía de estudio - Tipos y controles críticos de seguridad
tags:
  - nota
  - course
  - curso
  - materia-y-guia-de-estudio
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "03"
author: Jordy
start: 2026-08-24
end: 2026-08-25
created_at: 2026-08-06 17:41
aliases:
  - Materia y guía de estudio - Tipos y controles críticos de seguridad
---

# Materia y guía de estudio - Tipos y controles críticos de seguridad

```toc
```

## Propósito de esta guía

Esta guía contiene lo necesario para la lección 03 y no requiere conocimientos previos de ciberseguridad. Su objetivo es aprender a seleccionar y clasificar controles, comprobar si realmente funcionan y construir una prioridad inicial apoyada en CIS Controls v8.1.

La idea central es:

> Un control no se elige porque “suena seguro”, sino porque trata un riesgo concreto y podemos demostrar que funciona.

La guía utiliza la versión CIS v8.1 adoptada para la asignatura, compuesta por 18 controles. El programa de 2022 conserva una referencia histórica a 27 controles; no se agregarán controles ficticios para completar esa cifra.

## Ruta mínima de preparación

Estudia en este orden:

1. Riesgo, objetivo de control y control.
2. Clasificación por naturaleza, función y ubicación.
3. Controles con varias clasificaciones.
4. Diseño, implementación, operación y efectividad.
5. Evidencia y pruebas de controles.
6. Defensa en profundidad.
7. CIS Controls v8.1 y grupos de implementación.
8. Caso, actividad y autoevaluación.

### Criterio de suficiencia

Estás preparado cuando puedes:

- Formular un objetivo verificable para un riesgo concreto.
- Clasificar controles en columnas independientes.
- Explicar por qué un control puede tener varias funciones.
- Distinguir existencia, implementación, operación y efectividad.
- Proponer evidencia concreta y una prueba no disruptiva.
- Asociar una brecha con uno o más CIS Controls.
- Justificar una prioridad considerando dependencias y capacidad.

## Objetivos de estudio

Al finalizar deberías poder:

- Explicar cómo un control modifica un riesgo.
- Diferenciar controles administrativos, técnicos y físicos.
- Diferenciar funciones preventivas, detectivas, correctivas, disuasivas, compensatorias y de recuperación.
- Utilizar “interno” y “externo” indicando la frontera elegida.
- Vincular riesgo, objetivo, control, responsable y evidencia.
- Evaluar diseño, implementación, operación y efectividad.
- Utilizar CIS Controls v8.1 como referencia priorizada, no como lista para marcar sin contexto.
- Diseñar capas y una hoja de ruta 30/90/180 días.

## 1. Del riesgo al control

Antes de elegir un control, distingue estos conceptos:

| Concepto | Explicación sencilla | Ejemplo |
| --- | --- | --- |
| Activo | Algo valioso que debemos proteger. | Datos, equipos o servicios. |
| Amenaza | Algo o alguien capaz de causar daño. | Un atacante, malware o un incendio. |
| Vulnerabilidad | Debilidad que una amenaza puede aprovechar. | Contraseña débil o software sin actualizar. |
| Evento | Lo que ocurre cuando la amenaza actúa. | Acceso no autorizado a una cuenta. |
| Impacto | Consecuencia para la organización. | Pérdida de datos o interrupción del servicio. |
| Riesgo | Posibilidad de que el evento ocurra y cause ese impacto. | Robo de datos mediante una cuenta comprometida. |

Un **control de seguridad** es una medida que modifica un riesgo. Puede reducir la probabilidad, disminuir el impacto, detectar una situación, corregirla o recuperar una capacidad. No suele eliminar todo el riesgo: la parte que permanece se llama **riesgo residual**.

Un control puede ser:

- Una política o responsabilidad.
- Un procedimiento de aprobación.
- Una configuración o herramienta.
- Una barrera física.
- Una revisión o alerta.
- Un respaldo probado.
- Un requisito contractual.

Para no elegir controles al azar, sigue esta cadena:

> **activo → amenaza → vulnerabilidad o condición → evento → impacto → objetivo de control → control → evidencia**

### Ejemplo paso a paso

- **Activo:** cuentas administrativas.
- **Amenaza:** persona atacante con credenciales robadas.
- **Condición:** autenticación basada solo en contraseña.
- **Evento:** acceso remoto no autorizado.
- **Impacto:** cambios y pérdida de disponibilidad.
- **Objetivo:** impedir que una contraseña robada sea suficiente.
- **Control:** autenticación multifactor (MFA) para todas las cuentas administrativas.
- **Evidencia:** cobertura, configuración, registros de autenticación y prueba de acceso denegado.

“Mejorar la seguridad” es demasiado vago. En cambio, “exigir un segundo factor a todas las cuentas administrativas antes de autorizar acceso remoto” indica qué debe ocurrir, a quién se aplica y cómo podría probarse.

## 2. Tres dimensiones independientes

Clasificar un control es parecido a describir una persona por profesión, tarea y lugar de trabajo: cada dato responde una pregunta diferente. Con los controles ocurre lo mismo:

| Dimensión | Pregunta | Categorías |
| --- | --- | --- |
| Naturaleza | ¿De qué tipo de medida se trata? | Administrativa, técnica o física. |
| Función | ¿Qué hace frente al evento? | Preventiva, detectiva, correctiva, disuasiva, compensatoria o recuperación. |
| Ubicación o frontera | ¿Dónde opera o quién la ejecuta? | Interna o externa, según el criterio declarado. |

Una cámara dentro de una oficina puede ser:

- Física por naturaleza.
- Detectiva y disuasiva por función.
- Interna por ubicación.
- Operada externamente si existe un proveedor.

No hay contradicción. Cada etiqueta describe una dimensión distinta.

Para clasificar sin confundirte, completa una dimensión a la vez:

1. **Naturaleza:** ¿se basa principalmente en reglas y personas, tecnología o una barrera física?
2. **Función:** ¿qué hace antes, durante o después del evento?
3. **Ubicación:** ¿qué frontera estoy usando y a qué lado opera?

## 3. Clasificación por naturaleza

### Administrativos

Establecen dirección, responsabilidades, reglas y procesos. En palabras simples, indican **qué hacer, quién debe hacerlo y cuándo**.

Ejemplos:

- Políticas y procedimientos.
- Roles y segregación de funciones.
- Altas, cambios y bajas.
- Capacitación.
- Gestión de proveedores.
- Evaluación de riesgos y continuidad.

**Evidencia:** política aprobada, matriz de roles, tickets, actas, contratos, evaluaciones y registros de ejecución.

**Ejemplo:** un procedimiento exige aprobación de la jefatura antes de crear una cuenta. Es administrativo porque depende de una regla, un responsable y un proceso.

Un documento prueba definición o existencia, pero no necesariamente que el proceso se ejecute.

### Técnicos

Se implementan mediante software, hardware computacional o configuración lógica. Pueden aplicar una regla automáticamente o ayudar a una persona a aplicarla.

Ejemplos:

- MFA y control de acceso.
- Cortafuegos (*firewall*) y segmentación.
- Cifrado.
- Protección de equipos finales (*endpoints*).
- Parches y configuración segura.
- Registro de eventos y alertas.
- Respaldos automatizados.

**Evidencia:** configuración efectiva, inventario de cobertura, registros, alertas atendidas, historial de cambios y resultados de prueba.

**Ejemplo:** un sistema bloquea una cuenta después de varios intentos fallidos. Es técnico porque la regla está configurada en el sistema.

Una herramienta instalada, pero sin cobertura o monitoreo, puede ser un control solo aparente. Por ejemplo, un antivirus que protege 2 de 100 equipos no ofrece la cobertura esperada.

### Físicos

Protegen personas, instalaciones, equipos y soportes materiales mediante barreras o mecanismos del mundo físico.

Ejemplos:

- Cerraduras, puertas y torniquetes.
- Recepción, guardias y gestión de visitas.
- Cámaras y sensores.
- Protección de racks y puertos.
- Energía, temperatura y extinción de incendios.
- Destrucción segura.

**Evidencia:** registros de acceso, visitas, inspecciones, mantenimiento, alarmas y pruebas de autonomía.

Un control puede combinar naturalezas. Una cerradura electrónica posee una barrera física, un mecanismo técnico y un proceso administrativo para autorizar tarjetas. Si asignas más de una naturaleza, explica qué componente justifica cada etiqueta.

## 4. Clasificación por función

La función indica qué resultado produce el control. Como regla inicial: **prevenir** ocurre antes del evento, **detectar** permite advertirlo, **corregir** contiene o remedia y **recuperar** restablece una capacidad.

| Función | Pregunta | Ejemplo | Evidencia posible |
| --- | --- | --- | --- |
| Preventiva | ¿Intenta impedir o reducir la probabilidad? | MFA, cerradura o validación de entrada. | Intento rechazado, regla o prueba negativa. |
| Detectiva | ¿Genera una señal sobre una condición o evento? | Alerta de acceso, sistema de detección de intrusiones (IDS) o revisión de registros. | Alerta, caso investigado y tiempo de detección. |
| Correctiva | ¿Contiene o remedia después de detectar? | Revocar credencial, aislar o parchear. | Ticket, cambio y nueva prueba. |
| Disuasiva | ¿Busca desalentar la acción? | Guardia, aviso de monitoreo o cámara visible. | Inspección y comunicación del control. |
| Compensatoria | ¿Sustituye temporalmente un control no viable? | Red privada virtual (VPN) con MFA delante de una aplicación heredada. | Excepción aprobada, pruebas y revisión. |
| Recuperación | ¿Restablece datos, servicio o capacidad? | Restauración, sitio alternativo o reconstrucción. | Resultado, tiempo y datos recuperados. |

### Correctivo frente a recuperación

Ante *ransomware* -programa malicioso que bloquea o cifra datos para exigir un pago-:

- Aislar el equipo: correctivo o contención.
- Eliminar persistencia: correctivo.
- Restaurar los datos: recuperación.
- Mejorar segmentación: preventivo.

Corregir la causa o condición no significa que el servicio ya esté recuperado.

Una analogía útil es un incendio: la alarma detecta humo, el extintor ayuda a contenerlo y la reparación permite volver a utilizar el lugar. Son resultados distintos.

### Control compensatorio

No significa “cualquier alternativa”. Debe:

- Responder al mismo objetivo.
- Reducir el riesgo de manera suficiente o explícitamente aceptada.
- Tener alcance, responsable y evidencia.
- Ser probado y revisado.
- Declarar riesgo residual y duración de la excepción.

## 5. Controles internos y externos

“Interno” y “externo” no tienen un significado único. Pueden describir ubicación física, frontera de red o quién opera el control. Por eso, primero debes declarar la frontera utilizada.

- **Interno por ubicación:** segmentación de la red corporativa o cerradura de una sala propia.
- **Externo por ubicación:** protección ofrecida antes de llegar a la red.
- **Externo por operación:** centro de operaciones de seguridad (SOC) o auditoría prestados por un tercero.

Una respuesta completa sería: “La cámara es interna respecto de la ubicación, porque está dentro de la empresa, y externa respecto de la operación, porque la supervisa un proveedor”.

Contratar un servicio no transfiere completamente la responsabilidad. La organización debe definir requisitos, revisar evidencia, gestionar incumplimientos y tratar el riesgo residual.

## 6. Un control puede cumplir varias funciones

Ejemplo: protección de equipos finales (*endpoints*).

- Preventiva si bloquea una ejecución.
- Detectiva si genera una alerta.
- Correctiva si pone en cuarentena o aísla.

Ejemplo: guardia.

- Disuasiva por su presencia.
- Preventiva al impedir el paso.
- Detectiva al observar y reportar.
- Correctiva si activa el protocolo de contención.

Cada función debe justificarse con un mecanismo:

> “Es detectivo porque genera una alerta que una persona revisa cuando ocurre un acceso fuera de horario”.

Usa la fórmula: **“es [función] porque [mecanismo], lo que permite [resultado]”**. Si no puedes explicar cómo produce el resultado, no agregues la etiqueta.

## 7. Ciclo de vida y niveles de evidencia

Un control atraviesa varias etapas:

1. Se identifica una necesidad y un objetivo.
2. Se diseña el control y su alcance.
3. Se implementa.
4. Opera y genera evidencia.
5. Se monitorea y evalúa.
6. Se mejora, reemplaza o retira.

### Existencia, diseño, implementación, operación y efectividad

| Nivel | Pregunta | Ejemplo: proceso de bajas |
| --- | --- | --- |
| Existencia | ¿Está documentado o adquirido? | Existe un procedimiento. |
| Diseño | ¿Podría lograr el objetivo si funciona? | Incluye sistemas, responsables y plazo. |
| Implementación | ¿Se llevó al entorno real? | Fue comunicado e integrado con tickets. |
| Operación | ¿Se ejecuta consistentemente? | Las bajas del período fueron procesadas. |
| Efectividad | ¿Reduce el riesgo esperado? | Pruebas confirman que las cuentas ya no acceden dentro del plazo. |

Estos niveles no son sinónimos. Por ejemplo, puede existir un buen procedimiento de bajas y estar integrado con tickets, pero no ser efectivo si las cuentas siguen activas varios días después de la salida del personal.

Cada integrante responde en dos o tres frases:
Una captura aislada puede demostrar configuración en un momento, pero no operación continua ni efectividad.

## 8. Evidencia y prueba de controles

La evidencia debe indicar alcance, período, responsable, fuente y resultado.

| Pregunta | Evidencia típica |
| --- | --- |
| ¿Está definido? | Política, procedimiento, diseño o matriz de roles. |
| ¿Está implementado? | Configuración, despliegue, inventario o comunicación. |
| ¿Opera? | Registros, tickets, aprobaciones, revisiones y alertas atendidas. |
| ¿Es efectivo? | Prueba, muestreo, métrica y resultado sobre el objetivo. |

Tres métodos básicos:

- **Examinar:** revisar documentos, configuraciones, registros o evidencia física.
- **Entrevistar:** comprender cómo funciona y cómo se manejan excepciones.
- **Probar:** ejecutar una acción controlada y no disruptiva.

La entrevista ayuda a entender el proceso, pero por sí sola rara vez demuestra operación. Lo más sólido es combinar métodos. Para un respaldo, examina los registros, pregunta quién atiende los fallos y restaura un archivo controlado; para una cuenta revocada, revisa el ticket e intenta un acceso autorizado de prueba.

Toda prueba debe tener autorización y evitar interrupciones. Nunca pruebes sobre sistemas reales sin definir alcance y medidas de seguridad.

### Métricas sencillas

- **Cobertura:** porcentaje del alcance protegido.
- **Oportunidad:** tiempo para ejecutar o responder.
- **Calidad:** proporción de ejecuciones correctas.
- **Resultado:** grado en que se cumple el objetivo.

“Se impartieron 12 capacitaciones” mide actividad. “El personal reconoce y reporta correctamente un escenario simulado” se acerca más al resultado.

## 9. Defensa en profundidad

Consiste en combinar controles distintos para que el fallo de uno no determine por sí solo el incidente.

Piensa en una casa: la reja dificulta el ingreso, la cerradura crea otra barrera y la alarma avisa si ambas fallan. Cada capa aporta algo diferente.

Ante robo de credenciales:

- Procedimiento de verificación: administrativo/preventivo.
- MFA: técnico/preventivo.
- Alerta de acceso anómalo: técnico/detectivo.
- Revocación de sesión: técnico/correctivo.
- Restauración de cambios: técnico/de recuperación.

Instalar tres herramientas equivalentes no necesariamente crea profundidad. Las capas deben cubrir momentos, funciones o dependencias diferentes.

## 10. CIS Controls v8.1

CIS Controls organiza prácticas de ciberseguridad priorizadas. Ayuda a responder: “Con recursos limitados, ¿qué capacidades conviene desarrollar primero?”. En esta asignatura se utiliza para identificar brechas y construir una secuencia razonable, no como una lista que deba implementarse completa de inmediato.

### Los 18 controles

| N.º | Control | Pregunta orientadora |
| ---: | --- | --- |
| 1 | Inventario y control de activos empresariales | ¿Qué equipos y dispositivos existen y están autorizados? |
| 2 | Inventario y control de activos de software | ¿Qué software está instalado y permitido? |
| 3 | Protección de datos | ¿Dónde están los datos y cómo se protegen? |
| 4 | Configuración segura de activos y software | ¿Existe una línea base segura y control de cambios? |
| 5 | Gestión de cuentas | ¿Qué cuentas existen y siguen siendo necesarias? |
| 6 | Gestión del control de acceso | ¿Quién puede acceder a qué y con qué privilegios? |
| 7 | Gestión continua de vulnerabilidades | ¿Cómo se identifican, priorizan y corrigen vulnerabilidades? |
| 8 | Gestión de registros de auditoría | ¿Qué se registra, conserva y revisa? |
| 9 | Protección del correo y navegador web | ¿Cómo se reducen contenidos y sitios riesgosos? |
| 10 | Defensas contra malware | ¿Cómo se previene, detecta y responde al código malicioso? |
| 11 | Recuperación de datos | ¿Los respaldos están protegidos y se pueden restaurar? |
| 12 | Gestión de infraestructura de red | ¿La red está inventariada, configurada y mantenida? |
| 13 | Monitoreo y defensa de red | ¿Se observan y atienden comportamientos relevantes? |
| 14 | Concientización y habilidades de seguridad | ¿Las personas saben actuar según su función? |
| 15 | Gestión de proveedores de servicios | ¿Se administran accesos, requisitos y dependencias externas? |
| 16 | Seguridad del software de aplicaciones | ¿La seguridad se integra al ciclo de desarrollo? |
| 17 | Gestión de respuesta a incidentes | ¿Existen roles, procedimientos y ejercicios de respuesta? |
| 18 | Pruebas de penetración | ¿Se validan defensas mediante pruebas autorizadas y controladas? |

### Grupos de implementación

- **IG1:** higiene cibernética esencial para organizaciones con recursos limitados y riesgos comunes.
- **IG2:** amplía IG1 para organizaciones con mayor complejidad, datos sensibles o personal especializado.
- **IG3:** agrega salvaguardas para entornos con alta exposición, impacto o adversarios sofisticados.

Los grupos son acumulativos: IG2 incluye IG1 e IG3 incluye IG1 e IG2. No sustituyen el análisis del contexto.

### Dependencias útiles

- No se protege bien lo que no está inventariado: controles 1 y 2 suelen habilitar otros.
- La gestión de cuentas y accesos depende de conocer identidades y activos: controles 5 y 6.
- Recuperar requiere respaldos protegidos y pruebas: control 11.
- Detectar requiere registros y capacidad de revisión: controles 8 y 13.
- Gestionar terceros requiere inventario, requisitos y supervisión: control 15.

## 11. Desarrollo seguro

El control 16 extiende la seguridad al software y las aplicaciones. Puede incluir:

- Requisitos de seguridad.
- Revisión de arquitectura y código.
- Gestión de dependencias y secretos.
- Pruebas automáticas y manuales autorizadas.
- Corrección y verificación de vulnerabilidades.

OWASP ASVS y NIST SSDF pueden ayudar a convertir riesgos en requisitos verificables. Nombrar el estándar no demuestra implementación: se requieren evidencias del ciclo de desarrollo y resultados de prueba.

Ejemplo de objetivo:

> “Evitar que entradas no confiables modifiquen la estructura de consultas y verificarlo mediante revisión de código y pruebas automatizadas”.

## 12. Priorizar una hoja de ruta

Priorizar significa decidir qué hacer primero y justificarlo. Considera el impacto posible, la exposición, las dependencias y los recursos disponibles.

Una hoja de ruta debe indicar:

- Riesgo y activo.
- Control o salvaguarda.
- Responsable.
- Dependencias.
- Plazo.
- Evidencia de implementación y operación.
- Métrica.
- Riesgo residual.

### Horizonte 30/90/180 días

- **30 días:** contener exposiciones evidentes y establecer visibilidad básica.
- **90 días:** implementar controles que dependen de inventario, identidades y configuración.
- **180 días:** madurar monitoreo, pruebas, respuesta y mejoras estructurales.

El horizonte no determina una solución única. Un control urgente puede ir a 30 días aunque sea complejo, y una mejora de bajo riesgo puede esperar.

## 13. Caso modelo para las actividades

Una sede pequeña posee recepción, oficina administrativa, sala de servidores, Wi-Fi de invitados, diez portátiles, correo en la nube y respaldos conectados permanentemente.

La actividad A utiliza directamente este escenario y la actividad B presenta un caso equivalente para la jornada vespertina. Ambas requieren la misma cantidad de análisis, controles, evidencias, capas y acciones priorizadas.

### Ejemplo breve de razonamiento

- **Riesgo:** un portátil infectado podría cifrar los archivos de trabajo y los respaldos conectados, interrumpiendo la operación.
- **Objetivo:** mantener una copia de los datos críticos que no pueda modificarse desde un portátil comprometido y comprobar que puede restaurarse.
- **Controles:** protección de los portátiles, acceso restringido a las copias, una copia separada y pruebas periódicas de restauración.
- **Evidencia:** equipos cubiertos, configuración de acceso, registros de respaldo y resultado de una restauración de prueba.
- **CIS Controls relacionados:** 1 para conocer los equipos, 10 para malware y 11 para recuperación de datos.

Observa que el análisis comienza con el riesgo y el objetivo, no con la compra de una herramienta.

### Cómo abordarlo

1. Dibuja zonas, activos, flujos y relaciones de confianza.
2. Elige activos críticos e identifica rutas de acceso y consecuencias.
3. Escribe un riesgo concreto y un objetivo verificable.
4. Diseña tres capas con funciones diferentes.
5. Clasifica cada control en columnas independientes.
6. Define responsable y evidencia de diseño, implementación y operación.
7. Propón una prueba sencilla de efectividad.
8. Asocia las brechas con CIS Controls.
9. Construye la hoja de ruta 30/90/180.

### Preguntas que deben guiar el diseño

- ¿El Wi-Fi de invitados puede alcanzar sistemas internos?
- ¿Quién puede entrar a la sala de servidores?
- ¿Las cuentas y portátiles están inventariados?
- ¿Los respaldos conectados resisten un incidente en los equipos?
- ¿Qué registra el correo en la nube y quién revisa alertas?
- ¿Existe un control sobre software o desarrollo de aplicaciones?

No existe una arquitectura única. La propuesta debe explicar qué riesgo trata cada capa y cómo se comprobará.

## 14. Errores frecuentes

- Confundir naturaleza con función.
- Tratar las categorías como excluyentes.
- Llamar preventivo a todo control.
- Confundir correctivo con recuperación.
- Usar “compensatorio” como excusa indefinida.
- Presentar una política como evidencia de efectividad.
- Proponer un producto sin objetivo ni alcance.
- Omitir responsable, frecuencia o evidencia.
- Acumular herramientas equivalentes y llamarlo defensa en profundidad.
- Delegar completamente el riesgo a un proveedor.
- Marcar los 18 CIS Controls sin priorizar dependencias.
- Inventar nueve controles para completar la referencia histórica de 27.

## 15. Qué se estudiará después

| Tema | Lección posterior |
| --- | --- |
| AAA, autenticación y autorización | Lección 04. |
| Políticas y reglas de firewall | Lección 04. |
| IDS/IPS y reglas Snort | Lección 05. |
| Gestión formal de riesgos | UA2. |
| Políticas, implementación y auditoría | Lección 11. |
| BIA, continuidad y recuperación | UA3. |

Esta lección clasifica y prioriza; no exige configurar todavía todos los controles.

## 16. Guía de estudio

1. Clasifica una cerradura con registro por naturaleza, función y ubicación.
2. Explica correctivo frente a recuperación con un ejemplo.
3. Diseña un control compensatorio y declara su riesgo residual.
4. Elige cinco CIS Controls relevantes para el caso y explica sus dependencias.
5. Completa la versión asignada: [[gestion-de-la-seguridad/leccion-03/actividad|actividad A]] para la jornada diurna o [[gestion-de-la-seguridad/leccion-03/actividad-02|actividad B]] para la jornada vespertina.
6. Revisa que cada control tenga objetivo, responsable y evidencia.
7. Resuelve la autoevaluación.

## Autoevaluación

### Preguntas

1. ¿Qué relación existe entre riesgo, objetivo y control?
2. ¿Por qué “técnico” y “preventivo” no son categorías opuestas?
3. Clasifica una cerradura electrónica que registra cada ingreso.
4. ¿Qué diferencia existe entre control detectivo y correctivo?
5. ¿Cuándo es aceptable un control compensatorio?
6. ¿Qué diferencia existe entre corrección y recuperación?
7. ¿Por qué una política aprobada no demuestra efectividad?
8. ¿Qué evidencia pedirías para comprobar bajas de cuentas?
9. ¿Para qué sirven los grupos de implementación de CIS?
10. Propón una combinación preventiva, detectiva y correctiva para phishing.

### Respuestas orientativas

1. El riesgo describe el escenario; el objetivo define el resultado deseado; el control es la medida destinada a lograrlo.
2. Técnico describe naturaleza y preventivo describe función; pertenecen a dimensiones independientes.
3. Física/técnica por naturaleza, preventiva al restringir y detectiva al registrar; la ubicación debe explicarse según la frontera.
4. El detectivo genera una señal; el correctivo contiene o remedia después de la detección.
5. Cuando el control preferido no es viable, la alternativa cubre el mismo objetivo, se documenta y prueba, tiene duración y riesgo residual aceptado.
6. Corregir remedia la condición; recuperar restablece datos, servicios o capacidades.
7. Solo prueba definición o existencia, no aplicación consistente ni resultado.
8. Avisos de salida, tickets con hora, lista de sistemas, registros de deshabilitación, prueba de acceso fallido y métrica de plazo.
9. Para priorizar salvaguardas acumulativas según recursos, complejidad y riesgo; no sustituyen el análisis contextual.
10. MFA y verificación como preventivos; alerta de acceso anómalo como detectivo; revocación de sesiones y credenciales como correctivo, todos con evidencia.

## Fuentes base y profundización opcional

- [CIS Controls v8.1](https://www.cisecurity.org/controls/v8-1): controles y grupos de implementación utilizados en la asignatura.
- [NIST SP 800-53 Rev. 5](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final): catálogo de controles.
- [NIST Cybersecurity Framework 2.0](https://www.nist.gov/publications/nist-cybersecurity-framework-csf-20): resultados de gobernar, identificar, proteger, detectar, responder y recuperar.
- [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/): requisitos verificables de seguridad de aplicaciones.
- [NIST SSDF](https://csrc.nist.gov/projects/ssdf): prácticas de desarrollo seguro.

Fecha de consulta de recursos vivos: 06-08-2026.
