---
title: "Actividad Lección 04 - Diseñar y validar AAA local y firewall"
tags:
  - nota
  - course
  - curso
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "04"
author: Jordy
start: 2026-08-31
end: 2026-09-01
created_at: 2026-08-28
aliases:
  - "Actividad Lección 04 - Diseñar y validar AAA local y firewall"
---
# Actividad Lección 04 - Diseñar y validar AAA local y firewall

**Duración de laboratorio:** 80 minutos.  
**Trabajo previo:** etapa B, antes de la clase.  
**Modalidad:** ejecución en parejas y entrega individual.  
**Carácter:** actividad evaluada.  
**Entorno:** servidor y cliente Linux preconfigurados en una red interna aislada.

**Material:** carpeta `material/`. Comprueba primero su integridad con `sha256sum -c manifest_entrega.sha256`, **copia** las plantillas a tu carpeta de trabajo y completa ahí las copias; los originales quedan intactos.

Los cuatro CSV son donde se registra todo: no vuelvas a escribir esas tablas en el informe. Cada fase indica cuál completar.

> [!IMPORTANT] La etapa B se hace antes de la clase
> Es diseño en papel: no necesita las VMs. Llega con `matriz_aaa.csv` y las columnas de diseño de `politica_firewall.csv` completas.
> Los 80 minutos del bloque están calculados para las etapas A y C a G. Si llegas a diseñar en clase, ese tiempo sale de las etapas F y G, que son las que más puntaje sostienen.

## El caso

PUERTO SEGURO SPA opera servicios logísticos portuarios. Su infraestructura creció sin planificación y hoy un solo servidor Linux concentra la gestión de la operación: turnos, patios y coordinación con las navieras.

A ese servidor se conectan por SSH el encargado de redes, los dos turnos de soporte y una auditora externa contratada tras el último cierre contable. **Los cuatro entran con la misma cuenta administrativa y la misma contraseña.**

La revisión de controles dejó tres hallazgos que la gerencia clasificó como prioritarios:

| Hallazgo | Consecuencia |
| --- | --- |
| Una única cuenta compartida por cuatro personas | Ninguna acción puede atribuirse a alguien en concreto |
| El servidor acepta SSH desde cualquier origen de la red | La administración queda expuesta a toda la planta, incluidas las terminales de patio |
| Nadie revisa los registros | Un acceso indebido no se detectaría hasta que causara un daño visible |

Hace tres semanas alguien detuvo un servicio por error a las dos de la mañana. Nadie pudo determinar quién fue: la cuenta compartida los hacía a todos igualmente responsables y, por lo tanto, a ninguno.

## Tu encargo de hoy

La gerencia autorizó intervenir **este servidor como piloto**, con dos condiciones: el servicio no puede quedar fuera de línea, y todo cambio debe ser reversible.

Deben entregar:

1. cuentas individuales con permisos diferenciados por función;
2. un firewall que restrinja la administración a la red autorizada;
3. registros que permitan atribuir cada acción a una persona;
4. pruebas de que lo permitido funciona **y** lo denegado se rechaza;
5. una vía de reversión comprobada.

La red de administración es `10.10.10.0/24`. Las terminales de patio están en `10.20.20.0/24` y desde ahí **nadie** debe poder administrar el servidor, aunque tenga credenciales válidas. Esa distinción es la que separa autenticar de autorizar, y es lo que las pruebas deben demostrar.

El portal de seguimiento de carga que la empresa publica por HTTPS debe seguir accesible.

## Cómo funciona esta actividad

Es tu primera práctica en terminal del curso, así que está guiada paso a paso. **No tienes que inventar comandos.** Cada paso te dice qué escribir, qué deberías ver y dónde anotarlo.

> [!IMPORTANT] Si algo no sale como dice aquí
> No improvises: anótalo y avisa al docente.

## Etapa A - Comprobar el laboratorio

**Dónde:** VirtualBox y consola de `CLIENTE-LAB`, con la cuenta `docente`.

**Paso 0.** En VirtualBox, con las VMs encendidas o apagadas, abre **Instantáneas** en cada máquina y comprueba que existe `LAB04-INICIAL`.

Es la instantánea que creaste tú en el paso 3 de [`instalacion-vms.md`](instalacion-vms.md), antes de esta clase.

> [!CAUTION] Si no existe, no continúes
> Sin instantánea no hay vía de reversión, y la etapa G la exige. Apaga ambas VMs, créala ahora y recién entonces sigue con el paso 1.

