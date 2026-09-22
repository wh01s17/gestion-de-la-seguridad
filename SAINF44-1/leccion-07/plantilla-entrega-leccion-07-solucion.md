# Contexto y criterios de riesgo - PACÍFICO RETAIL SPA

**Plantilla de entrega, Lección 07 - INF44.**

**Este es el único documento de contenido de la entrega.** Se presenta en formato Markdown junto con `entrega_equipo.sha256`.

Reemplace cada marcador de respuesta pendiente por su contenido y conserve los títulos tal como están. Si un dato necesario no aparece en el paquete, escriba `dato faltante` y regístrelo donde corresponda; no lo invente. En esta lección no se asignan puntajes de riesgo.

```text
Equipo: 1
Integrantes y roles:
  Coordinador: Estudiante A
  Registrador: Estudiante B
  Revisor: Estudiante C
Fecha: 21-09-2026
```

## 1. Objetivo y alcance

```text
Objetivo del análisis (una oración, verificable): Establecer los criterios y propietarios con que se priorizarán los riesgos que puedan interrumpir la venta en línea o exponer datos personales de clientes durante la campaña de noviembre de 2026.

Periodo cubierto: 1 de octubre al 15 de diciembre de 2026.

Incluye:
  1. Venta en línea (PR-01) y respaldo y restauración (PR-07), con sus dependencias NUBEPAC y PAGOSUR.
  2. Gestión de cuentas de usuario (PR-05).

Excluye:
  Qué queda fuera: Analítica comercial (PR-06).
  Riesgo que introduce la exclusión: No se analiza el retraso ni la exposición de la copia de la base de clientes usada para informes.
  Quién lo cubre: Jefatura de tecnología.

Quién solicita: Gerencia general (dato del caso).
Quién autoriza el alcance: Gerencia general.
```

## 2. Contexto

Dos procesos críticos, tomados de `procesos-criticos.csv`.

| Proceso crítico | Objetivo que sostiene | Dependencia externa | Ventana en que importa | Razón de su criticidad |
| --- | --- | --- | --- | --- |
| PR-01 Venta en línea | Aumentar 20 % la venta en línea y sostener la campaña de noviembre sin interrupciones mayores | NUBEPAC y PAGOSUR | 1 al 30 de noviembre | Concentra el 31 % del ingreso en línea y el ingreso perdido en campaña no se recupera (EH-01) |
| PR-07 Respaldo y restauración | Sostener la campaña de noviembre sin interrupciones mayores | NUBEPAC | Todo el año | Es la única vía para recuperar el sitio y su restauración no ha sido probada |

```text
Qué controla PACÍFICO RETAIL respecto del respaldo del sitio: Qué exige por contrato, si verifica una restauración y la responsabilidad frente a sus clientes.

Qué controla NUBEPAC respecto del respaldo del sitio: La infraestructura, la ejecución del respaldo diario y su retención.
```

## 3. Partes interesadas

Una con mucho interés y ninguna autoridad; otra con autoridad sobre una decisión que le afecta de manera indirecta.

| Parte interesada | Qué espera | Qué decide realmente | Cómo se le comunica el resultado |
| --- | --- | --- | --- |
| PI-08 Clientes con cuenta registrada | Que sus datos no se expongan y poder comprar | Nada | Resumen de efectos, medidas y canales de consulta |
| PI-06 Recursos humanos | Que las bajas se procesen a tiempo | Altas y bajas de personal | Estado periódico de cuentas pendientes de desactivar y escalamiento de incumplimientos |

## 4. Escalas

Cada descriptor debe ser observable: una frecuencia, un monto, una duración o una condición verificable. Los niveles `1`, `3` y `5` citan un dato concreto del caso; los niveles `2` y `4` pueden indicar que interpolan entre los anteriores.

### 4.1 Probabilidad

| Nivel | Etiqueta | Descriptor observable | Referencia usada |
| ---: | --- | --- | --- |
| 1 | Muy baja | Cero casos en 24 meses y la condición necesaria no está presente | Números de tarjeta en sistemas propios: la empresa nunca los almacena |
| 2 | Baja | Cero casos en 24 meses, pero existe una condición que lo hace posible | Interpolación entre los niveles 1 y 3. |
| 3 | Media | Un caso en 24 meses | EH-01, EH-02, EH-03 y EH-04 |
| 4 | Alta | Entre dos y nueve casos en 24 meses | Interpolación entre los niveles 3 y 5. |
| 5 | Muy alta | Diez o más casos en 24 meses | EH-06: 11 caídas breves del sitio |

### 4.2 Impacto financiero

Los montos deben ser proporcionales a un ingreso anual de 18.000 millones de pesos.

| Nivel | Etiqueta | Descriptor observable | Referencia usada |
| ---: | --- | --- | --- |
| 1 | Muy bajo | Menos de 5 millones de pesos | EH-03: sin pérdida directa |
| 2 | Bajo | Desde 5 y menos de 20 millones de pesos | Interpolación entre los niveles 1 y 3. |
| 3 | Moderado | Desde 20 y menos de 50 millones de pesos | EH-01: 38 millones de pesos |
| 4 | Alto | Desde 50 y menos de 150 millones de pesos | Interpolación entre los niveles 3 y 5. |
| 5 | Muy alto | Desde 150 millones de pesos | Casi dos días de venta en línea de campaña, de unos 85 millones cada uno |

