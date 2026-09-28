# Estado consolidado después de la Lección 07 - PACÍFICO RETAIL SPA

Documento interno de continuidad para construir y revisar la actividad de la Lección 08. Si una sección del curso acordó decisiones distintas durante la Lección 07, el docente debe actualizar este archivo y el bloque equivalente de la actividad antes de distribuirlo.

## 1. Objetivo y alcance

| Elemento | Decisión consolidada |
| --- | --- |
| Objetivo | Establecer los criterios y propietarios con que se priorizarán los riesgos que puedan interrumpir la venta en línea o exponer datos personales durante la campaña. |
| Periodo | 1 de octubre al 15 de diciembre de 2026. |
| Incluye | Venta en línea (`PR-01`), respaldo y restauración (`PR-07`) y gestión de cuentas (`PR-05`), con las dependencias NUBEPAC y PAGOSUR. |
| Excluye | Analítica comercial (`PR-06`), locales y despacho. Deben incorporarse en ciclos posteriores. |
| Autoriza el alcance | Gerencia general. |

## 2. Capacidad y restricciones

- Nueve personas trabajan en tecnología.
- Una persona cumple funciones de seguridad a media jornada.
- El presupuesto de seguridad para 2027 es de 22 millones de pesos.
- La gerencia solicitó resultados en tres semanas.
- Existe congelamiento de cambios en producción entre el 25 de octubre y el 5 de diciembre.
- El contrato con NUBEPAC vence en marzo de 2027 y todavía no se ha renegociado.

## 3. Escala única

| Nivel | Probabilidad en 24 meses | Impacto financiero |
| ---: | --- | --- |
| 1 | Cero ocurrencias y la condición necesaria no está presente | Menos de 5 millones de pesos |
| 2 | Cero ocurrencias, pero existe una condición que lo hace posible | Desde 5 y menos de 20 millones |
| 3 | Una ocurrencia | Desde 20 y menos de 50 millones |
| 4 | Entre dos y nueve ocurrencias | Desde 50 y menos de 150 millones |
| 5 | Diez o más ocurrencias, o la condición está activa | Desde 150 millones |

No se promedian ni traducen directamente números de escalas distintas. Un dato externo se expresa contra estos descriptores; si falta evidencia, se declara `no convertible` y se registra el dato faltante.

## 4. Tolerancias y requisitos

| Asunto | Umbral o regla | Autoridad |
| --- | --- | --- |
| Indisponibilidad del sitio en campaña | Ninguna interrupción superior a 30 minutos entre el 1 y el 30 de noviembre | Gerencia general |
| Retraso de analítica comercial | Hasta cinco días hábiles al mes | Jefatura de tecnología |
| Protección de datos personales | Requisito mínimo; no se expresa como apetito al riesgo | Se escala según obligación aplicable |
| Datos de tarjeta fuera de sistemas propios | Requisito mínimo contractual | Gerencia general y jefatura de tecnología según la decisión |

## 5. Propiedad acordada

| Escenario | Propietario del riesgo | Responsable interno del control |
| --- | --- | --- |
| Cuenta de una persona desvinculada permanece activa | Jefatura de recursos humanos | Jefatura de tecnología |
| Respaldo declarado por NUBEPAC no se puede restaurar | Jefatura de tecnología | Jefatura de tecnología, con NUBEPAC como ejecutor externo |

## 6. Uso en la Lección 08

Este estado es la línea de partida. En la Lección 08 no se rediseñan escalas ni se vuelven a asignar propietarios: se selecciona un proceso rector, se acotan apoyos para evaluar y comunicar, y se bosqueja cómo mantener el ciclo.
