---
title: "Práctica guiada 15 - Ejercicio de mesa, playbook y plan de mitigación"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA3 - Recuperación frente a desastres y respuesta a incidentes
lesson: "15"
author: Jordy
start: 2026-11-17
end: 2026-11-23
created_at: 2026-11-15
aliases:
  - "Práctica guiada 15 - Ejercicio de mesa, playbook y plan de mitigación"
---

# Actividad Lección 15 - Ejercicio de mesa, playbook y plan de mitigación

- **Modalidad:** parejas; una entrega por pareja.
- **Duración:** 90 minutos.
- **Caso:** `DELTA LOGÍSTICA SPA` (empresa ficticia), incidente de *ransomware*.
- **Material y entrega:** este documento contiene el escenario, las tres inyecciones, el registro y todas las tablas que deben completar. Entreguen una copia respondida por pareja.
- **Carácter:** formativo, sin calificación.

## El caso

DELTA LOGÍSTICA SPA terminó su BIA (lección 14), pero las estrategias aprobadas para 2027 todavía no se implementan. El jueves 12-11-2026 sufrió un *ransomware*. DELTA no tiene plan de respuesta: su único procedimiento dice que el usuario avisa a la mesa de ayuda y el jefe de TI «resuelve».

La gerencia organiza un **ejercicio de mesa** que recrea ese incidente para construir su primer playbook.

> ¿Quién debió decidir qué, en qué orden y en cuánto tiempo, qué tan lejos estuvo DELTA de eso y qué debe cambiar para la próxima vez?

### Datos del escenario

Las estrategias aprobadas para 2027 son una réplica del ERP y del directorio en la nube, respaldos incrementales cada hora más una copia diaria inmutable fuera de la sede, y un segundo enlace de Internet. **Aún no están implementadas.** La réplica puede copiar también el cifrado; una copia limpia necesita protección y verificación independientes.

| Proceso | MTPD | RTO | RPO |
| --- | ---: | ---: | ---: |
| Venta en línea con stock confirmado | 4 h | 3 h | 1 h |
| Despacho y logística | 8 h | 7 h | 4 h |
| Facturación electrónica | 24 h (8 h en cierre de mes) | 7 h | 8 h |

La tienda en la nube puede recibir pedidos sin la sede, pero no confirmar stock sin el ERP. Para recuperar el ERP desde el NAS se necesitan primero **2 h estimadas** para la identidad y luego **7 h probadas** para restaurar y validar el ERP. El NAS comparte sala y red con los servidores; guarda respaldos diarios de las 23:00. La integración con transportistas requiere una hora más tras recuperar el ERP.

DELTA no tiene plan de respuesta. Su único procedimiento dice: «El usuario avisa a la mesa de ayuda; esta informa al jefe de TI, quien resuelve y avisa a gerencia si lo considera necesario». El EDR genera alertas, pero nadie las revisa fuera de 08:00 a 18:00. Los transportistas externos usan cuentas VPN (`tr-rutasur`, `tr-norte` y otras) **sin MFA**. Hay gerente general, gerente comercial, jefe de TI y analista, encargada de bodega, contadora y asesor legal externo; no hay vocero designado. RETAIL SUR es un cliente mayorista clave.

Para decidir en I3: no se espera que determinen si DELTA está obligada a reportar; basta decidir quién lo evalúa y en qué plazo. Si la Ley 21.663 le aplica, la alerta temprana al CSIRT Nacional vence **3 horas desde que conoce** el incidente (guía, §7).

## Parte 1. Ejercicio de mesa: tres inyecciones

Lean **una inyección a la vez** y registren la decisión antes de pasar a la siguiente. Dedíquenle unos 6 minutos a cada una. Decidan **como si DELTA tuviera un buen plan**, cada rol desde su función. En «Quién decide» usen un cargo de la lista de personas clave; si DELTA no tiene ese rol (por ejemplo, coordinador o vocero), indiquen a qué cargo se lo asignan. No lean todavía la Parte 2.

**I1 · Jueves 12-11-2026, 07:40.** Bodega informa que el ERP no abre. En la carpeta compartida aparecen archivos `.dlt0ck` y `LEEME-RESCATE.txt`. El EDR muestra una alerta alta de las 02:14 en `SRV-ERP` por PowerShell codificado; nadie la ha revisado. La tienda sigue recibiendo pedidos. Decidan quién declara el incidente, qué hacen en los próximos 30 minutos y qué evitan hacer todavía.

**I2 · 08:30.** TI confirma archivos cifrados en `SRV-ERP`, `SRV-ARCHIVOS` y el NAS; el respaldo de anoche también está cifrado. La VPN muestra que `tr-rutasur` inició sesión el miércoles a las 23:52 desde `203.0.113.140`, sin MFA. El jefe de TI propone apagar todos los servidores y reinstalar. **Una persona defenderá apagar y reinstalar; la otra propondrá una alternativa. Acuerden una decisión y anoten el argumento que se impuso.** La tienda vende sin stock confirmado. Decidan cómo contener y preservar evidencia, qué cuentas y sesiones tratar, desde dónde se podría restaurar y quién define el modo de venta.