**Paso 1.** Comprueba las direcciones del cliente:

```bash
ip -br addr
```

Debes ver `enp0s3` con `10.10.10.10/24` y `10.20.20.10/24`.

**Paso 2.** Comprueba que el servidor responde por las dos redes:

```bash
ping -c 2 10.10.10.20
```

```bash
ping -c 2 10.20.20.20
```

Ambos deben decir `2 received`.

**Paso 3.** Comprueba que el laboratorio está aislado:

```bash
ip route
```

> [!WARNING] No debe aparecer ninguna línea que empiece por `default`
> Si aparece, la máquina tiene salida a Internet y el laboratorio no está aislado. Avisa al docente antes de continuar.

**Paso 4.** Ahora en la consola de `SERVIDOR-LAB`, con la cuenta `docente`:

```bash
sudo ufw status
```

Debe decir `Status: inactive`. El firewall lo vas a activar tú en la etapa D.

> [!NOTE] Completa `linea_base.csv`
> Cinco filas, una por paso: `snapshot` con el paso 0, `direcciones_cliente` con el 1, `conectividad` con el 2, `aislamiento` con el 3 y `firewall_inicial` con el 4. Escribe lo que observaste y si coincide con lo esperado.

**Evidencia E1:** el CSV completo más una captura de pantalla de los pasos 0, 3 y 4.

## Etapa B - Diseñar los permisos y la política

Diseñar antes de ejecutar no es un formalismo: si primero configuras y después describes lo que hiciste, no diseñaste nada. Y si lo que ocurre no coincide con lo que anticipaste, esa diferencia es justamente lo que hay que investigar.

Por eso va antes y no durante: en clase ya tendrás delante la salida real de cada comando, y es demasiado tarde para predecir lo que ibas a ver.

Abre `matriz_aaa.csv`. La primera fila, la de `admin01`, **ya viene completada como ejemplo**. Completa las otras dos con el mismo criterio, usando la tabla de roles del caso:

| Cuenta | Qué necesita hacer | Qué NO debe poder hacer |
| --- | --- | --- |
| `soporte01` | Comprobar si SSH está operativo | Tocar el firewall |
| `auditor01` | Consultar el firewall y los accesos | Modificar cualquier control |

Responde además estas dos preguntas en tu informe, con una frase cada una:

1. Las cuatro personas de PUERTO SEGURO comparten hoy una cuenta. ¿Por qué eso impidió saber quién detuvo el servicio?
2. Si `soporte01` escribe bien su contraseña y entra al servidor, ¿por qué aun así no puede tocar el firewall?

### La política de firewall

Abre `politica_firewall.csv`. El origen y el servicio de cada regla ya vienen dados; tú decides la **acción** y escribes la **justificación**.

Guíate por lo que pide el caso:

- la administración solo puede venir de la red autorizada;
- el portal de seguimiento de carga debe seguir accesible;
- todo lo demás no debe entrar.

| Regla | Origen | Servicio | Acción | Justificación |
| ---: | --- | --- | --- | --- |
| 1 | `10.10.10.0/24` | TCP/22 | ¿permitir o denegar? | ¿por qué? |
| 2 | cualquiera | TCP/443 | ¿permitir o denegar? | ¿por qué? |
| 3 | cualquier otro | todo lo demás | ¿permitir o denegar? | ¿por qué? |

La tercera regla es la más importante y la que más se olvida: define qué pasa con **todo lo que no previste**. Un firewall que solo dice qué permitir, sin cerrar el resto, no protege nada.

**Evidencia E2:** `matriz_aaa.csv` y las columnas de diseño de `politica_firewall.csv` completos, más las dos respuestas.

## Etapa C - Probar quién puede qué

**Dónde:** consola de `CLIENTE-LAB`, con la cuenta `docente`.

### Prueba AAA-01: el encargado de redes entra

**Paso 5.** Conéctate al servidor como `admin01`:

```bash
ssh admin01@10.10.10.20
```

La primera vez te preguntará si aceptas la identidad del servidor. Escribe `yes`. Después pide la contraseña de `admin01`.

**Debe entrar.** El prompt cambia a `admin01@servidor-lab`.

**Paso 6.** Ya dentro, mira qué tiene permitido:

```bash
sudo -l
```

Debe aparecer una sola línea con `/usr/sbin/ufw`. Eso es todo lo que `admin01` puede hacer con privilegios.

**Paso 7.** Sal del servidor:

```bash
exit
```

