---
title: "Práctica guiada 10 - Valorar y tratar riesgos del negocio"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "10"
author: Jordy
start: 2026-10-13
end: 2026-10-19
created_at: 2026-10-11
aliases:
  - "Práctica guiada 10 - Valorar y tratar riesgos del negocio"
---

# Actividad Lección 10 - Valorar y tratar riesgos del negocio

- **Modalidad:** trabajo en parejas.
- **Duración:** 60 minutos de trabajo y 30 minutos de cierre guiado.
- **Caso:** PACÍFICO RETAIL, valoración y tratamiento de riesgos para 2027.
- **Carácter:** formativo, sin calificación.
- **Producto:** una copia de este documento guardada como `matriz-riesgos-equipo.md`.

## Pregunta del caso

PACÍFICO RETAIL ya identificó seis escenarios, pero tiene **22 millones de pesos** para seguridad durante 2027 y debe decidir antes del congelamiento de cambios del **25 de octubre**.

> ¿Qué riesgos requieren atención primero, qué tratamiento es verificable y qué incertidumbre impide decidir solo con el puntaje?

No se agregan escenarios nuevos. Se valoran R-01 a R-06 de la lección 09 y se preparan acciones para H-01 a H-03. R (riesgo) y H (hallazgo) identifican los registros. H-02 y H-03 continúan pendientes de validación: una duda no se convierte en vulnerabilidad confirmada por asignarle un número.

Primero estimarán el riesgo sin controles, luego revisarán si los controles actuales funcionan, ordenarán prioridades y finalmente propondrán acciones verificables. El puntaje ayuda a comparar, pero no decide por sí solo.

## Estado del caso

### Escala acordada en la lección 07

| Nivel | Probabilidad en 24 meses                                        | Impacto financiero               |
| ----: | --------------------------------------------------------------- | -------------------------------- |
|     1 | Cero ocurrencias y la condición necesaria no está presente      | Menos de 5 millones de pesos     |
|     2 | Cero ocurrencias, pero existe una condición que lo hace posible | Desde 5 y menos de 20 millones   |
|     3 | Una ocurrencia                                                  | Desde 20 y menos de 50 millones  |
|     4 | Entre dos y nueve ocurrencias                                   | Desde 50 y menos de 150 millones |
|     5 | Diez o más ocurrencias, o la condición está activa              | Desde 150 millones               |

Para esta matriz académica: **nivel = probabilidad × impacto**. Conserven siempre el par `P × I`, con P (probabilidad) e I (impacto): dos riesgos con producto 10 pueden representar situaciones distintas.

En esta actividad, «la condición está activa» significa que el escenario está ocurriendo al momento de valorar; una vulnerabilidad existente sin ocurrencia observada se contrasta primero con el descriptor del nivel 2. Si no pueden distinguirlo con los datos disponibles, declaren el supuesto y la confianza.

| Producto | Banda de visualización |
| ---: | --- |
| 1 a 4 | Bajo |
| 5 a 9 | Moderado |
| 10 a 16 | Alto |
| 17 a 25 | Crítico |

Las bandas ayudan a visualizar; **no autorizan aceptación** ni reemplazan tolerancias, requisitos o juicio. No mezclen esta escala con CVSS (sistema común de puntuación de vulnerabilidades), porcentajes o etiquetas de otra fuente.

### Tolerancias, restricciones y datos para valorar

- Ninguna interrupción de la venta en línea puede superar 30 minutos durante noviembre. La Gerencia general decide sobre esa tolerancia.
- La protección de datos personales es un requisito mínimo, no un riesgo que pueda aceptarse solo porque el puntaje sea bajo.
- Los cambios en producción se congelan del 25 de octubre al 5 de diciembre. Una excepción requiere autorización.
- H-01 está confirmado respecto de exposición y uso de una sola contraseña; no demuestra un acceso indebido.
- H-02 requiere confirmar si `203.0.113.28` todavía pertenece a la empresa.
- H-03 requiere verificar documentalmente si el parche de CartPlus quedó aplicado.
- Las estimaciones siguientes fueron entregadas por Gerencia y Finanzas solo para el ejercicio. Representan la consecuencia si el escenario ocurre, no su probabilidad.