**I3 · 10:30.** RETAIL SUR reclama públicamente que sus pedidos no llegan. Una periodista pide una declaración. Los atacantes exigen 4 BTC en 72 horas y amenazan con publicar datos de clientes; la extracción de datos **no está confirmada**. El gerente comercial sugiere pagar. Decidan quién habla con el cliente y la prensa, quién decide sobre el rescate y qué debe evaluar asesoría legal.

| Inyección | Decisión principal (próximos 30 min) | Quién decide (cargo) | Evidencia que preservan | A quién comunican y qué |
| --- | --- | --- | --- | --- |
| I1 · 07:40 | [Completar] | [ ] | [Completar] | [Completar] |
| I2 · 08:30 | [Completar] | [ ] | [Completar] | [Completar] |
| I3 · 10:30 | [Completar] | [ ] | [Completar] | [Completar] |

```text
Algo que en I1 decidieron NO hacer todavía, y por qué:
En I2, el argumento que se impuso (apagar o no) y por qué:
En I2, ¿qué otras cuentas deshabilitarían además de tr-rutasur?:
En I3, la frase que diría el vocero a RETAIL SUR:
```

## Parte 2. Resultados: lo que DELTA hizo en realidad

**Lean el registro solo después de completar I1, I2 e I3.** Es la cronología de lo que DELTA hizo en realidad. Cuando una fila registra una acción, no den por confirmados pasos que no figuran en ella (por ejemplo, revocar sesiones VPN).

| Fila | Fecha y hora | Hecho observado |
| --- | --- | --- |
| R01 | Mié 11-11 23:52 | La cuenta VPN `tr-rutasur` inicia sesión desde `203.0.113.140`, sin MFA. |
| R02 | Jue 12-11 00:31 | Hay conexión de escritorio remoto desde la VPN a `SRV-ERP` con esa cuenta. |
| R03 | Jue 12-11 02:14 | El EDR genera alerta alta en `SRV-ERP`: PowerShell codificado. Nadie la revisa. |
| R04 | Jue 12-11 03:05 | Comienza el cifrado de `SRV-ERP`, `SRV-ARCHIVOS` y del NAS, incluido el respaldo de las 23:00. |
| R05 | Jue 12-11 07:40 | Bodega informa a mesa de ayuda que el ERP no abre y hay archivos `.dlt0ck`. |
| R06 | Jue 12-11 08:25 | El jefe de TI revisa la alerta y confirma ransomware; no declara incidente ni avisa a gerencia. |
| R07 | Jue 12-11 08:40 | TI apaga todos los servidores; no exporta registros ni captura memoria. |
| R08 | Jue 12-11 08:55 | La tienda continúa vendiendo sin stock confirmado. |
| R09 | Jue 12-11 10:30 | RETAIL SUR reclama en redes; gerencia se entera a las 10:45. |
| R10 | Jue 12-11 11:20 | El gerente general declara crisis y convoca al comité. |
| R11 | Jue 12-11 12:10 | Se deshabilita `tr-rutasur`; otras cuentas de transportistas siguen activas y sin MFA. No consta revocación de sesiones. |
| R12 | Jue 12-11 13:00 | El comité decide no pagar, con asesoría legal; denuncia a PDI a las 15:30. |
| R13 | Jue 12-11 13:40 | Aparece un USB no documentado con respaldo del martes 10-11 a las 23:00. |
| R14 | Jue 12-11 14:10 | La tienda pasa a modo catálogo, sin aceptar pedidos. |
| R15 | Jue 12-11 16:00 | Identidad operativa en un servidor nuevo. |
| R16 | Jue 12-11 23:10 | ERP restaurado desde el USB y validado por bodega y contabilidad. |
| R17 | Jue 12-11 23:20 | Se reanuda la venta con stock confirmado. |
| R18 | Vie 13-11 00:20 | Se reanuda el despacho con la integración de transportistas. |
| R19 | Vie 13-11 09:00 | Bodega y contabilidad comienzan a reingresar movimientos perdidos. |
| R20 | Lun 16-11 10:00 | TI da por cerrado el incidente sin informe ni revisión posterior. |
| R21 | Mar 17-11 02:40 | Hay 14 intentos **fallidos** con `tr-norte` desde `203.0.113.140`. No prueban nuevo ingreso, pero sí que persiste el intento y la exposición de cuentas similares. |

