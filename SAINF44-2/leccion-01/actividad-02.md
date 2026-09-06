---
title: "Actividad 02 - Auditar un plan de interrupción"
tags: [nota, course, curso]
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "01"
author: Jordy
start: 2026-08-10
end: 2026-08-11
created_at: 2026-08-12
aliases:
  - "Actividad 02 - Auditar un plan de interrupción"
---
# Actividad 02 - Auditar un plan de interrupción

**Duración:** 45 minutos. **Modalidad:** equipos de tres. **Carácter:** formativo, sin calificación.

## Caso: acceso a documentos en COSTA SALUD

Una persona recopila nombres del equipo de compras publicados en Internet. Registra un dominio similar al de un proveedor, prepara un portal falso y envía un correo de cotización. Una cuenta entrega sus credenciales. Luego se instala una herramienta remota, se mantiene una sesión con un servidor externo y se exportan documentos internos.

## Plan propuesto

| Medida | Fase donde fue ubicada | Evidencia propuesta |
| --- | --- | --- |
| MFA | Reconocimiento | “El sistema está encendido” |
| Filtro de correo | Entrega | Registro de bloqueo o permiso |
| EDR | Acciones sobre objetivos | Alerta de instalación o ejecución |
| Monitoreo de dominios | Instalación | Lista de equipos inventariados |
| DLP | Preparación | Alerta de exportación de documentos |

## Parte A - Auditar

1. Relacione cada hecho del caso con una fase de Cyber Kill Chain.
2. Identifique las medidas ubicadas en una fase poco coherente.
3. Reubique cada medida y corrija evidencias vagas o insuficientes.
4. Clasifique las medidas como preventivas, detectivas o ambas, justificando.

## Parte B - Tomar una decisión

El presupuesto permite implementar primero solo dos medidas.

1. Seleccione dos puntos de interrupción.
2. Indique qué hecho del caso reduce cada medida.
3. Defina una prueba sencilla de funcionamiento.
4. Declare qué riesgo permanece después de implementarlas.

## Cierre

Redacten una recomendación de cuatro líneas para la jefatura que incluya fase, control, evidencia y riesgo residual.
