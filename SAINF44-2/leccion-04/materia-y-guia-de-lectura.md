---
title: "Materia y guía de lectura - AAA y política de firewall"
tags:
  - nota
  - course
  - curso
  - materia
  - guia-de-lectura
  - aaa
  - firewall
  - materia-y-guia-de-lectura
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "04"
author: Jordy
start: 2026-08-31
end: 2026-09-01
created_at: "2026-08-07 21:08"
aliases:
  - "Materia y guía de lectura - AAA y política de firewall"
---
# Materia y guía de lectura - AAA y política de firewall

```toc
```

## Propósito de esta guía

Esta guía contiene todo el contenido conceptual necesario para la lección 04. Su objetivo es diseñar controles básicos de identidad, privilegios, registro de actividad y filtrado de red; demostrar su funcionamiento mediante pruebas permitidas y denegadas; y conservar una vía segura de reversión.

La práctica se realiza en dos VMs Linux aisladas entregadas por el docente: AAA local mediante usuarios, grupos, SSH, `sudo` y logs, y firewall mediante UFW. RADIUS/TACACS+ se comparan conceptualmente; no se despliega un servidor AAA central. Si ocurre una falla técnica, el docente la resuelve en el momento y no se descuenta puntaje por ella. No se aplican reglas ni configuraciones a infraestructura institucional o productiva.

La sintaxis, los parámetros y la interpretación de salidas se encuentran en `guia-actividad-04.md`; el trabajo y producto solicitado se definen en `actividad.md`, y las plantillas verificables están en la carpeta `material/`.

## Objetivos de estudio

Al finalizar deberías poder:

- Explicar el modelo AAA y su relación con la trazabilidad.
- Asignar permisos mediante roles y menor privilegio.
- Comparar autenticación local con servicios centralizados como RADIUS o TACACS+.
- Diseñar una política de firewall comprensible y verificable.
- Reconocer la importancia del orden de reglas y el seguimiento de estado.
- Probar controles con casos positivos y negativos.
- Utilizar logs sin registrar secretos.
- Documentar una vía de recuperación, reversión y expiración de excepciones.

## Alcance técnico del laboratorio

| Componente | Tratamiento en la lección 04 |
| --- | --- |
| AAA local | Se configura en Linux con cuentas individuales, grupos, SSH, `sudo` y logs. |
| RADIUS/TACACS+ | Se comparan como métodos centralizados; no se despliegan. |
| Firewall | Se diseña una política y se implementa con UFW en una VM aislada. |
| Accounting | Se revisan eventos de SSH, `sudo` y UFW. |
| Snort | No se configura; corresponde a la lección 05. |

## Organizador previo: del requisito a la evidencia

```text
REQUISITO                 CONTROL                 PRUEBA                  EVIDENCIA
Quién entra        →      SSH + cuenta      →     acceso/fallo      →     evento de autenticación
Qué puede hacer    →      rol + sudoers      →     permitido/denegado →   evento sudo
Qué tráfico pasa   →      política UFW       →     origen autorizado/
                                                   no autorizado    →     resultado + UFW BLOCK
Cómo recuperar     →      consola + snapshot →     reversión         →     estado posterior
```

La actividad evaluada no exige construir toda la infraestructura desde cero. Las VMs llegan con red, cuentas, grupos y SSH preparados para que el tiempo se concentre en diseñar, validar y explicar controles.

| Núcleo evaluado | Ampliación o preparación docente |
| --- | --- |
| Matriz AAA y menor privilegio. | Crear todas las cuentas y grupos desde cero. |
| Validación de `sudoers` y permisos efectivos. | Configuración avanzada de SSH. |
| Política UFW mínima. | Despliegue de RADIUS/TACACS+. |
| Pruebas positivas/negativas y logs. | Pruebas adicionales y servicio HTTPS opcional. |
| Reversión y conclusión limitada. | Snort, fuerza bruta o escaneo. |

Esta separación reduce navegación y tareas administrativas sin eliminar la dificultad productiva: decidir qué permitir, comprobar qué ocurrió y justificar la evidencia.

## 1. Identidad, cuenta, credencial y sesión

Estos términos se relacionan, pero no significan lo mismo.

