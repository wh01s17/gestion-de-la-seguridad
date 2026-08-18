---
title: "Solución docente - Vectores de ataque, versión B"
tags: [nota, course, curso, docente, reservado]
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "02"
author: Jordy
start: 2026-08-17
end: 2026-08-18
created_at: 2026-08-12
aliases:
  - "Solución docente - Vectores de ataque, versión B"
---
# Actividad 02 - Triage de vectores de ataque

**Duración:** 80 minutos. 
**Modalidad:** parejas. 
**Carácter:** formativo, sin calificación. 
**Versión:** B. 
**Aplicación prevista:** SAINF44-2, jornada vespertina.

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
| B1 | Una persona convence a soporte para restablecer la contraseña de otra cuenta sin verificar su identidad. |
| B2 | Un correo con una factura falsa induce a habilitar macros que ejecutan código malicioso. |
| B3 | Un panel administrativo permanece en Internet con depuración activa y credenciales predeterminadas. |
| B4 | Un contratista con acceso autorizado sincroniza datos de clientes con una nube personal. |
| B5 | Un pendrive desconocido conectado en recepción intenta ejecutar contenido automáticamente. |
| B6 | Una tableta corporativa sin bloqueo se extravía durante un viaje. |
| B7 | Personas se conectan a una red Wi-Fi falsa que imita el nombre de la red corporativa. |
| B8 | Una API entrega el registro de otro cliente cuando se modifica el identificador de la solicitud. |

## Parte A - Clasificar con evidencia

Completen una fila por caso. El hecho citado debe explicar la clasificación; no basta con escribir una etiqueta.

| ID  | Hecho o técnica que respalda la clasificación                                       | Activo y amenaza, diferenciados                                                              | Vector principal                     | Vector secundario posible | Vulnerabilidad o condición                                   | Consecuencia posible                           |
| --- | ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | ------------------------------------ | ------------------------- | ------------------------------------------------------------ | ---------------------------------------------- |
| B1  | Restablecimiento de una contraseña sin verificar la identidad de quien lo solicita. | Activo: cuenta. Amenaza: persona que suplanta al titular ante soporte.                       | Ingeniería social                    | Ataques a credenciales    | Proceso de soporte con verificación insuficiente.            | Toma o uso no autorizado de la cuenta.         |
| B2  | Un correo con una factura falsa induce a habilitar macros que ejecutan código.      | Activos: equipo y datos. Amenaza: actor que distribuye el documento malicioso.               | Phishing                             | Malware                   | Ejecución de macros inducida por engaño.                     | Ejecución de código o pérdida de información.  |
| B3  | El panel está en Internet con depuración y credenciales predeterminadas.            | Activo: servidor administrativo. Amenaza: actor remoto no autorizado.                        | Servicios expuestos                  | Configuraciones inseguras | Depuración activa y credenciales predeterminadas.            | Acceso o modificación no autorizados.          |
| B4  | Un contratista usa acceso autorizado para sincronizar datos con una nube personal.  | Activo: datos de clientes. Amenaza: tercero con acceso legítimo.                             | Terceros y cadena de suministro      | Amenazas internas         | Acceso externo legítimo con salida de datos no controlada.   | Divulgación o pérdida de control de los datos. |
| B5  | Un pendrive desconocido intenta ejecutar contenido automáticamente al conectarse.   | Activos: equipo y datos. Amenaza: persona que introdujo el medio o código que este contiene. | Medios removibles                    | Malware                   | Uso de un medio desconocido y ejecución automática.          | Ejecución de código o alteración del equipo.   |
| B6  | Una tableta corporativa sin bloqueo se extravía durante un viaje.                   | Activos: dispositivo, cuentas y datos. Amenaza: tercero que accede al equipo extraviado.     | Dispositivos móviles                 | Ataques físicos           | Ausencia de bloqueo del dispositivo.                         | Acceso a datos o sesiones.                     |
| B7  | Una red Wi-Fi falsa imita el nombre de la red corporativa y atrae conexiones.       | Activos: cuentas y comunicaciones. Amenaza: operador de la red falsa.                        | Redes inalámbricas                   | Ingeniería social         | Usuarios conectados a una red suplantada.                    | Exposición de comunicaciones o credenciales.   |
| B8  | La API entrega el registro de otro cliente al modificar un identificador.           | Activos: aplicación y datos de clientes. Amenaza: usuario que manipula la solicitud.         | Vulnerabilidades de aplicaciones web | Configuraciones inseguras | Control de acceso insuficiente sobre cada objeto solicitado. | Divulgación o modificación de datos ajenos.    |

