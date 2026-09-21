---
title: "Actividad Lección 07 - Mesa de contexto y criterios de riesgo"
tags:
  - nota
  - course
  - curso
  - actividad
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "07"
author: Jordy
start: 2026-09-21
end: 2026-09-22
created_at: 2026-09-18
aliases:
  - "Actividad Lección 07 - Mesa de contexto y criterios de riesgo"
---
# Actividad Lección 07 - Mesa de contexto y criterios de riesgo

- **Modalidad:** equipos de tres, con roles estables.
- **Duración:** 85 minutos, contados desde que el paquete está copiado y verificado.
- **Caso:** `PR-2027-01` - PACÍFICO RETAIL SPA (ficticia).
- **Entorno:** estación Linux del laboratorio (Kali), usando solo la terminal local. No se requiere conexión de red, máquinas virtuales ni herramientas de seguridad.
- **Carácter:** formativo, sin calificación.
- **Producto:** un solo documento, `plantilla-entrega-leccion-07.md`.

## De qué se trata

La gerencia general de PACÍFICO RETAIL SPA, una empresa de retail con venta en línea y cinco locales, pidió «evaluar todos los riesgos» antes de la campaña de noviembre. No dijo con qué reglas se compararán esos riesgos entre sí, ni quién decide sobre cada uno. Construir esas reglas es el trabajo de hoy.

> ¿Con qué criterios explícitos esta organización puede comparar un riesgo con otro, y quién tiene autoridad para decidir sobre cada uno?

**En esta lección no se evalúa ningún riesgo, no se asignan puntajes y no se proponen controles.** Eso viene en las lecciones 09, 10 y 11. Aquí se definen las condiciones para que ese trabajo posterior sea defendible.

## Antes de empezar

Repartan los tres roles y manténganlos toda la sesión:

| Rol | Responsabilidad |
| --- | --- |
| Coordinador | Mantiene el ritmo de trabajo y al equipo dentro del alcance. |
| Registrador | Escribe en la ficha; es el único que edita el archivo. |
| Revisor | Comprueba que cada criterio sea observable y que cada decisión tenga un responsable con autoridad. |

Copien el material y verifíquenlo:

```bash
mkdir -p ~/inf44/LAB-07
cp -a material/. ~/inf44/LAB-07/
cd ~/inf44/LAB-07
sha256sum -c manifest_entrega.sha256
```

Los seis archivos deben indicar `OK`. Si aparece un `FAILED`, detengan el trabajo e informen al docente.

Tres reglas para todo el trabajo:

```text
Un criterio que no se puede observar no es un criterio.
Una decisión sin persona con autoridad no es una decisión.
Un dato que no está en el paquete se declara faltante; no se inventa.
```

## Cómo trabajar

Todo se escribe en `plantilla-entrega-leccion-07.md`, que es la entrega. Ábranla con `nano plantilla-entrega-leccion-07.md` y reemplacen cada marcador `[ ]` de respuesta por su contenido. Al final, marquen las casillas de comprobación como `[x]`.

**Cada paso de esta actividad llena la sección del mismo número en la ficha.** Los otros cuatro archivos son los antecedentes del caso: se consultan, no se modifican.

## Paso 1 - Objetivo y alcance

**Consulten:** `contexto-organizacional.md`, sección «Solicitud recibida».

1. Reescriban la solicitud de la gerencia como un objetivo verificable, en una sola oración.
2. Declaren el periodo que cubre el análisis.
3. Definan dos cosas que el análisis incluye y una que deja fuera.
4. Para lo que dejan fuera, digan qué riesgo queda sin cubrir y quién lo asume.
5. Identifiquen quién tiene autoridad para aprobar el alcance.

No intenten abarcar toda la empresa. Un alcance acotado y defendible vale más que uno completo e imposible de cumplir en tres semanas con una persona de seguridad a media jornada.

## Paso 2 - Contexto

**Consulten:** `procesos-criticos.csv`.

1. Elijan dos procesos críticos y completen la tabla de la sección 2.
2. Para cada uno: qué objetivo de la empresa sostiene, de qué proveedor depende, en qué ventana de tiempo importa y por qué es crítico.
3. Respondan qué controla PACÍFICO RETAIL y qué controla NUBEPAC respecto del respaldo del sitio.

Un proceso es crítico cuando su interrupción afecta un objetivo declarado dentro de una ventana conocida. Que sea valorado por la empresa no basta.

**Listo cuando:** cada proceso elegido está unido a un objetivo y a una ventana de tiempo concretos.

## Paso 3 - Partes interesadas

**Consulten:** `partes-interesadas.csv`.

1. Elijan una parte con mucho interés y ninguna autoridad.
2. Elijan otra con autoridad sobre una decisión que le afecta poco.
3. Para cada una: qué espera, qué decide realmente y cómo debe comunicársele el resultado.

