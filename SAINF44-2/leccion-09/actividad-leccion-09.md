---
title: "Práctica guiada 09 - Identificar riesgos del negocio"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "09"
author: Jordy
start: 2026-10-05
end: 2026-10-06
created_at: 2026-10-04
aliases:
  - "Práctica guiada 09 - Identificar riesgos del negocio"
---

# Práctica guiada 09 - Identificar riesgos del negocio

**En parejas · 80 minutos · Sin nota ni entrega.**

Guarden este archivo como `registro-riesgos-equipo.md`: lo usarán en la lección 10. Hoy **no** se calcula probabilidad ni nivel de riesgo.

## El caso

PACÍFICO RETAIL (ficticia) vende por Internet. Solo se revisa la **venta en línea, los respaldos y las cuentas del personal**; las tiendas físicas, el despacho y los informes quedan **fuera de alcance**. La empresa no acepta que el sitio esté caído más de 30 minutos en noviembre ni que se expongan los datos de sus clientes. Entre el 25 de octubre y el 5 de diciembre no se pueden hacer cambios en los sistemas.

| ID | Activo | Qué es |
| --- | --- | --- |
| E01 | Venta en línea | La venta por el sitio web. |
| E02 | Base de datos de clientes | Datos personales de 214.000 clientes. |
| E03 | Sitio web con CartPlus | La tienda en Internet; CartPlus es el carrito, comprado a otra empresa. |
| E04 | Panel de administración | Página donde se cambian precios y promociones. |
| E05 | NUBEPAC | Empresa externa que aloja el sitio, la base de datos y los respaldos. |
| E06 | PAGOSUR | Empresa externa que cobra con tarjeta. |
| E07 | Respaldos | Copias diarias del sitio y de la base de datos. |
| E08 | Cuentas del personal | Usuarios con que los trabajadores entran a los sistemas. |

**Lo que contaron en las entrevistas:**

- **Recursos Humanos:** avisa por correo, sin plazo, cuando alguien se va; nadie revisa que la cuenta se cierre. Una siguió activa 47 días.
- **Comercial y Seguridad:** siete personas entran al panel desde sus casas solo con contraseña, sin segundo factor (código extra en el celular). Hubo 3.400 intentos fallidos en agosto y nadie los revisó.
- **Tecnología:** el 2 de septiembre instaló un parche (corrección) de CartPlus; el programa sigue diciendo versión 4.2.0. En marzo apagó el servidor de pruebas `staging`, pero no tiene un documento que confirme que NUBEPAC dejó de usar su dirección.
- **NUBEPAC:** respalda a diario, pero nunca ha probado recuperar un respaldo. El contrato no garantiza un tiempo máximo de caída. En 2025 el sitio estuvo caído 4 horas.
- **Configuración:** la cuenta técnica `svc_backup` entra sin segundo factor y controla el sitio y los respaldos en NUBEPAC.
- **Tiendas físicas:** en junio, un computador de caja fue bloqueado por ransomware (programa que cifra archivos).

**Reporte de fallas.** Un escáner (programa que busca fallas conocidas) revisó los sistemas sin atacarlos. El puntaje **CVSS** (0 a 10) mide la gravedad técnica de la falla, no el daño para esta empresa.

| Hallazgo | Qué encontró | Qué no comprobó |
| --- | --- | --- |
| H-01 · 5,3 | El panel (E04) se abre desde Internet y pide usuario y contraseña. | No intentó entrar. |
| H-02 · 7,4 | La dirección `203.0.113.28` usa TLS 1.0, un cifrado antiguo; su certificado dice `staging`. | Si esa dirección todavía es de la empresa. |
| H-03 · 9,8 | El sitio dice usar CartPlus 4.2.0, versión con una falla que permite leer la base de datos y que hoy usan atacantes. | Si la falla sigue presente; solo leyó el número de versión. |

## Paso 1 - ¿Es un activo?

Un **activo** es algo valioso que la empresa protege: **AP** si es información o actividad del negocio, **AS** si es tecnología, servicio o personas que lo apoyan. Si no es activo, escriban **NA** y digan si es una **amenaza** (algo que podría pasar), una **vulnerabilidad** (una debilidad) o un **requisito** (una obligación).

Antes de escribir, clasifiquen oralmente E02 y E04 por turnos y justifiquen la diferencia.