### 4.3 Comprobación de calibración

```text
Dato del caso que mejor calibró la probabilidad y por qué: EH-06, porque sus 11 caídas breves frente a la única caída larga de EH-01 obligaron a medir la probabilidad por número de casos y no por gravedad.

Monto que separa el impacto financiero 3 del 4 y por qué ese corte: 50 millones de pesos, porque deja en el nivel 3 el hecho ya registrado de 38 millones y en el nivel 4 un incidente mayor, cercano a un día de venta de campaña.
```

## 5. Tolerancias

### 5.1 Indisponibilidad del sitio en campaña

```text
Apetito declarado: Muy bajo.
Umbral de tolerancia (valor medible, con unidad y periodo): Ninguna interrupción superior a 30 minutos entre el 1 y el 30 de noviembre.
Indicador observable: Registro de monitoreo de disponibilidad del sitio.
Quién acepta: Gerencia general.
Criterio de escalamiento: Toda interrupción superior a 30 minutos en campaña se informa de inmediato a la Gerencia general.
```

### 5.2 Retraso en analítica comercial

```text
Apetito declarado: Alto.
Umbral de tolerancia (valor medible, con unidad y periodo): Hasta cinco días hábiles de retraso al mes.
Indicador observable: Fecha de entrega del informe mensual.
Quién acepta: Jefatura de tecnología.
Criterio de escalamiento: Retraso superior a un mes o pérdida de datos históricos.
```

### 5.3 Dos distinciones obligatorias

```text
Cuál de los dos riesgos tiene menor tolerancia y por qué: La indisponibilidad del sitio en campaña, porque ese ingreso no se recupera y EH-01 lo demuestra.

Un asunto del caso que es requisito mínimo y no apetito, y por qué: La protección de datos personales de clientes bajo la Ley 19.628 y la Ley 21.719, porque no se puede aceptar un nivel de incumplimiento legal.
```

## 6. Propiedad del riesgo

Los dos escenarios vienen redactados. No los reescriba ni los puntúe: complete solo los cuatro campos en blanco. Al menos uno de los dos debe tener propietario y responsable distintos.

### R-01

> Si una cuenta de una persona desvinculada permanece activa, entonces puede mantener acceso sin titular responsable y afectar el control de accesos.
> Proceso afectado: `PR-05`. Categoría: acceso. Dimensiones: operativa y legal.

```text
Propietario del riesgo: Jefatura de recursos humanos.
Responsable interno del control: Jefatura de tecnología.
Dato faltante: Plazo comprometido entre la baja y la desactivación de la cuenta.
Supuesto provisional: No existe un plazo formal.
```

### R-02

> Si el respaldo diario declarado por NUBEPAC no se puede restaurar, entonces la venta en línea puede permanecer interrumpida y afectar el objetivo de continuidad.
> Proceso afectado: `PR-07`. Categoría: continuidad y terceros. Dimensiones: operativa.

```text
Propietario del riesgo: Jefatura de tecnología.
Responsable interno del control: Jefatura de tecnología, con NUBEPAC como ejecutor externo.
Dato faltante: Evidencia de una restauración probada.
Supuesto provisional: Solo existe la declaración del proveedor.
```

## 7. Revisión cruzada

```text
Equipo que revisó nuestra ficha: Equipo 2.

Hallazgo recibido (criterio ambiguo o propietario sin autoridad): El propietario de R-01 era el Encargado de seguridad, sin autoridad sobre las bajas de personal.

Corrección que aplicamos en esta ficha: Asignamos R-01 a la Jefatura de recursos humanos y mantuvimos a la Jefatura de tecnología como responsable del control.
```

## 8. Cierre individual

Cada integrante responde una pregunta en una o dos frases. Puede repetirse la pregunta elegida.

| Integrante | Pregunta elegida (1, 2 o 3) | Respuesta individual |
| --- | ---: | --- |
| Estudiante A | 1 | Cambia qué riesgos dejan de ser aceptables y requieren tratamiento; el análisis se recalibra, no se rehace. |
| Estudiante B | 2 | Porque la organización no tiene facultad para decidir incumplir la ley; solo puede decidir cómo cumplirla. |
| Estudiante C | 3 | El costo por hora de indisponibilidad del sitio en la campaña de 2026. |

## Ampliación

Solo después de cerrar todo lo anterior. Indique cuál realizó y desarróllela aquí.

```text
Ampliación realizada: Tolerancia de fraude en pagos.

Desarrollo:
Apetito declarado: Bajo.
Umbral de tolerancia: Pérdida por fraude inferior al 0,1 % de la venta en línea mensual.
Indicador observable: Informe mensual de contracargos de PAGOSUR.
Quién acepta: Jefatura de tecnología.
Criterio de escalamiento: Dos meses consecutivos sobre el umbral.
```