| Riesgo | Antecedente de frecuencia o condición | Consecuencia financiera de referencia |
| --- | --- | ---: |
| R-01 Cuenta de una persona desvinculada | Tres casos en los últimos 24 meses; en uno, la cuenta permaneció activa 47 días | 32 millones |
| R-02 Respaldo no restaurable | No hay fallas de restauración registradas porque nunca se ha probado | 180 millones |
| R-03 Acceso al panel con contraseña robada | No hay acceso indebido confirmado; hubo 3.400 intentos fallidos y no se revisan | 160 millones |
| R-04 Falla de CartPlus explotada | No hay explotación confirmada; depende de si el parche quedó aplicado | 220 millones |
| R-05 Caída de NUBEPAC | Una caída de 4 horas en 2025 y sin tiempo máximo contractual | 80 millones |
| R-06 Abuso de `svc_backup` | No hay abuso confirmado; la cuenta controla sitio y respaldos sin segundo factor | 190 millones |

## Paso 1 - Valorar el riesgo inherente

Obtengan P (probabilidad) desde la frecuencia o condición, confirmen I (impacto) con el monto, multipliquen `P × I` y asignen la banda. La confianza indica cuán sólida es la información, no cuán grave es el riesgo.

El inherente se estima **sin considerar controles**. Revisen el ejemplo R-01. El impacto y su evidencia ya están precargados porque se derivan directamente de los montos entregados; confirmen que corresponden al descriptor de la escala. Repartan R-02 a R-06 entre ambos integrantes, completen probabilidad, producto, banda y confianza, y luego revisen mutuamente las filas. En R-04 registren el valor como provisional.

| ID (identificador) | P | Evidencia para P | I | Evidencia para I | P × I | Banda | Confianza y dato faltante |
| --- | :---: | --- | :---: | --- | :---: | --- | --- |
| R-01 · ejemplo | 4 | Tres casos en 24 meses; uno permaneció activo 47 días | 3 | 32 millones se ubican entre 20 y 50 | 12 | Alto | Media; faltan privilegios conservados y otras cuentas afectadas |
| R-02 | [ ] | [Completar] | 5 | 180 millones es desde 150 | [ ] | [Completar] | [Completar] |
| R-03 | [ ] | [Completar] | 5 | 160 millones es desde 150 | [ ] | [Completar] | [Completar] |
| R-04 | [ ] | [Completar] | 5 | 220 millones es desde 150 | [ ] | [Completar] | [Completar] |
| R-05 | [ ] | [Completar] | 4 | 80 millones se ubican entre 50 y 150 | [ ] | [Completar] | [Completar] |
| R-06 | [ ] | [Completar] | 5 | 190 millones es desde 150 | [ ] | [Completar] | [Completar] |

**Punto de control:** los seis productos son aritméticamente correctos, pero ninguna justificación consiste solo en repetir el número.

## Paso 2 - Evaluar controles y residual actual

Determinen si el control existe, si su diseño podría reducir el riesgo y si hay evidencia de que realmente operó. Solo una operación demostrada permite justificar una reducción del residual actual.

**Diseño** responde si el control, tal como está pensado, podría reducir el escenario. **Operación** responde si existe evidencia de que funciona. El residual actual se estima con los controles que ya operan; una acción propuesta pertenece al residual esperado del paso 4.

R-01 muestra cómo separar diseño y operación: que exista un procedimiento no demuestra que reduzca el riesgo de manera sostenida. Mantengan el reparto anterior para R-02 a R-06 y, antes de priorizar, intercambien las filas para que la otra persona cuestione una reducción residual.

| ID | Control existente | Diseño | Evidencia de operación | Residual actual `P × I` | Confianza y razón |
| --- | --- | --- | --- | :---: | --- |
| R-01 · ejemplo | Cierre de cuentas al recibir aviso por correo | Parcial: depende de un aviso, sin plazo ni conciliación | Tres casos; una cuenta siguió activa 47 días y no hay revisión | `4 × 3 = 12` | Media; no se acredita una reducción sostenida |
| R-02 | Respaldo diario de NUBEPAC | [Completar] | [Completar] | [Completar] | [Completar] |
| R-03 | Contraseña del panel | [Completar] | [Completar] | [Completar] | [Completar] |
| R-04 | Parche declarado por TI (tecnologías de la información) | [Completar] | [Completar] | [Completar] | [Completar] |
| R-05 | Servicio y contrato de NUBEPAC | [Completar] | [Completar] | [Completar] | [Completar] |
| R-06 | Contraseña de la cuenta técnica | [Completar] | [Completar] | [Completar] | [Completar] |