## Parte B - Relacionar un control

Para **B2, B3, B6 y B8**, propongan un control inicial que responda directamente a la condición y una evidencia que permita verificarlo.

| ID  | Control inicial                                                                                    | Condición que reduce                                        | Evidencia de funcionamiento                                                              |
| --- | -------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| B2  | Bloquear macros no autorizadas y filtrar el mensaje engañoso.                                      | Ejecución inducida desde un documento recibido.             | Política efectiva y resultado de una prueba controlada de bloqueo o alerta.              |
| B3  | Retirar la exposición innecesaria, desactivar la depuración y cambiar los valores predeterminados. | Panel público con configuración débil.                      | Configuración revisada y prueba autorizada de que el acceso no permitido queda denegado. |
| B6  | Exigir bloqueo y cifrado administrados, con capacidad autorizada de revocación.                    | Dispositivo accesible sin bloqueo.                          | Estado de cumplimiento y resultado de una prueba controlada de bloqueo o revocación.     |
| B8  | Verificar la autorización sobre cada objeto solicitado.                                            | La API confía en el identificador entregado por el usuario. | Revisión del control y prueba negativa con dos cuentas de laboratorio.                   |

Para B8, indiquen además una categoría OWASP pertinente. Expliquen en una frase por qué la categoría orienta la comunicación, pero no demuestra por sí sola la existencia de la vulnerabilidad.

**Respuesta:** Para B8 es pertinente la categoría **control de acceso roto** de OWASP. La categoría ayuda a nombrar y comunicar el tipo de riesgo, pero la condición concreta debe sustentarse con la solicitud, el resultado observado y la revisión del control.

## Parte C - Triage inicial

Seleccionen **dos** casos que atenderían primero en una empresa pequeña. Justifiquen el orden usando únicamente:

- la exposición descrita en el caso;
- la consecuencia posible para el activo;
- la posibilidad de aplicar una medida inicial inmediata.

Para cada caso, declaren un dato faltante que podría cambiar el orden. No deben calcular probabilidad, construir una matriz de riesgo, estimar riesgo residual ni clasificar formalmente los controles: esos contenidos se estudiarán después.

| Orden | Caso | Justificación con los criterios indicados                                                                                                                                                                       |
| ----: | ---- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     1 | B3   | El panel administrativo está expuesto a Internet con depuración y credenciales predeterminadas; podría permitir acceso al servidor y se puede retirar la exposición y cambiar la configuración de inmediato.    |
|     2 | B8   | La API ya entrega datos de otro cliente al cambiar un identificador; la consecuencia es la divulgación de datos y se puede restringir temporalmente la operación mientras se valida la autorización por objeto. |

## Parte D - Cierre individual

Cada integrante responde en dos o tres frases:

1. ¿En qué se diferencian vector y vulnerabilidad?
   **Respuesta:** El vector es la vía o mecanismo general utilizado para alcanzar un activo. La vulnerabilidad es la debilidad o condición que permite o facilita ese recorrido.
2. ¿Por qué pueden coexistir un vector principal y uno secundario?
   **Respuesta:** Un caso puede combinar varios mecanismos. El vector principal describe la vía dominante y el secundario aporta otra vía o condición relevante sustentada por el mismo caso.
3. ¿Por qué una categoría OWASP no reemplaza la evidencia del caso?
   **Respuesta:** OWASP ayuda a nombrar y comunicar una categoría de riesgo. La evidencia observable o una validación técnica autorizada es la que demuestra la condición concreta.