Tener interés no es lo mismo que tener autoridad. Confundirlos hace que se consulte mucho y no se decida nada.

**Listo cuando:** las dos filas dejan claro quién opina y quién decide.

## Paso 4 - Escalas

**Consulten:** `eventos-historicos.csv` y los datos de tamaño del perfil.

1. Completen los cinco niveles de probabilidad con un descriptor observable cada uno.
2. Completen los cinco niveles de impacto financiero con cortes en pesos.
3. En los niveles `1`, `3` y `5` citen un dato concreto del caso. En el `2` y el `4` conserven la referencia de interpolación ya escrita en la plantilla.
4. Respondan las dos preguntas de calibración de la sección 4.3.

Un descriptor observable es una frecuencia, un monto, una duración o una condición que se puede verificar. «Media» no es un descriptor; «un caso registrado en los últimos 24 meses» sí lo es. Los montos deben ser proporcionales a un ingreso anual de 18.000 millones de pesos: si el nivel más alto supera el ingreso de la empresa, la escala no distingue nada.

**Listo cuando:** dos personas distintas asignarían el mismo nivel al mismo hecho.

## Paso 5 - Tolerancias

**Consulten:** el perfil organizacional y `partes-interesadas.csv`.

1. Completen la indisponibilidad del sitio en campaña y el retraso en analítica comercial.
2. En cada una: apetito, umbral medible con unidad y periodo, indicador que permite comprobarlo, quién puede aceptar y qué obliga a escalar.
3. Comparen ambas tolerancias y distingan un requisito mínimo que no puede tratarse como apetito.

El apetito orienta y es cualitativo; la tolerancia es un umbral que permite detectar cuándo se cruzó un límite. «Tolerancia: 3 sobre 5» no sirve, porque nadie puede comprobarlo. Y una obligación legal no se expresa como apetito: no se puede aceptar un nivel de incumplimiento.

**Listo cuando:** alguien externo podría revisar el indicador y decir si el umbral se cruzó o no.

## Paso 6 - Propiedad del riesgo

**Consulten:** `partes-interesadas.csv`.

1. Los escenarios `R-01` y `R-02` ya vienen redactados. No los reescriban ni los puntúen.
2. Para cada uno asignen propietario del riesgo y responsable interno del control. Si participa un proveedor, identifíquenlo como ejecutor externo, no como reemplazo de la responsabilidad interna.
3. Declaren un dato que falta y el supuesto que adoptan mientras tanto.

El propietario decide y responde; el responsable interno del control coordina su ejecución, incluso cuando una parte la realiza un proveedor. Deben ser cargos distintos al menos en uno de los dos escenarios. Si el propietario no puede autorizar el gasto ni detener el proceso, no es el propietario real.

**Listo cuando:** ningún riesgo quedó asignado al área de seguridad por defecto.

## Paso 7 - Revisión cruzada

1. Intercambien la ficha con otro equipo.
2. En la ficha recibida, busquen **un** problema: un criterio que no se puede observar, o un propietario ausente o sin autoridad.
3. Devuelvan la ficha con esa observación escrita.
4. Cuando reciban la suya, corrijan **un** hallazgo y registren en la sección 7 qué equipo revisó, cuál era el problema y qué cambiaron.

**Listo cuando:** la ficha muestra qué les observaron y qué corrigieron.

## Paso 8 - Cierre individual

Cada integrante elige **una** pregunta y la responde en una o dos frases. El registrador incorpora las tres respuestas en la sección 8 e identifica a quien responde:

1. ¿Qué cambia en el análisis si la gerencia general fija una tolerancia distinta a la que ustedes propusieron?
2. ¿Por qué no se puede aceptar un riesgo que implica incumplir una obligación legal?
3. ¿Qué dato del caso les habría permitido calibrar mejor una escala y no estaba disponible?

## Si terminan antes

Solo con el producto obligatorio cerrado, elijan **una** ampliación y desarróllenla en la sección correspondiente de la ficha:

- completar una dimensión adicional de impacto;
- completar la tolerancia de fraude en pagos;
- incorporar un tercer proceso crítico;
- redactar un tercer escenario de riesgo con su propietario;
- detectar además una dependencia externa o un supuesto no declarado en la revisión cruzada.

## Entrega

Antes de cerrar, comprueben que no quede ningún campo pendiente y marquen la lista al final de la ficha:

```bash
grep -n '\[ \]' plantilla-entrega-leccion-07.md
sha256sum plantilla-entrega-leccion-07.md > entrega_equipo.sha256
```

El equipo entrega `plantilla-entrega-leccion-07.md` junto con `entrega_equipo.sha256`. No creen otro documento de contenido ni conviertan la entrega a PDF, porque la huella corresponde al archivo Markdown.