**Punto de control:** no reduzcan R-04 por un parche todavía no verificado ni R-02 por una copia que nunca se ha restaurado.

## Paso 3 - Priorizar con juicio

Para resolver empates, revisen si el riesgo cruza una tolerancia o requisito, depende de un tercero, tiene una fecha límite o conserva información importante sin confirmar.

Ordenen tres riesgos para decisión. Resuelvan los empates considerando tolerancia, requisito, exposición, dependencia, incertidumbre y fecha límite; el producto es una entrada, no la decisión completa. Integren esos elementos en una razón breve, sin repetirlos en columnas separadas.

| Prioridad | Riesgo y residual actual | Razón contextual: tolerancia, requisito, dependencia o incertidumbre |
| :---: | --- | --- |
| 1 | [Completar] | [Completar] |
| 2 | [Completar] | [Completar] |
| 3 | [Completar] | [Completar] |

```text
Empate identificado: [Completar]

Por qué no se resolvió solo con el producto: [Completar]
```

## Paso 4 - Convertir hallazgos en acciones

Completen la fila de izquierda a derecha: estado conocido → acción → responsable y plazo → prueba de cierre → residual esperado después de verificar.

Completen las tres filas. El residual actual no baja por escribir un plan; el **residual esperado** es condicional a implementar y verificar la acción.

| Ficha y riesgo relacionado | Estado de entrada | Tipo de acción y control compensatorio | Responsable, propietario y plazo | Evidencia de cierre | Residual esperado o decisión condicionada |
| --- | --- | --- | --- | --- | --- |
| H-01 / R-03 | Confirmado: panel expuesto y solo contraseña | [Completar] | [Completar] | [Completar] | [Completar] |
| H-02 / riesgo por determinar | Pertenencia de la IP (protocolo de Internet) pendiente | [Completar] | [Completar] | [Completar] | [Completar] |
| H-03 / R-04 | Aplicación del parche pendiente | [Completar] | [Completar] | [Completar] | [Completar] |

Usen correctamente los tratamientos:

- **Evitar:** eliminar la actividad que origina el riesgo.
- **Mitigar:** reducir probabilidad o impacto mediante controles.
- **Transferir/compartir:** distribuir consecuencias mediante contrato o seguro; no elimina toda responsabilidad.
- **Aceptar:** decisión explícita del propietario con criterio y fecha de revisión.

## Paso 5 - Probar sensibilidad

Cambien solo P (probabilidad) o solo I (impacto), nunca ambos a la vez; recalculen y expliquen si la decisión cambia.

Elijan un riesgo empatado y cambien **un solo nivel** de P o I. Recalculen y expliquen si cambia la prioridad.

```text
Riesgo y valor original: [Completar]

Cambio y nuevo producto: [Completar]

¿Cambia la decisión? ¿Por qué?: [Completar]
```

## Cierre ejecutivo

El cierre debe seguir este orden: prioridad → acción → evidencia necesaria para cerrar → incertidumbre que debe escalarse.

Redacten un máximo de 80 palabras con la primera prioridad, el tratamiento propuesto, la evidencia necesaria para cerrar y una incertidumbre que debe escalarse.

> [Completar]

## Comprobación final

- [ ] Se comprendió el ejemplo R-01 y se valoraron R-02 a R-06 con la escala acordada.
- [ ] R-04 y los hallazgos pendientes conservan su incertidumbre.
- [ ] Se separó inherente, residual actual y residual esperado.
- [ ] Los empates se resolvieron con contexto y no solo con el producto.
- [ ] Cada acción tiene responsable, propietario, plazo y evidencia de cierre.
- [ ] La aceptación queda en la autoridad del propietario, no del implementador.
- [ ] La sensibilidad modifica una sola variable y explica si cambia la decisión.

Intercambien la matriz con otra pareja y revisen una fila: evidencia, cálculo, control y conclusión deben contar la misma historia. Corrijan una inconsistencia antes de cerrar.
