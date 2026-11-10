---
title: "Práctica guiada 14 - BIA, RTO, RPO y estrategia de recuperación"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA3 - Recuperación frente a desastres y respuesta a incidentes
lesson: "14"
author: Jordy
start: 2026-11-10
end: 2026-11-16
created_at: 2026-11-08
aliases:
  - "Práctica guiada 14 - BIA, RTO, RPO y estrategia de recuperación"
---

# Actividad Lección 14 - BIA, RTO, RPO y estrategia de recuperación

- **Modalidad:** equipos de tres.
- **Duración:** 75 minutos.
- **Caso:** `DELTA LOGÍSTICA SPA` (empresa ficticia), después de un corte eléctrico.
- **Material:** `material/escenario.md`, `material/impactos.csv`, `material/capacidad.csv`, `material/estrategias.csv`.
- **Entrega:** `plantilla-entrega-leccion-14.docx`, una por equipo, de dos páginas como máximo.
- **Carácter:** formativo, sin calificación.

Consulten [[guia-de-lectura-leccion-14|la guía de lectura]] cuando necesiten un concepto.

## El caso

DELTA LOGÍSTICA SPA tuvo un corte eléctrico de seis horas en su sede. La revisión posterior mostró dos cosas: el ERP tardó casi cuatro horas en volver después de que regresó la energía, y la primera prueba de restauración del respaldo tomó **siete horas**. Además, los MTPD de su plan de contingencia (4, 8 y 24 horas) eran estimaciones de TI, no valores acordados con los dueños de los procesos. La gerencia pide un **BIA simplificado** de tres procesos, objetivos de recuperación validados y estrategias para el presupuesto 2027, con un máximo de **$ 50 millones al año** (ver `material/escenario.md`).

> ¿Cuánto tiempo y cuántos datos puede perder cada proceso, cuánto se pierde hoy y qué conviene pagar para cerrar la diferencia?

Lean los archivos del material con columnas alineadas, en una terminal abierta en la carpeta de la lección, o ábranlos en una planilla:

```bash
column -s, -t < material/impactos.csv
column -s, -t < material/capacidad.csv
column -s, -t < material/estrategias.csv
```

Roles sugeridos: **coordinador** (ordena la discusión y el tiempo), **registrador** (escribe en la plantilla) y **validador** (revisa cada número contra el material y la política de continuidad).

## Parte 1. BIA: impacto en el tiempo y MTPD

Con los criterios del escenario, asignen un nivel (Bajo, Medio, Alto, Crítico) a cada horizonte de `impactos.csv`. El nivel es el **más alto** de las cuatro columnas. La fila de venta en línea viene resuelta como ejemplo.

| Proceso | 2 h | 4 h | 8 h | 24 h | Impacto dominante | MTPD |
| --- | --- | --- | --- | --- | --- | --- |
| Venta en línea | Alto | Crítico | Crítico | Crítico | Pérdida y daño a la marca | **4 h** |
| Despacho y logística | [ ] | [ ] | [ ] | [ ] | [Completar] | [ ] |
| Facturación (normal) | [ ] | [ ] | [ ] | [ ] | [Completar] | [ ] |
| Facturación (cierre de mes) | — | [ ] | [ ] | — | [Completar] | [ ] |

```text
En despacho, la pérdida a las 8 h es de solo $ 9 M. ¿Qué columna fija su nivel?
El MTPD de facturación cambia en el cierre de mes. ¿Cuál debe usar el BIA y por qué?
```

## Parte 2. Objetivos, dependencias y brechas

Fijen el **RTO** y el **RPO** de cada proceso. Usen la política de continuidad (margen de 1 hora antes del MTPD) y la tolerancia de datos de cada dueño. Luego calculen la **capacidad actual** con `capacidad.csv`: sumen los tiempos de la cadena de recursos que el proceso necesita.

| Proceso | MTPD | RTO objetivo | RPO objetivo | Capacidad actual (tiempo / pérdida de datos) | Brecha |
| --- | --- | --- | --- | --- | --- |
| Venta en línea (stock confirmado) | 4 h | [ ] | [ ] | [Cadena y suma] | [Completar] |
| Despacho y logística | [ ] | [ ] | [ ] | [Cadena y suma] | [Completar] |
| Facturación electrónica | [ ] | [ ] | [ ] | [Cadena y suma] | [Completar] |

```text
Los tres procesos dependen del ERP. ¿Qué RTO y qué RPO necesita el ERP para que los tres cumplan?
La tienda cloud se recupera en 15 minutos. ¿Por qué eso no cierra la brecha de venta en línea?
```

## Parte 3. Estrategia para cerrar las brechas

Con `estrategias.csv`, elijan la combinación que cierre las **dos brechas principales** de la Parte 2 sin superar los $ 50 M al año. Una brecha se cierra con capacidad (o con una alternativa que permita operar), no cambiando el número del objetivo.

| Brecha | Estrategia (id) | Valor que logra | Costo anual | Responsable | Prueba que demostrará que se cumple |
| --- | --- | --- | --- | --- | --- |
| [Completar] | [ ] | [Completar] | [ ] | [ ] | [Completar] |
| [Completar] | [ ] | [Completar] | [ ] | [ ] | [Completar] |
| [Opcional: un SPOF o una alternativa manual] | [ ] | [Completar] | [ ] | [ ] | [Completar] |

```text
Costo total: $     M (¿dentro de los $ 50 M?)
Brecha que queda abierta (o «ninguna») y quién debe aceptarla formalmente:
Una estrategia que descartaron y por qué:
```

## Cierre: recomendación a la gerencia

Escriban, en tres líneas como máximo, la recomendación que leería la gerencia: qué se recupera primero, qué se compra y qué riesgo queda.

```text
1.
2.
3.
```

Preguntas de cierre:

- Otro equipo eligió una estrategia distinta con el mismo presupuesto. ¿Cuál de las dos deja menos riesgo y cuál menos costo?
- Si la gerencia pidiera RPO cero para el ERP, ¿qué tendría que comprar y qué respondería?

## Comprobación final

- [ ] Cada horizonte tiene un nivel y el impacto dominante sale de la columna más alta, no solo de la pérdida.
- [ ] El MTPD de facturación considera el cierre de mes.
- [ ] Cada RTO deja al menos 1 hora de margen antes del MTPD y cada RPO respeta la tolerancia del dueño.
- [ ] La capacidad suma la cadena (identidad + ERP + integración) y usa el tiempo probado.
- [ ] El ERP recibe el objetivo del proceso más exigente.
- [ ] Cada brecha se cierra con capacidad o alternativa, no cambiando el número.
- [ ] La estrategia respeta el presupuesto e indica responsable y prueba.
- [ ] La brecha residual queda declarada con quién la acepta.
