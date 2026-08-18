---
title: "Solución docente - Vectores de ataque, versión A"
tags: [nota, course, curso, docente, reservado]
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "02"
author: Jordy
start: 2026-08-17
end: 2026-08-18
created_at: "2026-08-07 11:58"
aliases:
  - "Solución docente - Vectores de ataque, versión A"
---
# Actividad - Matriz de vectores de ataque

**Duración:** 80 minutos.
**Modalidad:** parejas.
**Carácter:** formativo, sin calificación.
**Versión:** A.
**Aplicación prevista:** SAINF44-1, jornada diurna.

## Propósito

Distinguir vector, amenaza, vulnerabilidad y consecuencia; justificar una clasificación y realizar un triage inicial. La lista de 13 vectores es una agrupación pedagógica del programa, no una taxonomía oficial universal.

## Recordatorio para resolver la actividad

| Concepto | Pregunta para reconocerlo | Ejemplo breve |
| --- | --- | --- |
| Activo | ¿Qué recurso con valor se quiere proteger? | Una cuenta, un dispositivo o datos de clientes. |
| Amenaza | ¿Qué actor, evento o circunstancia podría causar daño? | Un tercero no autorizado, un error o una cuenta comprometida. |
| Vector | ¿Por qué vía o mecanismo se alcanza el activo? | Un correo engañoso o un servicio público. |
| Vulnerabilidad o condición | ¿Qué debilidad o situación permite o facilita el hecho? | Una contraseña predeterminada o la ausencia de bloqueo. |
| Consecuencia | ¿Qué podría ocurrirle al activo? | Divulgación, modificación, fraude o interrupción. |
| Control inicial | ¿Qué medida responde directamente a la condición? | Cambiar una credencial predeterminada. |
| Evidencia de funcionamiento | ¿Qué registro o prueba permitiría comprobar el control? | Una configuración revisada o una prueba autorizada. |

### Consulta rápida de los 13 vectores

| Vector | Pregunta para reconocerlo |
| --- | --- |
| Phishing | ¿El engaño llegó mediante un mensaje o servicio? |
| Ingeniería social | ¿Se manipuló a una persona o proceso? |
| Malware | ¿Se utilizó código para realizar acciones no autorizadas? |
| Aplicación web | ¿La vía depende de una debilidad de una aplicación web o API? |
| Credenciales | ¿Se obtuvo, adivinó o abusó una identidad o sesión? |
| Servicio expuesto | ¿El activo era accesible desde una red no confiable? |
| Configuración insegura | ¿Un parámetro o permiso aumentó la exposición? |
| Amenaza interna | ¿El acceso legítimo o aparentemente interno habilitó el hecho? |
| Terceros y cadena de suministro | ¿Una dependencia externa introdujo acceso, software o datos? |
| Dispositivo móvil | ¿Un teléfono o tableta y su contexto son la vía dominante? |
| Red inalámbrica | ¿La conectividad inalámbrica habilitó el acceso? |
| Medio removible | ¿Un soporte trasladó datos o código? |
| Ataque físico | ¿Se intervino una instalación, equipo o soporte material? |

Para completar cada fila, sigan la misma ruta: **citen el hecho → separen activo y amenaza → elijan el vector → identifiquen la condición → indiquen una consecuencia posible**. Un caso puede combinar vectores; la justificación basada en el hecho es más importante que memorizar una única etiqueta.

## Casos

| ID | Situación |
| --- | --- |
| A1 | Una persona entrega su contraseña en un sitio falso enlazado desde un correo urgente. |
| A2 | Un proveedor distribuye una actualización legítimamente firmada, pero comprometida. |
| A3 | Un servicio RDP permanece accesible desde Internet y utiliza una contraseña predeterminada. |
| A4 | Un empleado copia información de clientes desde su cuenta autorizada a un almacenamiento personal. |
| A5 | Una aplicación concatena entradas del usuario en una consulta SQL. |
| A6 | Alguien deja pendrives rotulados “Remuneraciones” en la recepción para inducir a conectarlos. |
| A7 | Un teléfono corporativo sin bloqueo se extravía en un lugar público. |
| A8 | La red Wi-Fi usa una clave compartida que todavía conocen exempleados. |

