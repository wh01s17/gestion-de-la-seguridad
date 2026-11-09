---
title: "Práctica guiada 13 - Estrategia de recuperación ante desastres"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA3 - Recuperación frente a desastres y respuesta a incidentes
lesson: "13"
author: Jordy
start: 2026-11-03
end: 2026-11-09
created_at: 2026-10-29
aliases:
  - "Práctica guiada 13 - Estrategia de recuperación ante desastres"
---

# Actividad Lección 13 - Estrategia de recuperación ante desastres

- **Modalidad:** equipos de tres.
- **Duración:** 30 minutos de activación, 60 minutos de práctica y 30 minutos de cierre.
- **Caso:** `DELTA LOGÍSTICA SPA` (empresa ficticia).
- **Material:** `material/escenario.md`, `material/procesos.csv`, `material/dependencias.csv`.
- **Entrega:** `plantilla-entrega-leccion-13.docx`, una por equipo, de dos páginas como máximo.
- **Carácter:** formativo, sin calificación.

Consulten [[guia-de-lectura-leccion-13|la guía de lectura]] cuando necesiten un concepto. No es necesario releerla completa en clase.

## El caso

DELTA LOGÍSTICA SPA sufre una **falla eléctrica prolongada** en su sede principal (ver `material/escenario.md`). La tienda en línea está en la nube y sigue respondiendo; el ERP, la integración con transportistas, el inventario y los archivos operan en la sede y quedan fuera de servicio. La UPS **se agota a las 09:35**. Existe respaldo diario, pero **nunca se probó una restauración completa**.

> ¿Cómo se convierte una interrupción en un plan que alguien pueda ejecutar, con prioridades defendibles, validación en cada paso y un retorno aprobado?

Lean los archivos del material con columnas alineadas:

```bash
column -s, -t < material/procesos.csv
column -s, -t < material/dependencias.csv
```

Roles sugeridos: **coordinador** (ordena la discusión y el tiempo), **registrador** (escribe en la plantilla) y **validador** (cuestiona supuestos y busca puntos únicos de falla).

Escriban frases breves: se valora la **justificación**, no completar casillas. Si una celda no cabe en una línea, prioricen el motivo sobre la descripción.

## Parte 1. Conceptos y prioridad del negocio

**Contingencia** es el marco general: el conjunto de planes con que una organización se prepara para una interrupción. Dentro de ese marco se distinguen estos cuatro conceptos. El respaldo no es un plan, sino un insumo.

| Concepto | Ejemplo en DELTA LOGÍSTICA (una línea) |
| --- | --- |
| Respuesta a incidentes | [Completar] |
| Continuidad del negocio | [Completar] |
| Recuperación ante desastres | [Completar] |
| Respaldo | [Completar] |

Con `procesos.csv`, elijan los **tres procesos que más importa restablecer** para el negocio. Revisen si admiten modo manual: un proceso con `modo_manual = No` no puede seguir con trabajo manual.

| Prioridad | Proceso | MTPD | ¿Admite modo manual? | ¿Por qué en esta posición? |
| ---: | --- | --- | --- | --- |
| 1 | [Completar] | [Completar] | [Completar] | [Completar] |
| 2 | [Completar] | [Completar] | [Completar] | [Completar] |
| 3 | [Completar] | [Completar] | [Completar] | [Completar] |

## Parte 2. Dependencias, puntos únicos de falla y orden técnico

Con `dependencias.csv`, dibujen en la plantilla un **mapa de dependencias** (cajas y flechas, a mano o en texto) desde la energía hasta los procesos. Marquen tres **puntos únicos de falla (SPOF)**: recursos de los que dependen muchos otros y que no tienen alternativa.

| SPOF | ¿Qué arrastra si cae? | ¿Qué debería decir el plan sobre él? |
| --- | --- | --- |
| [Completar] | [Completar] | [Completar] |
| [Completar] | [Completar] | [Completar] |
| [Completar] | [Completar] | [Completar] |

```text
Orden técnico de recuperación (de la base a las aplicaciones):

La venta en línea es la prioridad del negocio. ¿Por qué eso no significa recuperar primero la tienda?
Distingan "la tienda responde" de "las ventas se pueden cumplir":
```

## Parte 3. Plan de activación, recuperación y retorno

La plantilla sigue las tres fases que recomienda NIST SP 800-34 para un plan de contingencia: **activación y notificación**, **recuperación** y **reconstitución** (retorno a operación normal).

### Activación y notificación

| Elemento | Definición para DELTA LOGÍSTICA |
| --- | --- |
| Objetivo y alcance del plan | [Qué busca el plan y qué procesos y sistemas cubre, en una línea cada uno] |
| Quién declara el desastre (y suplente) | [Completar] |
| Criterios y plazo para declararlo | [Duración estimada, procesos críticos caídos, MTPD en riesgo, seguridad. La decisión debe tomarse antes de las 09:35] |
| Comunicación interna y externa | [Quién avisa, a quién y por qué canal. Incluyan qué prioridad no pueden garantizar con los recursos disponibles y a quién deben comunicarlo] |

### Recuperación

Completen una sola secuencia. Cada paso indica quién lo hace y qué se comprueba antes de avanzar.

|   # | Acción                                                                                                                             | Responsable | Cómo se valida / qué hacer si falla |
| --: | ---------------------------------------------------------------------------------------------------------------------------------- | ----------- | ----------------------------------- |
|   1 | Apagado ordenado de servidores críticos antes de las 09:35                                                                         | [Completar] | [Completar]                         |
|   2 | Activar continuidad **solo en los procesos que admiten alternativa**; informar qué queda detenido                                  | [Completar] | [Completar]                         |
|   3 | Restablecer energía, red e identidad                                                                                               | [Completar] | [Completar]                         |
|   4 | Comprobar la integridad de la base de datos del ERP. Si está íntegra, arranque normal; si no, restaurar desde una copia verificada | [Completar] | [Completar]                         |
|   5 | Levantar ERP e integraciones, sincronizar el stock y reconciliar lo registrado en modo degradado                                   | [Completar] | [Completar]                         |

### Reconstitución

```text
Quién aprueba volver a operación normal y con qué pruebas:

Dos pruebas que deben hacerse DESPUÉS de esta interrupción para confiar en el plan:
1.
2.
```

## Cierre: escenario alternativo

Preguntas de cierre:

- Si la causa hubiera sido un *ransomware* y no un corte eléctrico, ¿qué cambia en el plan? Piensen en respuesta a incidentes, en la elección de la copia y en el paso 4.
- ¿Qué secciones de su plantilla corresponden a cada fase de NIST SP 800-34 y cuál quedó más débil?

## Comprobación final

- [ ] Los cuatro conceptos están ubicados en el caso y el respaldo aparece como insumo, no como plan.
- [ ] La prioridad cita MTPD y modo manual; despacho e inventario no se resuelven con trabajo manual.
- [ ] El mapa muestra dependencias y tres SPOF.
- [ ] El orden técnico recupera las bases antes que las aplicaciones y se distingue de la prioridad del negocio.
- [ ] La declaración tiene responsable, suplente, criterios y plazo (antes de las 09:35).
- [ ] La secuencia valida cada paso y solo restaura una copia si la integridad no se confirma.
- [ ] El retorno exige la aprobación del dueño del proceso y se identifican pruebas pendientes.
