# Criterios de riesgo acordados en la Lección 07 - PACÍFICO RETAIL SPA

Escala de referencia consolidada al cierre de la Lección 07. Todas las valoraciones de las lecciones 09 y 10 usan **esta** escala. Si un dato proviene de otra fuente, primero se expresa con estos descriptores; si no es posible, se declara `no convertible` y se indica qué dato falta.

## Probabilidad

Periodo de referencia: los últimos 24 meses registrados en `eventos-historicos.csv` del caso.

| Nivel | Etiqueta | Descriptor observable |
| ---: | --- | --- |
| 1 | Muy baja | Cero ocurrencias en 24 meses y la condición necesaria no está presente |
| 2 | Baja | Cero ocurrencias en 24 meses, pero existe una condición o dependencia que lo hace posible |
| 3 | Media | Un caso registrado en los últimos 24 meses |
| 4 | Alta | Entre dos y nueve casos registrados en los últimos 24 meses |
| 5 | Muy alta | Diez o más casos en los últimos 24 meses, o la condición está activa |

## Impacto financiero

Proporcional a un ingreso anual de 18.000 millones de pesos.

| Nivel | Etiqueta | Corte |
| ---: | --- | --- |
| 1 | Muy bajo | Menos de 5 millones |
| 2 | Bajo | Desde 5 y menos de 20 millones |
| 3 | Moderado | Desde 20 y menos de 50 millones |
| 4 | Alto | Desde 50 y menos de 150 millones |
| 5 | Muy alto | Desde 150 millones |

## Tolerancias acordadas

| Riesgo | Umbral | Acepta |
| --- | --- | --- |
| Indisponibilidad del sitio en campaña | Ninguna interrupción superior a 30 minutos entre el 1 y el 30 de noviembre | Gerencia general |
| Retraso en analítica comercial | Hasta cinco días hábiles de retraso al mes | Jefatura de tecnología |

La protección de datos personales y el compromiso de no almacenar datos de tarjeta en sistemas propios son **requisitos mínimos**, no apetito.

## Reglas de uso

1. Una sola escala para todo el análisis: no se promedian ni suman valores de escalas distintas.
2. Un valor externo se convierte leyendo su evidencia contra estos descriptores, no traduciendo su número.
3. Si falta el dato para convertir, se declara el dato faltante y su supuesto provisional.
4. En la Lección 08 no se asigna ningún nivel a los riesgos del caso: la valoración se hace en la Lección 10.