> [!NOTE] Registra AAA-01
> Anota el resultado en `matriz_pruebas.csv`, fila **AAA-01**.

### Pruebas AAA-02 y AAA-03: qué puede y qué no puede soporte

**Paso 8.** Ahora entra como `soporte01`:

```bash
ssh soporte01@10.10.10.20
```

**Paso 9.** Intenta ver el estado del firewall:

```bash
sudo ufw status verbose
```

**Debe fallar**, con un mensaje parecido a:

```text
Sorry, user soporte01 is not allowed to execute
'/usr/sbin/ufw status verbose' as root on servidor-lab
```

> [!TIP] Que falle es el resultado correcto
> `soporte01` escribió bien su contraseña y aun así no pudo.
> **Autenticarse no es lo mismo que estar autorizado.**

> [!NOTE] Registra AAA-03
> Anota el resultado en `matriz_pruebas.csv`, fila **AAA-03**.

**Paso 10.** Comprueba lo que sí puede hacer:

```bash
sudo systemctl status ssh --no-pager
```

Este sí funciona. Sal con:

```bash
exit
```

> [!NOTE] Registra AAA-02
> Anota el resultado en `matriz_pruebas.csv`, fila **AAA-02**.

Los pasos 9 y 10 son la misma cuenta ejecutando dos órdenes distintas: una rechazada y otra aceptada. Ese par es la demostración de que la autorización no se concede por persona sino por acción. Una sola de las dos no demuestra nada.

**Evidencia E3:** capturas de los pasos 6, 9 y 10, y las tres filas AAA del CSV.

## Etapa D - Aplicar el firewall

**Dónde:** consola de `SERVIDOR-LAB`, con la cuenta **`admin01`**.

> [!CAUTION] Usa la consola, nunca SSH
> Activar el firewall corta las conexiones remotas en curso. Si lo haces conectado por SSH, te desconectas a ti mismo y pierdes el acceso.

> [!WARNING] Entra como `admin01`, no como `docente`
> `admin-red` es el rol autorizado para el firewall, y así los registros quedan a su nombre. Eso importa en la etapa F.

**Paso 11.** Bloquea todo lo que entra y permite lo que sale:

```bash
sudo ufw default deny incoming
```

```bash
sudo ufw default allow outgoing
```

**Paso 12.** Permite SSH solo desde la red de administración:

```bash
sudo ufw allow from 10.10.10.0/24 to any port 22 proto tcp
```

**Paso 13.** Permite el portal de carga:

```bash
sudo ufw allow 443/tcp
```

**Paso 14.** Activa el registro de lo que se bloquea:

```bash
sudo ufw logging low
```

**Paso 15.** Revisa lo que escribiste **antes** de activar:

```bash
sudo ufw show added
```

Deben aparecer las dos reglas de los pasos 12 y 13.

> [!IMPORTANT] Último momento para corregir sin consecuencias
> El firewall todavía no está activo. Si una regla quedó mal escrita, arréglala ahora.

**Paso 16.** Activa el firewall y mira cómo quedó:

```bash
sudo ufw enable
```

```bash
sudo ufw status numbered
```

Debe decir `Status: active` y listar las dos reglas.

> [!NOTE] Cierra `politica_firewall.csv`
> Llena la columna `resultado_observado` de las tres filas y comprueba que lo aplicado coincide con lo que diseñaste en la etapa B.

**Evidencia E4:** captura de `ufw status numbered` y el CSV completo.

## Etapa E - Probar el firewall

**Dónde:** consola de `CLIENTE-LAB`, con la cuenta `docente`.

### Prueba FW-01: desde la red de administración

**Paso 17.**

```bash
ssh admin01@10.10.10.20
```

**Debe entrar** y pedir contraseña de inmediato. Sal con `exit`.

### Prueba FW-02: desde las terminales de patio

**Paso 18.**

```bash
ssh -o ConnectTimeout=10 admin01@10.20.20.20
```

**Debe quedarse esperando y agotar el tiempo.** Fíjate en la diferencia: la prueba anterior pidió contraseña al instante; esta se queda colgada y termina con un error de tiempo agotado.

Es la misma cuenta y la misma contraseña. Lo que cambió es **desde dónde** te conectas.

> [!NOTE] Registra FW-01 y FW-02
> Anota ambos resultados en `matriz_pruebas.csv`.

> [!IMPORTANT] Una expiración no demuestra que fue el firewall
> Pudo ser un cable, una ruta o un servicio caído. Lo confirmas en la etapa siguiente, con el registro del servidor.