| Concepto | Explicación |
| --- | --- |
| Identidad | Representación de una persona, servicio o dispositivo. |
| Cuenta | Registro utilizado por un sistema para reconocer una identidad. |
| Credencial | Elemento presentado para demostrar una identidad: contraseña, clave, token o certificado. |
| Sesión | Contexto temporal creado después de autenticar, con permisos y actividad asociados. |
| Rol | Conjunto de responsabilidades y permisos para una función. |

Una contraseña correcta demuestra que se presentó una credencial válida; no garantiza por sí sola que la persona legítima la esté utilizando. Por eso se combinan factores, contexto, monitoreo y controles de sesión.

### Cuentas individuales

Las cuentas compartidas dificultan saber quién realizó una acción y complican revocación, investigación y responsabilidad. Para administración se prefieren identidades individuales, incluso cuando varias personas cumplen el mismo rol.

Las cuentas de servicio también deben tener dueño, propósito, permisos acotados, credenciales protegidas y revisión periódica.

## 2. El modelo AAA

AAA reúne tres preguntas:

| Componente | Pregunta | Ejemplo |
| --- | --- | --- |
| Authentication - autenticación | ¿Quién eres y cómo lo demuestras? | Usuario, clave y segundo factor. |
| Authorization - autorización | ¿Qué puedes hacer después de autenticar? | Soporte puede consultar estado, pero no cambiar firewall. |
| Accounting - registro o contabilización | ¿Qué hiciste, cuándo, desde dónde y con qué resultado? | Inicio, cambio, fallo, elevación y cierre de sesión. |

### Orden lógico

1. Se presenta una identidad y una credencial.
2. El sistema autentica o rechaza.
3. Si autentica, determina permisos.
4. Durante la sesión registra eventos pertinentes.

Autenticar no significa autorizar todo. Un usuario puede demostrar quién es y aun así carecer de permiso para una acción.

### Ejemplo completo

- Camila presenta sus credenciales: autenticación.
- El sistema confirma su rol `soporte`: autorización.
- Consulta el estado de una interfaz: acción permitida.
- Intenta modificar una regla: acción denegada.
- Ambos eventos quedan asociados con identidad, origen, hora y resultado: accounting.

## 3. Autenticación

La autenticación puede utilizar:

- Algo que la persona sabe: contraseña o PIN.
- Algo que posee: token, llave o dispositivo.
- Algo que es: característica biométrica.
- Contexto adicional: dispositivo, ubicación, riesgo o red de origen.

La combinación de factores busca reducir el riesgo de que una credencial comprometida sea suficiente.

### Riesgos habituales

- Cuentas compartidas.
- Contraseñas predeterminadas o reutilizadas.
- Credenciales almacenadas sin protección.
- Métodos de recuperación débiles.
- Factores que pueden aprobarse por fatiga o engaño.
- Falta de revocación al cambiar de rol.

### Evidencia de autenticación

- Política aplicada.
- Cuentas cubiertas.
- Éxitos y fallos.
- Método utilizado.
- Origen y momento.
- Alertas o bloqueos.
- Resultados de pruebas autorizadas.

Los logs nunca deben guardar contraseñas, secretos completos ni tokens reutilizables.

## 4. Autorización, roles y menor privilegio

### Menor privilegio

Cada identidad recibe solo los permisos necesarios, durante el tiempo necesario y sobre los recursos necesarios.

No significa impedir el trabajo. Significa reducir el impacto de errores, abuso o compromiso de cuenta.

### Separación de funciones

Divide acciones críticas entre roles para que una sola persona no controle todo el proceso.

En el laboratorio:

| Rol | Propósito general |
| --- | --- |
| `admin-red` | Administrar configuración de red autorizada. |
| `soporte` | Ejecutar tareas operativas acotadas. |
| `auditor` | Consultar registros y evidencia sin modificar configuración. |

### Matriz rol-recurso-acción

| Rol | Recurso | Consultar | Cambiar | Administrar identidades | Revisar logs |
| --- | --- | :---: | :---: | :---: | :---: |
| `admin-red` | Configuración de red | Sí | Sí | Según alcance | Sí |
| `soporte` | Estado operativo | Sí | Solo acciones definidas | No | Limitado |
| `auditor` | Registros | Sí | No | No | Sí, solo lectura |

La matriz es un punto de partida. Cada permiso debe justificarse según el escenario y evitar expresiones vagas como “acceso completo”.

### La cuenta que no está en la matriz