## Parte A - Clasificar con evidencia

Completen una fila por caso. El hecho citado debe explicar la clasificación; no basta con escribir una etiqueta.

| ID  | Hecho o técnica que respalda la clasificación                                     | Activo y amenaza, diferenciados                                                                        | Vector principal                     | Vector secundario posible | Vulnerabilidad o condición                                     | Consecuencia posible                            |
| --- | --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------ | ------------------------- | -------------------------------------------------------------- | ----------------------------------------------- |
| A1  | Entrega de contraseña en un sitio falso enlazado desde un correo urgente.         | Activo: cuenta. Amenaza: actor que suplanta al remitente.                                              | Phishing                             | Ataques a credenciales    | Entrega de la contraseña y verificación insuficiente.          | Acceso no autorizado o fraude.                  |
| A2  | Un proveedor distribuye una actualización firmada que fue comprometida.           | Activos: software y sistemas que reciben la actualización. Amenaza: tercero o componente comprometido. | Terceros y cadena de suministro      | Malware                   | Confianza en un componente externo comprometido.               | Ejecución de código, alteración o interrupción. |
| A3  | RDP está accesible desde Internet y conserva una contraseña predeterminada.       | Activos: servidor y sus datos. Amenaza: actor remoto no autorizado.                                    | Servicios expuestos                  | Configuraciones inseguras | Exposición directa y credencial predeterminada.                | Acceso no autorizado al servidor.               |
| A4  | Un empleado usa su cuenta autorizada para copiar datos a almacenamiento personal. | Activo: datos de clientes. Amenaza: persona o cuenta con acceso legítimo.                              | Amenazas internas                    | Configuraciones inseguras | Salida de datos no controlada desde un acceso legítimo.        | Divulgación o pérdida de control de los datos.  |
| A5  | La aplicación concatena entradas del usuario en una consulta SQL.                 | Activos: aplicación y base de datos. Amenaza: usuario malicioso o entrada manipulada.                  | Vulnerabilidades de aplicaciones web | Configuraciones inseguras | La entrada se incorpora a la consulta sin separación adecuada. | Lectura o modificación no autorizada.           |
| A6  | Pendrives con un rótulo atractivo buscan inducir a una persona a conectarlos.     | Activos: equipos y datos. Amenaza: persona que introduce el medio o código que este contiene.          | Medios removibles                    | Ingeniería social         | Conexión de un medio desconocido inducida por engaño.          | Ejecución de código o pérdida de información.   |
| A7  | Un teléfono corporativo sin bloqueo se extravía en un lugar público.              | Activos: dispositivo, cuentas y datos. Amenaza: tercero que accede al equipo extraviado.               | Dispositivos móviles                 | Ataques físicos           | Ausencia de bloqueo del dispositivo.                           | Acceso a datos o sesiones.                      |
| A8  | La clave Wi-Fi compartida sigue siendo conocida por exempleados.                  | Activos: red y servicios conectados. Amenaza: usuario que ya no está autorizado.                       | Redes inalámbricas                   | Ataques a credenciales    | Clave compartida que no fue revocada.                          | Conexión no autorizada a la red.                |

## Parte B - Relacionar un control

Para **A2, A3, A5 y A7**, propongan un control inicial que responda directamente a la condición y una evidencia que permita verificarlo.

