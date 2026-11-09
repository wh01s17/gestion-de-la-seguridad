---
title: "Escenario DR - DELTA LOGÍSTICA SPA"
course: INF44 - Gestión de la Seguridad
lesson: "13"
---

# Escenario - DELTA LOGÍSTICA SPA (empresa ficticia)

DELTA LOGÍSTICA SPA distribuye productos para comercios de la región. Opera una tienda en línea alojada en la nube y una sede central donde funcionan el ERP, la integración con transportistas, el inventario de bodega y los archivos operativos. Existe un respaldo diario en un NAS local, pero **nunca se ha probado una restauración completa**.

## Línea de tiempo del evento

| Hora | Antecedente |
| --- | --- |
| 09:00 | Una falla eléctrica deja sin servicio la sede principal. |
| 09:05 | La tienda en línea (cloud) sigue respondiendo. |
| 09:10 | ERP, archivos e integración logística quedan fuera de servicio. |
| 09:15 | La UPS indica 20 minutos de autonomía restante: se agota a las 09:35. |
| 09:20 | El proveedor eléctrico estima seis horas adicionales de interrupción: la energía volvería cerca de las 15:20. |
| 09:25 | Se confirma que el respaldo diario existe, pero nunca se restauró por completo. |

## Restricciones y contexto

- **Temporada alta:** la venta en línea no debería interrumpirse más de 30 minutos en horario comercial.
- **Autonomía limitada:** la UPS cubre un apagado ordenado, no la operación continua. La decisión de apagar debe tomarse antes de las 09:35.
- **Sitio alterno:** existe una oficina secundaria con conectividad, pero sin servidores propios.
- **Modo manual:** solo algunos procesos lo admiten; revisen la columna `modo_manual` de `procesos.csv`.
- **Datos:** no hay evidencia de que los datos estén dañados; el respaldo existe, pero nunca se probó.
- **Personal:** parte del equipo de TI puede trabajar de forma remota.
- **Obligación:** la facturación electrónica tiene plazos regulatorios que no se suspenden por la contingencia.

## Fuentes del material

- `procesos.csv`: procesos del negocio, criticidad, MTPD estimado y sistemas de los que dependen.
- `dependencias.csv`: recursos y servicios, su ubicación, de qué dependen y qué respaldo tienen.

Los datos son sintéticos. El objetivo no es acertar un número, sino construir un plan defendible: priorizar por impacto y dependencia, hacer visibles los puntos únicos de falla y exigir validación antes de confiar en el respaldo.