Además de los tres roles existe `docente`, la cuenta que construyó las VMs y tiene privilegios completos. No aparece en la matriz AAA, y eso es deliberado.

Ninguna organización funciona solo con roles acotados: alguien tuvo que crear las cuentas, escribir las autorizaciones y podrá recuperar el sistema si un cambio lo deja inaccesible. Esa cuenta existe siempre, y un diseño honesto la reconoce en vez de fingir que no está.

Lo que sí corresponde es tratarla distinto: sirve para preparar y para recuperar, no para operar. Si administras el firewall con la cuenta general en lugar del rol previsto, los registros pierden atribución -todo aparece hecho por la misma identidad- y la matriz de roles queda como un documento sin correspondencia con los hechos.

Por eso en el laboratorio el firewall se aplica como `admin01` y no como `docente`, aunque `docente` también podría hacerlo.

### Evidencia de autorización

- Matriz aprobada.
- Configuración efectiva.
- Prueba permitida para cada rol.
- Prueba denegada fuera del rol.
- Revisión de excepciones.
- Registro de cambios de privilegios.

## 5. Accounting y trazabilidad

Accounting registra actividad suficiente para reconstruir una sesión o decisión de acceso.

Eventos útiles:

- Inicio y cierre de sesión.
- Autenticación exitosa y fallida.
- Acción privilegiada.
- Cambio de configuración.
- Elevación o cambio de rol.
- Acción denegada.
- Origen, destino y tiempo.
- Resultado y código de error.

Un evento útil debería responder:

> **quién → hizo qué → sobre qué → cuándo → desde dónde → con qué resultado**

### Calidad del registro

- Identidades individuales.
- Hora y zona sincronizadas.
- Campos suficientes.
- Retención definida.
- Acceso protegido.
- Alertas y revisión asignadas.
- Protección de secretos y datos innecesarios.

Generar logs sin que nadie pueda consultarlos o atenderlos no crea un control detectivo efectivo.

### Cuando el rol no alcanza para investigar

Un detalle que aparece al trabajar en el laboratorio: el rol `auditor` puede leer los registros del servicio SSH, pero **no** los del núcleo del sistema, que es donde el firewall anota lo que bloquea.

O sea que un auditor con esa autorización puede confirmar quién entró y quién falló al autenticarse, pero no puede demostrar por sí mismo que un intento fue rechazado por el firewall. Necesita pedir esa evidencia a quien tenga el permiso.

No es un defecto del laboratorio: es lo que ocurre cuando un rol se define pensando en un servicio y no en la pregunta que tendrá que responder. Es también una tensión real del menor privilegio -conceder lo mínimo puede dejar a alguien sin poder hacer su trabajo- y se resuelve revisando el alcance del rol, nunca ampliándoselo uno mismo.

Que puedas nombrar esta limitación en tu conclusión vale más que haberla evitado.

## 6. Métodos locales y centralizados

### Autenticación local

Las cuentas y reglas se mantienen en cada dispositivo o sistema.

**Ventajas:** simplicidad y posible acceso de emergencia sin depender de red.

**Limitaciones:** administración dispersa, inconsistencias, revocación lenta y menor trazabilidad central.

### RADIUS

Se utiliza ampliamente para acceso a red y servicios. Centraliza autenticación, autorización y registros según la implementación.

### TACACS+

Se utiliza con frecuencia para administración de dispositivos de red y puede ofrecer control detallado sobre comandos y funciones, según la plataforma.

### Comparación conceptual

| Aspecto | Local | Centralizado |
| --- | --- | --- |
| Gestión | Por dispositivo. | Desde un servicio común. |
| Revocación | Debe aplicarse en cada equipo. | Puede propagarse desde identidad central. |
| Disponibilidad | No depende del servidor AAA. | Requiere conectividad y redundancia. |
| Trazabilidad | Logs distribuidos. | Puede centralizar eventos. |
| Uso razonable | Emergencia o entorno pequeño controlado. | Operación habitual con varios sistemas. |

La elección no debe depender solo del protocolo. Debe considerar disponibilidad, cifrado, compatibilidad, roles, logs, operación y recuperación.

## 7. Evitar el bloqueo administrativo

Una configuración AAA incorrecta puede dejar al equipo sin acceso administrativo. Antes de cambiar:

1. Confirmar que el laboratorio es aislado y autorizado.
2. Guardar la configuración inicial.
3. Disponer de consola local y de una instantánea de reversión.
4. Mantener una sesión de respaldo cuando el entorno lo permita.
5. Verificar conectividad hacia el servicio AAA.
6. Crear y probar una cuenta o método de recuperación controlado.
7. Aplicar cambios por etapas.
8. Probar autenticación antes de retirar el método anterior.
9. Preparar reversión automática o manual.
10. Registrar el resultado.

No se practica recuperación sobre infraestructura real. Si se pierde el acceso remoto a la VM, se entra por la consola de VirtualBox y se aplica la reversión documentada; si eso no basta, se restaura la instantánea `LAB04-INICIAL`.

## 8. ¿Qué hace un firewall?

Un firewall aplica decisiones sobre comunicaciones según una política. Puede considerar:

- Origen y destino.
- Dirección de flujo.
- Protocolo y puerto o servicio.
- Interfaz o zona.
- Estado de conexión.
- Identidad o aplicación, si la plataforma lo permite.
- Acción: permitir, denegar, rechazar o registrar.

Un firewall no corrige por sí solo vulnerabilidades, credenciales comprometidas, permisos excesivos o errores de aplicación. Es una capa dentro de una arquitectura.

## 9. Política frente a regla

### Política

Expresa la intención de seguridad:

> “Solo el personal administrativo autorizado puede gestionar el servicio desde la red de administración; el portal público acepta HTTPS; cualquier otro acceso se deniega y se registra según capacidad”.

### Regla

Traduce una parte de esa intención a campos verificables.

| Campo | Pregunta |
| --- | --- |
| Identificador | ¿Cómo se referencia y audita? |
| Origen | ¿Quién o qué red inicia? |
| Destino | ¿Qué activo recibe? |
| Servicio | ¿Qué protocolo y puerto se permiten? |
| Acción | ¿Permitir, denegar o rechazar? |
| Estado | ¿Nueva, establecida o relacionada? |
| Registro | ¿Qué evento se conserva? |
| Justificación | ¿Qué necesidad o riesgo trata? |
| Responsable | ¿Quién aprueba y revisa? |
| Vigencia | ¿Es permanente o temporal? |

Una regla técnicamente válida puede ser incorrecta si no responde a una necesidad aprobada.

### Qué valida la herramienta y qué no

Las dos herramientas del laboratorio comprueban cosas distintas, y conviene saber cuál te va a avisar de un error y cuál no.

**UFW valida al escribir.** Si te equivocas en el protocolo, responde de inmediato:

```text
ERROR: Unsupported protocol 'tsp'
```

La regla no se aplica y el error es evidente en el momento.

**`sudoers` valida la forma, no el fondo.** `visudo -c` comprueba que la sintaxis sea correcta y se niega a guardar un archivo mal escrito. Pero no comprueba que los programas que autorizas existan realmente. Si escribes una ruta equivocada, el archivo pasa la validación sin una sola advertencia; el permiso simplemente no funcionará, y quien lo use recibirá un "comando no permitido" sin ninguna pista de por qué.

De ahí una regla práctica: **después de escribir una autorización, pruébala.** `sudo -l -U usuario` muestra los permisos efectivos, y ejecutar la acción permitida y la denegada confirma que el diseño se comporta como esperabas.

Que una configuración sea aceptada por la herramienta no significa que haga lo que pretendías. Solo la prueba lo demuestra -y esa es, en el fondo, la idea que recorre toda la lección.

## 10. Denegación por defecto y mínimo acceso

**Denegación por defecto** significa que el tráfico no permitido explícitamente se rechaza. Obliga a justificar las excepciones.

No significa bloquear todo sin analizar requisitos. Primero se identifican flujos necesarios y luego se permite solo lo requerido.

### Escenario de clase

- Administración: permitida únicamente desde `10.10.10.0/24` hacia el servicio definido.
- Portal público: HTTPS permitido desde los orígenes previstos.
- Otros servicios: denegados.
- Eventos relevantes: registrados con límites razonables.

`10.10.10.0/24` representa la subred de administración indicada por el escenario, no una identidad personal. La red de origen debe combinarse con autenticación y autorización.

### Evitar `any/any`

Una regla “cualquier origen, cualquier destino, cualquier servicio, permitir” anula el objetivo de mínimo acceso. Si existe una excepción amplia, debe acotarse por origen, destino, servicio y tiempo, además de justificarla y revisarla.

