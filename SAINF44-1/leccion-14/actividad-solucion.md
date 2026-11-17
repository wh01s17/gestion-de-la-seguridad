---
title: "Solución - Práctica guiada 14 - BIA, RTO, RPO y estrategia de recuperación"
tags:
  - nota
  - course
  - curso
  - docente
  - reservado
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA3 - Recuperación frente a desastres y respuesta a incidentes
lesson: "14"
author: Jordy
start: 2026-11-10
end: 2026-11-16
created_at: 2026-11-08
aliases:
  - "Solución - Práctica guiada 14 - BIA, RTO, RPO y estrategia de recuperación"
---

# Solución - Actividad Lección 14

**Uso reservado para el equipo docente.**
**Actividad:** [[actividad|Práctica guiada 14]].
**Pauta:** [[pauta-docente|Pauta docente]].

Las respuestas pueden variar en su redacción y, en la Parte 3, en la estrategia elegida. Deben conservar estas decisiones:

- el nivel de cada horizonte sale de la columna más alta, no solo de la pérdida;
- el MTPD de facturación considera el cierre de mes;
- RTO con margen de 1 hora y RPO dentro de la tolerancia del dueño;
- la capacidad suma la cadena y usa el tiempo probado;
- el ERP toma el objetivo del proceso más exigente (venta);
- las brechas se cierran con capacidad o alternativa, dentro del presupuesto, y la brecha residual se declara.

## Parte 1. BIA

| Proceso | 2 h | 4 h | 8 h | 24 h | Impacto dominante | MTPD |
| --- | --- | --- | --- | --- | --- | --- |
| Venta en línea | Alto | Crítico | Crítico | Crítico | Pérdida ($ 31 M) y daño público a la marca | 4 h |
| Despacho y logística | Bajo | Medio | **Crítico** | Crítico | Clientes y contratos: RETAIL SUR puede terminar el contrato | **8 h** |
| Facturación (normal) | Bajo | Bajo | Medio | **Crítico** | Legal: infracción tributaria cierta | **24 h** |
| Facturación (cierre de mes) | — | Medio | **Crítico** | — | Pérdida ($ 35 M): el banco no anticipa las facturas | **8 h** |

Detalle de los horizontes que más se discuten:

- **Despacho 8 h (I07):** la pérdida es $ 9 M (Medio) y la operación es Alto, pero el término del contrato mayorista es **Crítico**. Es el ejemplo de impacto dominante no financiero.
- **Facturación normal 24 h (I12):** pérdida $ 12 M y multa contractual (Alto); la infracción cierta es **Crítico**.
- **Facturación cierre 8 h (I14):** pérdida $ 35 M (Crítico); el resto es Alto o Medio.

```text
Despacho a las 8 h: la columna de clientes y contratos (término del contrato con RETAIL SUR), no la pérdida.
MTPD de facturación: el BIA debe usar 8 h, el del período más exigente (cierre de mes), o registrar ambos valores y fijar el RTO para el cierre. Si el desastre cae en el cierre y el objetivo se fijó para 24 h, se llega a Crítico.
```

Los MTPD estimados en L13 (4, 8 y 24 h) se **confirman** para venta y despacho; facturación baja a 8 h en el cierre. Señalarlo: el BIA corrige una estimación.

## Parte 2. Objetivos, dependencias y brechas

| Proceso | MTPD | RTO | RPO | Capacidad actual | Brecha |
| --- | --- | --- | --- | --- | --- |
| Venta en línea (stock confirmado) | 4 h | ≤ 3 h | ≤ 1 h | Identidad 2 h + ERP 7 h = **9 h**; hasta 24 h de pérdida | 6 h en tiempo y 23 h en datos |
| Despacho y logística | 8 h | ≤ 7 h | ≤ 4 h | 2 + 7 + integración 1 = **10 h**; hasta 24 h | 3 h en tiempo y 20 h en datos |
| Facturación electrónica | 8 h (cierre) | ≤ 7 h | ≤ 8 h | 2 + 7 = **9 h**; hasta 24 h | 2 h en el cierre (en período normal no hay brecha de tiempo) y 16 h en datos |

Se aceptan RTO menores (por ejemplo, venta 2 h o despacho 6 h) si respetan el margen. No se acepta un RTO igual al MTPD ni un RPO mayor que la tolerancia del dueño.

**Precisiones que conviene valorar:**

- El tiempo de identidad (2 h) es **estimado**, no probado (`capacidad.csv`, C1). La capacidad real puede ser mayor. Un equipo que lo marca merece reconocimiento.
- El NAS está en la misma sala y red que los servidores (C7). El escenario de referencia supone que sobrevive; con un incendio o *ransomware* que lo alcance, la capacidad sería «no recuperable». Es un argumento para E1.

