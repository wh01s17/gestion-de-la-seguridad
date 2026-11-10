---
title: "Escenario BIA - DELTA LOGÍSTICA SPA"
course: INF44 - Gestión de la Seguridad
lesson: "14"
---

# Escenario - DELTA LOGÍSTICA SPA (empresa ficticia), después del corte

En la lección 13, DELTA LOGÍSTICA SPA enfrentó una falla eléctrica de seis horas en su sede. La revisión posterior dejó tres datos:

- La energía volvió a las 15:20, pero el ERP recién estuvo operativo a las 19:10. Durante todo ese tiempo, la tienda en línea siguió vendiendo **sin stock confirmado** y hubo que anular pedidos.
- El 31-10, TI hizo por primera vez una **prueba de restauración** del ERP desde el respaldo del NAS: tardó **6 horas en restaurar y 1 hora en validar**. El respaldo es completo y diario, a las 23:00.
- Los MTPD que se usaron en el plan (4, 8 y 24 horas) eran **estimaciones** de TI, no valores acordados con los dueños de los procesos.

La gerencia pide ahora un **BIA simplificado** de los tres procesos críticos, objetivos de recuperación validados y una propuesta de estrategias para el presupuesto 2027.

## Encargo de la gerencia

1. Valorar el impacto en el tiempo de **venta en línea**, **despacho y logística** y **facturación electrónica**, con los criterios aprobados (abajo).
2. Fijar MTPD, RTO y RPO para cada proceso y compararlos con la capacidad actual.
3. Proponer estrategias para cerrar las brechas principales con un presupuesto máximo de **$ 50 millones al año**.
4. Declarar qué brecha queda abierta, si alguna, para que la dirección la acepte o la rechace.

## Criterios de impacto aprobados por la gerencia

| Nivel | Pérdida acumulada | Clientes y contratos | Legal y regulatorio | Operación |
| --- | --- | --- | --- | --- |
| Bajo | Menos de $ 2 M | Demoras sin reclamos | Sin efecto | Se pone al día en el mismo turno |
| Medio | $ 2 a 10 M | Reclamos aislados | Atraso subsanable sin multa | Se pone al día en el día |
| Alto | $ 10 a 30 M | Multa o incumplimiento de contrato o SLA | Multa posible o reclamo ante la autoridad | Más de un día para ponerse al día |
| Crítico | Más de $ 30 M | Término de un contrato mayorista o daño público a la marca | Infracción o sanción cierta | El atraso no se recupera en la semana |

- El nivel de cada horizonte es el **más alto** de las cuatro columnas (impacto dominante).
- La gerencia declara **inaceptable** el nivel Crítico. El **MTPD** es el primer horizonte en que el proceso llega a Crítico.

## Política de continuidad (extracto)

- El **RTO** debe dejar al menos **1 hora de margen** antes del MTPD para detectar, declarar el desastre y validar.
- Un recurso que usan varios procesos (por ejemplo, el ERP) debe recuperarse a tiempo para **el más exigente** de ellos, tanto en tiempo como en datos.
- Los objetivos los **valida el dueño del proceso**; TI mide la capacidad y propone estrategias.

## Tolerancia de pérdida de datos declarada por los dueños

| Proceso | Qué datos se pierden si se restaura un respaldo antiguo | Tolerancia |
| --- | --- | --- |
| Venta en línea | Los pedidos quedan en la tienda cloud, pero los **movimientos de stock** del ERP se pierden. Si faltan más de 1 hora, hay que recontar la bodega (dos días). | 1 hora |
| Despacho y logística | Las guías de despacho del ERP pueden reconstruirse desde los correos de los transportistas. | 4 horas |
| Facturación electrónica | Las facturas enviadas se recuperan desde el servicio tributario; las no enviadas se vuelven a emitir. | 8 horas |

## Escenario de referencia para medir la capacidad

**Pérdida de los servidores de la sede** (falla grave o *ransomware*), con el NAS de respaldo disponible. La tienda cloud y el servicio tributario siguen funcionando. Para volver a operar hay que recuperar la identidad y luego el ERP; los recursos de una misma cadena se recuperan **uno después del otro**.

## Fuentes del material

- `impactos.csv`: consecuencias de cada proceso a las 2, 4, 8 y 24 horas, en período normal y, para facturación, en cierre de mes.
- `capacidad.csv`: recursos, de qué dependen, cuánto tardan en recuperarse, si se probó y cuántos datos se pueden perder.
- `estrategias.csv`: opciones evaluadas por TI, con el RTO y el RPO que logran, el costo anual y sus supuestos.

Los datos son sintéticos. No hay una única respuesta correcta: se valoran objetivos coherentes con el impacto, una brecha medida contra capacidad comprobada y una estrategia que cierre esa brecha dentro del presupuesto.