## 11. Orden de reglas y estado

### Orden

Muchas plataformas evalúan reglas en orden y aplican la primera coincidencia. Una regla amplia situada antes puede ocultar reglas más específicas.

Ejemplo conceptual:

1. Permitir administración desde la subred autorizada.
2. Permitir HTTPS al portal.
3. Denegar y registrar el resto.

El comportamiento exacto depende de la plataforma; debe comprobarse en el laboratorio. UFW mantiene su propio orden de evaluación y `ufw status numbered` es donde se lee.

### Seguimiento de estado

Un firewall con estado recuerda conexiones iniciadas y permite tráfico de respuesta asociado, según la política. Esto evita escribir reglas independientes para cada paquete de retorno.

No se debe asumir que todo tráfico de una conexión establecida es seguro. El estado solo indica relación con una sesión observada, no legitimidad del contenido.

## 12. Registro de firewall

Los logs deben ser útiles y sostenibles.

Campos frecuentes:

- Fecha, hora y zona.
- Regla aplicada.
- Acción.
- Origen y destino.
- Protocolo y servicio.
- Interfaz o zona.
- Estado o motivo.

Registrar absolutamente cada paquete puede saturar almacenamiento y ocultar señales. Se priorizan:

- Denegaciones relevantes.
- Accesos administrativos.
- Cambios de política.
- Excepciones temporales.
- Eventos necesarios para verificar pruebas.

La política debe definir retención, responsable de revisión y respuesta ante alertas.

## 13. Pruebas positivas y negativas

Una prueba positiva verifica que un uso autorizado funciona. Una negativa verifica que un uso no autorizado se bloquea.

| Prueba | Entrada | Resultado esperado | Evidencia |
| --- | --- | --- | --- |
| Administración autorizada | Rol y origen permitidos. | Acceso permitido. | Sesión y log asociados. |
| Origen no autorizado | Mismo servicio desde otra red. | Acceso denegado. | Log de denegación. |
| Rol sin privilegio | `soporte` intenta acción exclusiva de `admin-red`. | Acción denegada. | Evento AAA. |
| Portal HTTPS | Cliente hacia servicio público. | Conexión permitida. | Log y prueba de servicio. |
| Servicio no autorizado | Conexión a otro puerto. | Denegada. | Regla final aplicada. |

Para cada prueba se registra:

- Precondiciones.
- Identidad y origen de prueba.
- Acción realizada.
- Resultado esperado.
- Resultado observado.
- Log o captura explicada.
- Conclusión y desviación.

Probar solo los casos permitidos no demuestra que el control rechace lo indebido.

## 14. Reversión y excepciones temporales

### Reversión

Antes de cambiar:

- Conservar configuración inicial.
- Definir responsable y criterio de fallo.
- Preparar procedimiento de restauración.
- Establecer tiempo máximo para confirmar éxito.
- Probar la vía de recuperación.

Si una prueba esencial falla, se revierte y se documenta antes de intentar otro cambio.

### Excepción temporal

Debe registrar:

- Necesidad y riesgo.
- Origen, destino y servicio exactos.
- Propietario y aprobador.
- Inicio y expiración.
- Monitoreo adicional.
- Acción de cierre o reversión.

Una excepción sin expiración tiende a transformarse en una regla permanente no revisada.

## 15. Caso integrado del laboratorio

### Requisitos

- `admin-red` administra dentro del alcance.
- `soporte` ejecuta acciones acotadas.
- `auditor` consulta registros sin modificar.
- Administración solo desde `10.10.10.0/24`.
- Portal público disponible mediante HTTPS.
- El resto se deniega y registra según capacidad.

### Secuencia de diseño

1. Identificar recursos y acciones.
2. Completar la matriz rol-recurso-acción.
3. Definir eventos de accounting.
4. Escribir la política en lenguaje simple.
5. Traducirla a pseudorreglas ordenadas.
6. Preparar pruebas positivas y negativas.
7. Verificar logs.
8. Documentar reversión y excepción temporal.

### Plantilla de política

| ID | Origen | Destino | Servicio | Acción | Registro | Justificación | Vigencia |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |

### Criterio para concluir efectividad

No basta con que la configuración se guarde. La conclusión debe comparar resultados esperados y observados:

- Los usos autorizados funcionaron.
- Los usos no autorizados fueron rechazados.
- Los roles limitaron las acciones.
- Los eventos aparecieron en los logs sin exponer secretos.
- La reversión quedó disponible.
- Las desviaciones se documentaron.

## 16. Errores frecuentes

- Confundir autenticación con autorización.
- Utilizar cuentas administrativas compartidas.
- Conceder privilegios “por si acaso”.
- Registrar contraseñas o tokens en logs y capturas.
- Activar AAA sin una vía de recuperación.
- Escribir reglas sin política ni justificación.
- Permitir `any/any` para resolver rápidamente una falla.
- Ubicar una regla amplia antes de una específica.
- Probar únicamente accesos permitidos.
- Concluir efectividad sin revisar logs.
- Crear excepciones sin propietario ni expiración.
- Aplicar la práctica a equipos o redes reales.

## 17. Qué se estudiará después

| Tema | Lección posterior |
| --- | --- |
| IDS/IPS, reglas y alertas Snort | Lección 05. |
| Integración de AAA, firewall e IDS | Lecciones 05 y 06. |
| Gestión formal de riesgos y políticas | UA2. |
| Auditoría y métricas de controles | Lección 11. |
| Respuesta y recuperación | UA3. |

## Guía de estudio

1. Explica AAA usando una sola sesión de ejemplo.
2. Diseña una matriz para `admin-red`, `soporte` y `auditor`.
3. Escribe una política antes de traducirla a reglas.
4. Diseña dos pruebas permitidas y tres denegadas.
5. Explica qué logs esperas encontrar.
6. Completa `actividad.md`.
7. Ensaya la reversión ante una regla que bloquea la administración.
8. Resuelve la autoevaluación.

## Autoevaluación

### Preguntas

1. ¿Qué diferencia existe entre identidad, cuenta y credencial?
2. Explica autenticación, autorización y accounting.
3. ¿Por qué una cuenta compartida reduce trazabilidad?
4. ¿Qué significa menor privilegio?
5. ¿Qué ventaja y qué riesgo posee un servicio AAA centralizado?
6. ¿Qué debe existir antes de activar una configuración AAA nueva?
7. ¿Qué diferencia existe entre política y regla de firewall?
8. ¿Por qué importa el orden de las reglas?
9. ¿Por qué se necesitan pruebas positivas y negativas?
10. ¿Qué debe incluir una excepción temporal?

### Respuestas orientativas

1. Identidad representa al sujeto; cuenta es su registro en el sistema; credencial es lo presentado para demostrarla.
2. Autenticación verifica identidad; autorización determina acciones permitidas; accounting registra actividad y resultados.
3. Porque varias personas aparecen como la misma identidad y se dificulta atribuir, revisar o revocar acciones.
4. Otorgar solo los permisos, recursos y tiempo necesarios para cumplir una función.
5. Centraliza gestión y registros, pero depende de conectividad, disponibilidad y una recuperación bien diseñada.
6. Configuración inicial guardada, vía de recuperación, cuenta o método probado y plan de reversión.
7. La política expresa intención; la regla la traduce a condiciones y acciones técnicas verificables.
8. Porque una regla amplia evaluada antes puede capturar tráfico y anular reglas específicas posteriores.
9. Las positivas comprueban disponibilidad autorizada; las negativas comprueban que lo no autorizado se rechaza.
10. Necesidad, alcance exacto, riesgo, propietario, aprobación, inicio, expiración, monitoreo y reversión.

## Fuentes base y profundización opcional

- [Cisco IOS XE Security and VPN Configuration Guides](https://www.cisco.com/c/en/us/td/docs/routers/ios-xe/security-vpn/security-vpn.html): AAA, acceso administrativo y recuperación según plataforma.
- [NIST SP 800-41 Rev. 1 - Guidelines on Firewalls and Firewall Policy](https://csrc.nist.gov/pubs/sp/800/41/r1/final): política, arquitectura, reglas, registro y pruebas.
- [Ubuntu Server Guide - Firewall (UFW)](https://documentation.ubuntu.com/server/how-to/security/firewalls/): sintaxis, política por defecto, orden y registro de UFW.
- [`sudoers` manual page](https://www.sudo.ws/docs/man/sudoers.man/): formato de alias, especificaciones de comando y alcance de una autorización.

Fecha de consulta de recursos vivos: 07-08-2026.