| ID  | Control inicial                                                                                | Condición que reduce                               | Evidencia de funcionamiento                                                               |
| --- | ---------------------------------------------------------------------------------------------- | -------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| A2  | Validar al proveedor y desplegar actualizaciones de forma controlada.                          | Confianza automática en una actualización externa. | Registro de aprobación, verificación de procedencia y resultado del despliegue de prueba. |
| A3  | Retirar la exposición directa, cambiar la credencial predeterminada y exigir acceso protegido. | RDP público con autenticación débil.               | Configuración efectiva y prueba autorizada de que el acceso directo queda denegado.       |
| A5  | Utilizar consultas parametrizadas y revisar el código afectado.                                | Concatenación de entradas en la consulta.          | Revisión del cambio y pruebas que comprueben el tratamiento seguro de entradas.           |
| A7  | Exigir bloqueo y cifrado administrados, con capacidad autorizada de revocación.                | Dispositivo accesible sin bloqueo.                 | Estado de cumplimiento y resultado de una prueba controlada de bloqueo o revocación.      |

Para A5, indiquen además una categoría OWASP pertinente. Expliquen en una frase por qué la categoría orienta la comunicación, pero no demuestra por sí sola la existencia de la vulnerabilidad.

**Respuesta:** Para A5 es pertinente la categoría **inyección** de OWASP. La categoría ayuda a nombrar y comunicar el tipo de riesgo, pero la existencia de la vulnerabilidad debe sustentarse con el código o con una prueba autorizada.

## Parte C - Triage inicial

Seleccionen **dos** casos que atenderían primero en una empresa pequeña. Justifiquen el orden usando únicamente:

- la exposición descrita en el caso;
- la consecuencia posible para el activo;
- la posibilidad de aplicar una medida inicial inmediata.

Para cada caso, declaren un dato faltante que podría cambiar el orden. No deben calcular probabilidad, construir una matriz de riesgo, estimar riesgo residual ni clasificar formalmente los controles: esos contenidos se estudiarán después.

**Respuesta orientativa:** no existe un único orden sin más contexto. Una respuesta posible es:

| Orden | Caso | Justificación con los criterios indicados | Dato faltante que podría cambiar el orden |
| ---: | --- | --- | --- |
| 1 | A3 | RDP está expuesto directamente a Internet con una contraseña predeterminada; podría permitir acceso al servidor y es posible retirar la exposición y cambiar la credencial de inmediato. | Si el servicio realmente es accesible desde cualquier origen y qué datos o funciones contiene el servidor. |
| 2 | A5 | La aplicación incorpora entradas en una consulta SQL; una explotación podría afectar la base de datos y se puede restringir temporalmente la función mientras se corrige con consultas parametrizadas. | Si la función es accesible para usuarios externos y qué sensibilidad tienen los datos. |

## Parte D - Cierre individual

Cada integrante responde en dos o tres frases:

1. ¿En qué se diferencian vector y vulnerabilidad?
   **Respuesta:** El vector es la vía o mecanismo general utilizado para alcanzar un activo. La vulnerabilidad es la debilidad o condición que permite o facilita ese recorrido.
2. ¿Por qué pueden coexistir un vector principal y uno secundario?
   **Respuesta:** Un caso puede combinar varios mecanismos. El vector principal describe la vía dominante y el secundario aporta otra vía o condición relevante sustentada por el mismo caso.
3. ¿Por qué una categoría OWASP no reemplaza la evidencia del caso?
   **Respuesta:** OWASP ayuda a nombrar y comunicar una categoría de riesgo. La evidencia observable o una validación técnica autorizada es la que demuestra la condición concreta.

## Entrega y criterios comunes

Entreguen las dos tablas, el triage justificado y los cierres individuales.

| Criterio | Logro esperado |
| --- | --- |
| Conceptos | Distingue activo, amenaza, vector, vulnerabilidad y consecuencia. |
| Clasificación | Sustenta los vectores principal y secundario con un hecho del caso. |
| Control | Relaciona la medida con una condición concreta y propone evidencia verificable. |
| Triage | Ordena dos casos con los criterios dados y declara información faltante. |