```text
Objetivo del ERP: la cadena identidad + ERP debe recuperarse en ≤ 3 h y perder ≤ 1 h de datos, porque es un recurso compartido y la venta (stock) es el proceso más exigente en ambos. Despacho y facturación quedan cubiertos con ese objetivo.
Tienda cloud en 15 min: la tienda responde, pero el proceso es «venta con stock confirmado» y el stock está en el ERP. La brecha está en la dependencia, no en la tienda. (Enlaza con la distinción «responde / se puede cumplir» de L13.)
```

## Parte 3. Estrategia

Hay dos combinaciones defendibles. Valorar la coherencia, no la elección.

### Opción A: cerrar las brechas (≈ $ 49 M)

| Brecha | Estrategia | Valor que logra | Costo | Responsable | Prueba |
| --- | --- | --- | --- | --- | --- |
| Tiempo del ERP (9 h frente a 3 h) | E2 | Identidad y ERP en 2 h: venta 2 h, despacho 3 h, facturación 2 h | 38 | Jefatura de TI ejecuta; dueños de proceso validan | Conmutación semestral midiendo tiempo y datos perdidos |
| Datos del ERP (24 h frente a 1 h) | E2 (RPO 15 min) + E1 | RPO 15 min; copia inmutable fuera de la sede | 6 | Jefatura de TI | Restauración trimestral desde la copia externa |
| SPOF del enlace | E4 | La réplica y el acceso a la nube no dependen de un solo proveedor | 4 | TI y proveedor | Corte controlado del enlace principal |

Total: 48 (49 si suman E7). Brecha residual: ninguna en objetivos; queda pendiente probar la conmutación y medir el tiempo real de identidad. E1 se justifica aunque E2 ya da RPO 15 min, porque **la réplica copia también el cifrado** de un *ransomware* y el NAS comparte sala con los servidores.

### Opción B: menor costo con brecha aceptada (≈ $ 27 M)

| Brecha | Estrategia | Valor que logra | Costo |
| --- | --- | --- | --- |
| Tiempo del ERP | E3 | 5 h: despacho 6 h ✓, facturación 5 h ✓, **venta 5 h ✗** | 16 |
| Datos del ERP | E1 | RPO 1 h ✓ para los tres | 6 |
| Facturación en el cierre | E7 | Facturación sin ERP a las 2 h | 1 |
| SPOF del enlace (opcional) | E4 | — | 4 |

Brecha residual: **venta en línea queda en 5 h frente a un RTO de 3 h**, e incluso supera su MTPD (4 h) por 1 hora. Debe declararse, escalarse y **aceptarse formalmente por la gerencia o la dirección comercial**, idealmente con un modo degradado (vender solo stock reservado o con aviso de plazo). Si un equipo elige B sin declarar esa brecha, la propuesta es incoherente.

### Estrategias que no corresponden

- **E6:** $ 95 M, supera el presupuesto; RPO cero no es necesario (la tolerancia más exigente es 1 h).
- **E5:** el generador atiende el incidente anterior, no el escenario de referencia (pérdida de servidores). Se acepta como tercera prioridad solo si queda presupuesto y se justifica por el escenario eléctrico.
- **E1 sola:** cierra la brecha de datos, pero no la de tiempo.
- **Cambiar el MTPD o el RTO para que calcen:** no cierra nada.

```text
Estrategia descartada (ejemplo): E6, porque cuesta casi el doble del presupuesto y ningún dueño necesita RPO cero.
```

## Cierre: recomendación a la gerencia (ejemplo, opción A)

```text
1. Recuperar primero identidad y ERP, porque de ellos dependen la venta con stock, el despacho y la facturación.
2. Contratar réplica del ERP en la nube (E2), copia inmutable fuera de la sede (E1) y enlace secundario (E4): $ 48 M al año.
3. Queda por probar la conmutación; hasta la primera prueba semestral, el objetivo de 3 h para la venta no está demostrado.
```

## Preguntas de cierre (orientación)

- **Dos estrategias con el mismo presupuesto:** A deja menos riesgo (cumple los tres RTO); B cuesta menos de la mitad, pero deja la venta sobre su MTPD. La decisión es de la gerencia, con la brecha a la vista.
- **RPO cero:** exige replicación síncrona (E6, $ 95 M) y dos centros de datos cercanos. La respuesta: ningún dueño lo necesita y supera el presupuesto; RPO de 15 minutos cumple la tolerancia más exigente.

## Señales de alerta para corregir

- Nivelar los horizontes solo por la pérdida en dinero.
- Usar 24 h como MTPD de facturación sin mencionar el cierre de mes.
- RTO igual o mayor que el MTPD; RPO mayor que la tolerancia del dueño.
- Tomar como capacidad solo los 7 h del ERP, sin sumar identidad e integración.
- Tratar los 2 h de identidad como probados.
- Fijar objetivos distintos para el ERP según cada proceso.
- Decir que la tienda cloud (15 min) resuelve la venta.
- Elegir E6 o E5 como solución de las brechas principales.
- Superar el presupuesto o no declarar la brecha residual.
- Cerrar una brecha cambiando el objetivo.
