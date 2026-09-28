---
title: "Actividad Lección 08 - Mesa de selección metodológica"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "08"
author: Jordy
start: 2026-09-28
end: 2026-09-29
created_at: 2026-09-26
aliases:
  - "Actividad Lección 08 - Mesa de selección metodológica"
---

# Actividad Lección 08 - Mesa de selección metodológica

- **Modalidad:** equipos de tres, con los roles de la Lección 07.
- **Duración práctica:** 75 minutos desde que el paquete está copiado y verificado. El cierre individual se realiza después, durante los 15 minutos finales de clase.
- **Caso:** PR-2027-01 - PACÍFICO RETAIL SPA (ficticia), continuación de la Lección 07.
- **Entorno:** estación Linux del laboratorio, terminal local sin conexión de red.
- **Carácter:** formativo, sin calificación.
- **Producto:** una ficha Markdown y su hash SHA-256.

## Pregunta del caso

La Lección 07 fijó el alcance, las escalas, las tolerancias y los propietarios. La gerencia ahora pide decidir **cómo** se hará el trabajo de riesgo con una persona de seguridad a media jornada.

> ¿Qué proceso ordenará el ciclo completo, qué apoyo se usará para evaluar escenarios y cómo se comunicará el resultado?

Una guía de evaluación no cubre por sí sola el tratamiento, la aceptación y el seguimiento. No se valoran escenarios, no se asignan niveles y no se decide qué propuesta de tratamiento ejecutar primero: esas decisiones corresponden a las lecciones 09 y 10.

## Antes de empezar

| Rol | Responsabilidad |
| --- | --- |
| Coordinador | Mantiene el tiempo y el alcance. |
| Registrador | Edita la ficha única. |
| Revisor | Comprueba cada razón contra una ficha o dato del caso. |

Copien el material y verifiquen sus ocho archivos antes de editar:

~~~bash
mkdir -p ~/inf44/LAB-08
cp -a material/. ~/inf44/LAB-08/
cd ~/inf44/LAB-08
sha256sum -c manifest_entrega.sha256
~~~

Si aparece un FAILED, detengan el trabajo e informen al docente. Usen la guía de comandos para leer el paquete. Los antecedentes se consultan; solo se edita plantilla-entrega-leccion-08.md.

## Paso 1 - Necesidades de decisión

**Consulten:** `necesidades-de-decision.csv` y `fichas-referencias.md`. **Completan:** sección 1 de `plantilla-entrega-leccion-08.md`.

Para ND-01 a ND-06 registren:

1. tipo **A** (evaluación detallada), **B** (proceso continuo), **C** (comunicación de estado y brechas) o **R** (requisito mínimo);
2. referencia o proceso que mejor ayuda a responderla;
3. una razón breve apoyada en el dato de la fila.

Una obligación legal o contractual se incorpora como requisito del proceso. La evaluación ayuda a decidir cómo sostenerla.

**Listo cuando:** las seis necesidades tienen tipo y razón; ND-05 y ND-06 no se tratan como riesgos que puedan ignorarse.

## Paso 2 - Comparación aplicada

**Consulten:** `fichas-referencias.md` y `contexto-organizacional.md`. **Completan:** sección 2 de la ficha.

Comparen ISO/IEC 27005, NIST SP 800-30 y NIST CSF 2.0 en cuatro dimensiones:

- propósito y resultado principal;
- información de entrada que requiere;
- esfuerzo para PACÍFICO RETAIL;
- límite para este caso.

Al menos las filas de esfuerzo y límite deben citar un dato del caso; «es más conocido» no justifica una elección.

**Listo cuando:** el cuadro permite distinguir el proceso completo, la evaluación de escenarios y la comunicación mediante perfiles.

## Paso 3 - Selección fundamentada

**Consulten:** `fichas-referencias.md`, `contexto-organizacional.md` y `criterios-de-riesgo-l07.md`. **Completan:** sección 3 de la ficha.