**Metas de respuesta para este ejercicio:** atender una alerta alta en ≤ 30 min desde su emisión y declarar un incidente de severidad alta en ≤ 30 min desde la detección. Son objetivos propuestos para evaluar la respuesta; DELTA todavía no los tenía escritos. La deshabilitación de `tr-rutasur` es solo una acción de contención: R11 no demuestra que se hayan revocado sesiones ni cerrado otros accesos.

Midan las **cuatro métricas pendientes** de la respuesta real. Indiquen siempre **desde** qué fila y **hasta** qué fila. La primera métrica viene resuelta.

| Métrica | Desde (fila y hora) | Hasta (fila y hora) | Resultado | Referencia | ¿Cumple? |
| --- | --- | --- | --- | --- | --- |
| Tiempo hasta detectar | R01 · mié 23:52 | R05 · jue 07:40 | **7 h 48 min** | El cifrado empezó a las 03:05 (R04): se detectó después del daño | No |
| Tiempo con la alerta sin atender | R03 · [ ] | [ ] | [ ] | Meta propuesta: ≤ 30 min | [ ] |
| Tiempo hasta declarar | R05 · [ ] | [ ] | [ ] | Meta propuesta: ≤ 30 min | [ ] |
| Tiempo hasta recuperar la venta con stock | R04 · [ ] | [ ] | [ ] | RTO 3 h · MTPD 4 h | [ ] |
| Pérdida de datos | [Fila y hora del último respaldo recuperable: la hora en que se hizo, no la del hallazgo] | R04 · [ ] | [ ] | RPO 1 h (venta) | [ ] |

Comparen el registro con sus decisiones de la Parte 1. Identifiquen **dos brechas prioritarias** de la respuesta: lo que DELTA hizo (o no hizo) distinto de lo que debió. Elijan brechas que permitan proponer acciones distintas en la Parte 4.

| Brecha | Evidencia (fila) | Consecuencia para el negocio o la investigación |
| --- | --- | --- |
| [Completar] | [ ] | [Completar] |
| [Completar] | [ ] | [Completar] |

## Parte 3. Playbook de *ransomware* de una página

Con las brechas a la vista, escriban el playbook que DELTA debió tener. Las filas de disparadores y de detección vienen como ejemplo. Usen frases breves, con el cargo que decide o ejecuta y la evidencia que se conserva cuando corresponda; cada fila indica lo que deben completar.

| Sección | Contenido |
| --- | --- |
| Disparadores | Archivos con extensión desconocida o nota de rescate; alerta alta del EDR por cifrado o PowerShell codificado; varios usuarios sin acceso a archivos a la vez. |
| Activación y severidad | [Quién declara, en cualquier horario, y a quién convoca] |
| Decisiones reservadas | [Quién decide: aislar servidores, detener o degradar la venta, comunicar públicamente, rescate] |
| Detección y análisis | Coordinador: confirmar archivos cifrados y nota de rescate, declarar severidad alta y abrir el registro de decisiones. Líder técnico: identificar equipos afectados y la cuenta usada. Evidencia: exportar registros de VPN, EDR y directorio con su hash antes de cualquier cambio. |
| Contención | [Dos acciones, con responsable y evidencia] |
| Erradicación | [Dos acciones] |
| Recuperación | [Orden de recuperación de L13-L14, desde dónde se restaura y quién valida] |
| Comunicación | [Personal, clientes clave, prensa, asesoría legal: quién y cada cuánto] |
| Criterios de cierre | [Al menos tres condiciones verificables] |

## Parte 4. Plan de mitigación y resumen del reporte

Conviertan **las dos brechas prioritarias** en dos acciones verificables, una por fila.

| Acción | Brecha que cierra | Responsable | Plazo y prioridad | Evidencia de cierre | Riesgo residual |
| --- | --- | --- | --- | --- | --- |
| [Completar] | [ ] | [ ] | [ ] | [Completar] | [Completar] |
| [Completar] | [ ] | [ ] | [ ] | [Completar] | [Completar] |

Escriban el **resumen ejecutivo** del reporte técnico, en cinco líneas como máximo, sin buscar culpables:

```text
1. Qué pasó:
2. Impacto medido:
3. Qué funcionó:
4. Qué no funcionó:
5. Qué se hará primero:
```

## Comprobación final

- [ ] Cada inyección tiene una decisión con un cargo responsable, no «el equipo».
- [ ] En I2 se aísla y se preserva evidencia antes de apagar o reinstalar, y quedó anotado el argumento que se impuso.
- [ ] Las cuatro métricas pendientes indican fila de inicio y de término, y se comparan con una referencia.
- [ ] La recuperación se compara con el RTO y el MTPD; la pérdida de datos, con el RPO.
- [ ] Las dos brechas prioritarias citan filas del registro.
- [ ] El playbook define quién declara, las decisiones reservadas y criterios de cierre verificables.
- [ ] Las dos acciones de mitigación tienen responsable, plazo, evidencia de cierre y riesgo residual.
- [ ] El resumen no culpa a personas.