**Evidencia E5:** capturas de los pasos 17 y 18.

## Etapa F - Buscar los registros

**Dónde:** consola de `SERVIDOR-LAB`, con la cuenta `docente`.

**Paso 19.** Busca los accesos por SSH:

```bash
sudo journalctl -u ssh --since -20min | tail -20
```

Busca las líneas `Accepted password for admin01 from 10.10.10.10`. Ahí está quién entró, desde dónde y a qué hora.

**Paso 20.** Busca el bloqueo del firewall:

```bash
sudo journalctl -k --since -20min | grep BLOCK | tail -5
```

Debe aparecer una línea con `SRC=10.20.20.10` y `DPT=22`. **Ese es el evento que demuestra que fue el firewall** y no otra cosa.

> [!NOTE] Cierra `matriz_pruebas.csv`
> Completa la columna `donde_lo_confirmo` de las cuatro filas, indicando en qué registro viste cada resultado.

**Evidencia E6:** extractos breves de ambos registros. No pegues el log completo: solo las líneas que usaste.

## Etapa G - Cerrar y concluir

**Paso 21.** Pregunta al docente si debes restaurar la instantánea `LAB04-INICIAL` o dejar el laboratorio como está para la lección 05.

**Ejecuta lo que te indique** y comprueba el resultado. Si restauras, vuelve a entrar y confirma:

```bash
sudo ufw status
```

Debe decir `inactive` otra vez: la máquina volvió a su estado inicial.

Anota qué te indicaron, qué hiciste y cómo comprobaste que quedó bien.

> [!NOTE] Por qué se revierte
> Todo cambio en un sistema debe poder deshacerse. Si aplicas una regla que deja a la organización sin acceso a su propio servidor, la reversión es lo único que separa un error de una interrupción del servicio.

**Paso 22.** Escribe tu conclusión individual, entre 80 y 120 palabras, respondiendo:

1. ¿Qué controles implementaste?
2. ¿Qué demostraste con las pruebas permitidas y con las denegadas?
3. ¿Qué **no** puedes afirmar a partir de lo que probaste?

La tercera es la más importante. Probaste cuatro casos concretos; eso no significa que el servidor sea seguro. Nombrar ese límite es parte de trabajar con rigor.

**Evidencia E7:** la reversión anotada y tu conclusión.

## Entrega individual

La entrega tiene **dos partes**:

| Qué                        | Formato                                                                           | Contenido                                                                                        |
| -------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| Los cuatro CSV completados | `linea_base.csv`, `matriz_aaa.csv`, `politica_firewall.csv`, `matriz_pruebas.csv` | Los datos: diseño, resultados observados y fuentes                                               |
| Tu informe individual      | Un documento                                                                      | Las evidencias E1 a E7, las respuestas de las etapas B y G, capturas de pantalla y tu conclusión |

**No repitas las tablas en el informe.** Los datos van en los CSV; el informe explica qué demuestran.

Las evidencias técnicas pueden ser compartidas por la pareja, pero cada estudiante debe:

- explicar con sus propias palabras qué demuestra cada evidencia;
- identificar una limitación;
- redactar su conclusión;
- declarar el nombre de su compañero y los roles asumidos.

No adjuntes contraseñas, archivos del sistema ni una copia completa de los logs.

## Pauta de 24 puntos

| Criterio | Puntaje | Se obtiene completo cuando |
| --- | ---: | --- |
| A. Línea base | 3 | `linea_base.csv` completo y las capturas muestran el aislamiento y UFW inactivo. |
| B. Diseño AAA y política | 5 | `matriz_aaa.csv` y el diseño de `politica_firewall.csv` completos, más las dos preguntas. |
| C. Pruebas AAA | 4 | AAA-01, AAA-02 y AAA-03 ejecutadas, con captura de los permitidos y del denegado. |
| D. Firewall | 4 | Las tres reglas aplicadas, `ufw status numbered` capturado y el CSV completo. |
| E. Pruebas FW | 4 | FW-01 y FW-02 ejecutadas y la diferencia entre ambas descrita. |
| F. Registros | 2 | Los extractos de SSH y del bloqueo, vinculados con sus pruebas. |
| G. Conclusión y reversión | 2 | Reversión ejecutada y comprobada, y conclusión con una limitación nombrada. |
| **Total** | **24** |  |

Cada criterio se corresponde con una etapa. Si completas las siete etapas con sus evidencias, tienes el puntaje: no hay nada oculto ni ninguna dificultad añadida fuera de lo que dice esta guía.