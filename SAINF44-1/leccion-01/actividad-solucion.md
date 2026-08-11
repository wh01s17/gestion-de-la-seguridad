---
title: Solución - Interrumpir una cadena de ataque
tags:
  - nota
  - course
  - curso
  - docente
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "01"
author: Jordy
start: 2026-08-10
end: 2026-08-11
created_at: 2026-08-07 11:58
aliases:
  - Solución - Interrumpir una cadena de ataque
---
# Actividad - Interrumpir una cadena de ataque

**Duración:** 35 minutos. 
**Modalidad:** equipos de 3 integrantes. 
**Carácter:** formativo, sin calificación.

> **Recordatorio:** esta es la primera actividad del curso. No necesitas experiencia previa ni memorizar los nombres en inglés. Lo importante es relacionar cada respuesta con un hecho del caso y explicar cómo comprobarías que un control funciona.

## Caso: factura urgente en BAHÍA LOGÍSTICA

Un atacante recopila nombres y cargos de empleados en redes profesionales. Después registra un dominio parecido al de un proveedor y prepara una página falsa. Envía a Finanzas una “factura urgente” con un enlace a esa página. Un usuario entrega sus credenciales; horas después se inicia una sesión remota desde un país no habitual, aparece una herramienta de acceso remoto no autorizada y se descarga una base de datos de clientes. La organización conserva registros de correo, inicios de sesión, equipos y conexiones.

## Objetivo de la actividad

Ordenar los hechos del caso y proponer dos medidas sencillas para detener o detectar el ataque.

## Las siete fases en palabras simples

| Fase | Pregunta sencilla |
| --- | --- |
| Reconocimiento | ¿Qué información busca el atacante? |
| Armamentización o preparación | ¿Qué prepara para engañar o atacar? |
| Entrega | ¿Cómo llega el engaño o archivo a la organización? |
| Explotación | ¿Qué acción o debilidad le permite avanzar? |
| Instalación | ¿Qué deja instalado o habilitado? |
| Comando y control | ¿Cómo mantiene la comunicación o el acceso? |
| Acciones sobre objetivos | ¿Qué hace finalmente con los sistemas o datos? |

## Parte A - Relacionar los hechos

1. **Ejemplo guiado con el docente:** revisen la fase de entrega.
2. **Trabajo en equipo:** busquen en el caso un hecho para cada fase y escríbanlo con una frase corta.

| Fase                          | Hecho del caso                                                            |
| ----------------------------- | ------------------------------------------------------------------------- |
| Reconocimiento                | El atacante recopila nombres y cargos de empleados.                       |
| Armamentización o preparación | Registra un dominio parecido al del proveedor y prepara una página falsa. |
| Entrega - ejemplo             | Llega a Finanzas el correo con la factura urgente.                        |
| Explotación                   | Un usuario entrega sus credenciales en la página falsa.                   |
| Instalación                   | Aparece una herramienta de acceso remoto no autorizada.                   |
| Comando y control             | Se inicia una sesión remota desde un país no habitual.                    |
| Acciones sobre objetivos      | Se descarga la base de datos de clientes.                                 |

## Parte B - Elegir dos puntos de defensa

Un control **preventivo** intenta impedir una acción. Un control **detectivo** genera una alerta o permite descubrirla.

Elijan dos fases y propongan un control para cada una. Indiquen también cómo comprobarían que funciona.

| Fase                     | ¿Qué quieren proteger?        | ¿Qué control usarían?                                     | ¿Cómo sabrían que funciona?                                                      |
| ------------------------ | ----------------------------- | --------------------------------------------------------- | -------------------------------------------------------------------------------- |
| Entrega - ejemplo        | Correo y proceso de Finanzas. | Filtro de correo.                                         | Registro que indique si el mensaje fue bloqueado o permitido.                    |
| Explotación              | Cuenta de Finanzas.           | MFA para impedir el acceso solo con la contraseña robada. | Registro que muestre la solicitud de segunda verificación o el acceso rechazado. |
| Acciones sobre objetivos | Base de datos de clientes.    | Monitoreo de descargas para detectar volúmenes inusuales. | Alerta y registro de una descarga inusual.                                       |

Pueden utilizar: verificación de facturas, filtro de correo, MFA, antimalware/EDR, bloqueo de conexiones, mínimo privilegio o monitoreo de descargas.

## Cierre

Cada integrante completa individualmente:

> Intentaría detener el ataque en la fase de explotación mediante MFA; sabría que funciona al revisar un registro de acceso rechazado por falta de la segunda verificación.

La Kill Chain ayuda a ordenar el caso, aunque los ataques reales no siempre siguen todos los pasos en el mismo orden.