| Elemento | Tipo y por qué |
| --- | --- |
| E01 Venta en línea · ejemplo | AP: es una actividad del negocio que la empresa necesita proteger. |
| E05 NUBEPAC | [Completar] |
| Phishing (correo falso para robar contraseñas) | [Completar] |
| Panel sin segundo factor | [Completar] |
| Obligación de proteger los datos de los clientes | [Completar] |

## Paso 2 - Ficha de un activo

Completen la ficha de E07. **Propietario:** cargo de la empresa que responde por el activo (no un proveedor). **Qué se pierde:** **C** si alguien no autorizado ve datos, **I** si los datos se cambian o dañan, **D** si no se pueden usar; agreguen qué le pasa al negocio.

| Activo | Propietario | Depende de | Qué se pierde si falla |
| --- | --- | --- | --- |
| E04 Panel · ejemplo | Gerencia comercial | E03 sitio, E05 NUBEPAC y cuentas del panel | I: cambios de precios sin permiso. |
| E07 Respaldos | [Completar] | [Completar] | [Completar] |

Al terminar, cambien quién escribe.

## Paso 3 - Escribir tres escenarios de riesgo

Un escenario sigue esta frase: **quién o qué** hace algo, **aprovechando una debilidad**, sobre **un activo**, y provoca **una consecuencia para el negocio**. En «Control» indiquen qué medida existe y qué prueba hay de que funciona; si no hay prueba, escriban «sin evidencia».

Usen: en **R-04**, H-03 y el parche (escriban «si el parche no quedó instalado»); en **R-05**, lo que dijo NUBEPAC (no hay atacante, es una falla); en **R-06**, la cuenta `svc_backup`. R-04 es provisional; H-03 sigue por validar.

| ID | Qué podría pasar y qué debilidad lo permite | Activo y consecuencia | Control y prueba | Propietario |
| --- | --- | --- | --- | --- |
| R-01 · ejemplo | Un exempleado usa su cuenta, que sigue activa porque nadie revisa los cierres. | Cuentas (E08): cambios sin permiso en el panel (E04) o en los datos (E02). | Cierre al recibir el aviso; sin evidencia de revisión. | Jefatura de Recursos Humanos |
| R-02 · ejemplo | Hay que recuperar un respaldo y falla, porque nunca se probó. | Respaldos (E07): pedidos perdidos y sitio caído más de 30 min. | Respaldo diario; sin evidencia de que se pueda recuperar. | Jefatura de tecnología |
| R-03 · ejemplo | Un atacante entra al panel con una contraseña robada, porque solo pide contraseña. | Panel (E04): precios alterados (E01) o datos expuestos (E02). | Contraseña; nadie revisa los 3.400 intentos. Sin evidencia. | Gerencia comercial |
| R-04 · CartPlus | [Completar] | [Completar] | [Completar] | [Completar] |
| R-05 · NUBEPAC | [Completar] | [Completar] | [Completar] | [Completar] |
| R-06 · svc_backup | [Completar] | [Completar] | [Completar] | [Completar] |

**¿Agregan el ransomware de la tienda física a este registro? Sí o no, y por qué:** [Completar]

## Paso 4 - Revisar dos hallazgos sin tocar los sistemas

Un hallazgo es una alerta, no una prueba. Elijan un estado: **confirmado** (hay pruebas), **por validar** (queda una duda) o **fuera de alcance** (hay evidencia de que el activo queda fuera del alcance definido; no basta con que falte en el inventario). Propongan cómo resolver la duda pidiendo un documento o preguntando al responsable, nunca atacando el sistema.

| Hallazgo | Qué demuestra y qué no | Estado | Cómo confirmarlo sin tocar el sistema |
| --- | --- | --- | --- |
| H-01 · ejemplo | El panel se abre desde Internet y Comercial dijo que solo pide contraseña. No demuestra que alguien haya entrado. | Confirmado (R-03). | Revisar con Tecnología la configuración y el registro de entradas. |
| H-02 | [Completar] | [Completar] | [Completar] |
| H-03 | [Completar] | [Completar] | [Completar] |

## Cierre

Comentamos por qué un 9,8 no basta para decir que H-03 es el mayor riesgo. Otra pareja revisa **un escenario y una validación**: comprueba las cinco piezas del escenario, la evidencia y la duda pendiente del hallazgo. Corrijan lo necesario. Guarden el archivo, cópienlo a su pendrive o al aula virtual y abran la copia.