1. Elijan un **proceso rector del ciclo completo** y justifíquenlo con dos datos del caso. Un ciclo completo incluye tratamiento, aceptación y seguimiento.
2. Indiquen qué referencia apoyará la evaluación de escenarios y cuál, si se necesita, apoyará la comunicación. Precisen qué parte usarán de cada una.
3. Declaren la escala única acordada en la Lección 07, que está en `criterios-de-riesgo-l07.md`, quién coordina el ciclo y una limitación de su propuesta.

Se admite un proceso simplificado de ISO/IEC 27005. Si eligen SP 800-30 para evaluar, nombren aparte el proceso que gobierna las etapas que esa guía no cubre.

**Listo cuando:** otra persona sabe qué referencia ordena el ciclo y cuál cumple cada función de apoyo.

## Paso 4 - Bosquejo del ciclo

**Consulten:** la sección 3 de su ficha y `contexto-organizacional.md`, para identificar los hechos que obligan a revisar el ciclo. **Completan:** sección 4 de la ficha.

Completen las siete etapas ya nombradas en la ficha. Para cada una escriban **un artefacto verificable** y **un hecho o frecuencia que obligue a revisarlo**. No diseñen todavía la matriz ni calculen niveles.

La Lección 09 construye inventario y escenarios; la 10 valora, prioriza y propone tratamiento; la 11 trabaja política y auditoría. La comunicación y la revisión acompañan todo el ciclo.

**Listo cuando:** el ciclo no termina en una matriz y contiene un disparador, como el cambio del contrato con NUBEPAC o un incidente que supere una tolerancia.

## Paso 5 - Recomendación y cierre del archivo

**Consulten:** las secciones 1 a 4 de su ficha y `contexto-organizacional.md`, sección «Solicitud recibida». **Completan:** sección 5 de la ficha y `entrega_equipo.sha256`.

Redacten una recomendación breve para la gerencia. Indiquen proceso rector, apoyos, escala única, primera entrega y límite del alcance de tres semanas. Eviten siglas sin explicar.

Comprueben visualmente las secciones 1 a 5 y generen un hash provisional:

~~~bash
sha256sum plantilla-entrega-leccion-08.md > entrega_equipo.sha256
sha256sum -c entrega_equipo.sha256
~~~

El ticket individual y la última casilla se completan durante el cierre; por eso aún habrá marcadores pendientes.

## Cierre individual

**Consulten:** las tres preguntas de la sección 6 de la ficha. **Completan:** sección 6, la comprobación de entrega y `entrega_equipo.sha256`.

Cada integrante responde **una** de las tres preguntas de la sección 6 de la ficha en una o dos frases. El registrador incorpora las respuestas, marca las casillas y ejecuta el control final:

~~~bash
grep -n '\[ \]' plantilla-entrega-leccion-08.md
sha256sum plantilla-entrega-leccion-08.md > entrega_equipo.sha256
sha256sum -c entrega_equipo.sha256
~~~

El primer comando debe quedar sin salida. El docente usará una fila de `evaluaciones-previas.csv` y otra de `propuestas-tratamiento.csv` para discutir por qué no se mezclan escalas y por qué siempre queda un riesgo residual; ese análisis detallado no forma parte del producto obligatorio.

## Si terminan antes

**Consulten:** `evaluaciones-previas.csv` y `criterios-de-riesgo-l07.md`, o bien `propuestas-tratamiento.csv`. **Completan:** sección «Ampliación opcional» de la ficha.

Elijan solo una ampliación, sin asignar niveles de riesgo:

- diagnosticar por qué las cuatro filas de `evaluaciones-previas.csv` no se comparan directamente con la escala común; o
- clasificar las cinco filas de `propuestas-tratamiento.csv` e indicar qué residual podría quedar, sin priorizar ni aceptar formalmente ninguna propuesta.

## Entrega

Entreguen plantilla-entrega-leccion-08.md y entrega_equipo.sha256. No conviertan el archivo a PDF después de generar su hash.
