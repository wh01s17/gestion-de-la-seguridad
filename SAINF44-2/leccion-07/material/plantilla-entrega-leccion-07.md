# Contexto y criterios de riesgo - PACÍFICO RETAIL SPA

**Plantilla de entrega, Lección 07 - INF44.**

**Este es el único documento de contenido de la entrega.** Se presenta en formato Markdown junto con `entrega_equipo.sha256`.

Reemplace cada marcador de respuesta pendiente por su contenido y conserve los títulos tal como están. Si un dato necesario no aparece en el paquete, escriba `dato faltante` y regístrelo donde corresponda; no lo invente. En esta lección no se asignan puntajes de riesgo.

```text
Equipo: [ ]
Integrantes y roles:
  Coordinador: [ ]
  Registrador: [ ]
  Revisor: [ ]
Fecha: [ ]
```

## 1. Objetivo y alcance

```text
Objetivo del análisis (una oración, verificable): [ ]

Periodo cubierto: [ ]

Incluye:
  1. [ ]
  2. [ ]

Excluye:
  Qué queda fuera: [ ]
  Riesgo que introduce la exclusión: [ ]
  Quién lo cubre: [ ]

Quién solicita: Gerencia general (dato del caso).
Quién autoriza el alcance: [ ]
```

## 2. Contexto

Dos procesos críticos, tomados de `procesos-criticos.csv`.

| Proceso crítico | Objetivo que sostiene | Dependencia externa | Ventana en que importa | Razón de su criticidad |
| --- | --- | --- | --- | --- |
| [ ] | [ ] | [ ] | [ ] | [ ] |
| [ ] | [ ] | [ ] | [ ] | [ ] |

```text
Qué controla PACÍFICO RETAIL respecto del respaldo del sitio: [ ]

Qué controla NUBEPAC respecto del respaldo del sitio: [ ]
```

## 3. Partes interesadas

Una con mucho interés y ninguna autoridad; otra con autoridad sobre una decisión que le afecta de manera indirecta.

| Parte interesada | Qué espera | Qué decide realmente | Cómo se le comunica el resultado |
| --- | --- | --- | --- |
| [ ] | [ ] | [ ] | [ ] |
| [ ] | [ ] | [ ] | [ ] |

## 4. Escalas

Cada descriptor debe ser observable: una frecuencia, un monto, una duración o una condición verificable. Los niveles `1`, `3` y `5` citan un dato concreto del caso; los niveles `2` y `4` pueden indicar que interpolan entre los anteriores.

### 4.1 Probabilidad

| Nivel | Etiqueta | Descriptor observable | Referencia usada |
| ---: | --- | --- | --- |
| 1 | Muy baja | [ ] | [ ] |
| 2 | Baja | [ ] | Interpolación entre los niveles 1 y 3. |
| 3 | Media | [ ] | [ ] |
| 4 | Alta | [ ] | Interpolación entre los niveles 3 y 5. |
| 5 | Muy alta | [ ] | [ ] |

### 4.2 Impacto financiero

Los montos deben ser proporcionales a un ingreso anual de 18.000 millones de pesos.

| Nivel | Etiqueta | Descriptor observable | Referencia usada |
| ---: | --- | --- | --- |
| 1 | Muy bajo | [ ] | [ ] |
| 2 | Bajo | [ ] | Interpolación entre los niveles 1 y 3. |
| 3 | Moderado | [ ] | [ ] |
| 4 | Alto | [ ] | Interpolación entre los niveles 3 y 5. |
| 5 | Muy alto | [ ] | [ ] |

### 4.3 Comprobación de calibración

```text
Dato del caso que mejor calibró la probabilidad y por qué: [ ]

Monto que separa el impacto financiero 3 del 4 y por qué ese corte: [ ]
```

## 5. Tolerancias

### 5.1 Indisponibilidad del sitio en campaña

```text
Apetito declarado: [ ]
Umbral de tolerancia (valor medible, con unidad y periodo): [ ]
Indicador observable: [ ]
Quién acepta: [ ]
Criterio de escalamiento: [ ]
```

### 5.2 Retraso en analítica comercial

```text
Apetito declarado: [ ]
Umbral de tolerancia (valor medible, con unidad y periodo): [ ]
Indicador observable: [ ]
Quién acepta: [ ]
Criterio de escalamiento: [ ]
```

### 5.3 Dos distinciones obligatorias

```text
Cuál de los dos riesgos tiene menor tolerancia y por qué: [ ]

Un asunto del caso que es requisito mínimo y no apetito, y por qué: [ ]
```

## 6. Propiedad del riesgo

Los dos escenarios vienen redactados. No los reescriba ni los puntúe: complete solo los cuatro campos en blanco. Al menos uno de los dos debe tener propietario y responsable distintos.

### R-01

> Si una cuenta de una persona desvinculada permanece activa, entonces puede mantener acceso sin titular responsable y afectar el control de accesos.
> Proceso afectado: `PR-05`. Categoría: acceso. Dimensiones: operativa y legal.

```text
Propietario del riesgo: [ ]
Responsable interno del control: [ ]
Dato faltante: [ ]
Supuesto provisional: [ ]
```

### R-02

> Si el respaldo diario declarado por NUBEPAC no se puede restaurar, entonces la venta en línea puede permanecer interrumpida y afectar el objetivo de continuidad.
> Proceso afectado: `PR-07`. Categoría: continuidad y terceros. Dimensiones: operativa.

```text
Propietario del riesgo: [ ]
Responsable interno del control: [ ]
Dato faltante: [ ]
Supuesto provisional: [ ]
```

## 7. Revisión cruzada

```text
Equipo que revisó nuestra ficha: [ ]

Hallazgo recibido (criterio ambiguo o propietario sin autoridad): [ ]

Corrección que aplicamos en esta ficha: [ ]
```

## 8. Cierre individual

Cada integrante responde una pregunta en una o dos frases. Puede repetirse la pregunta elegida.

| Integrante | Pregunta elegida (1, 2 o 3) | Respuesta individual |
| --- | ---: | --- |
| [ ] | [ ] | [ ] |
| [ ] | [ ] | [ ] |
| [ ] | [ ] | [ ] |

## Ampliación

Solo después de cerrar todo lo anterior. Indique cuál realizó y desarróllela aquí.

```text
Ampliación realizada:

Desarrollo:
```

## Comprobación de entrega

- [ ] El objetivo es verificable y el periodo está declarado.
- [ ] La exclusión indica el riesgo que introduce y quién lo cubre.
- [ ] Los dos procesos críticos están vinculados a un objetivo y a una ventana de tiempo.
- [ ] Las diez filas de escalas tienen descriptor observable; los niveles `1`, `3` y `5` citan un dato del caso.
- [ ] Los montos son proporcionales al tamaño de la organización.
- [ ] Las dos tolerancias tienen umbral medible, indicador y autoridad de aceptación.
- [ ] Un requisito legal quedó declarado como mínimo y no como apetito.
- [ ] `R-01` y `R-02` tienen propietario, responsable interno del control, dato faltante y supuesto; al menos uno separa decisión y ejecución.
- [ ] No asignamos ningún puntaje de riesgo.
- [ ] Registramos el hallazgo recibido y la corrección aplicada.
- [ ] Cada integrante respondió una pregunta de cierre individual.
