---
title: "Guía práctica de comandos Lección 08 - Paquete de selección metodológica"
tags:
  - nota
  - course
  - curso
  - guia-comandos
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "08"
author: Jordy
start: 2026-09-28
end: 2026-09-29
created_at: 2026-09-26
aliases:
  - "Guía práctica de comandos Lección 08 - Paquete de selección metodológica"
---

# Guía práctica de comandos Lección 08 - Paquete de selección metodológica

## Objetivo y alcance

Usa esta guía solo para trabajar con los archivos del caso `PR-2027-01` en la Lección 08. Al finalizar tendrás una copia de trabajo verificada, la ficha completa y un manifiesto propio de la entrega.

Los comandos se ejecutan en la estación Linux del laboratorio (Kali), en la terminal local y sin conexión de red. Son utilidades estándar: no se instala nada y ningún comando requiere `sudo`. La terminal sirve para copiar, leer y comprobar archivos; la selección de la metodología la decide el equipo.

## 1. Crear la copia de trabajo

Desde la carpeta de la Lección 08, ejecuta:

```bash
mkdir -p ~/inf44/LAB-08
cp -a material/. ~/inf44/LAB-08/
cd ~/inf44/LAB-08
pwd
```

| Parte | Explicación |
| --- | --- |
| `mkdir -p` | Crea la carpeta de trabajo si todavía no existe. |
| `cp -a material/.` | Copia todo el contenido del paquete y conserva su estructura. |
| `cd` | Cambia la terminal a la copia. |
| `pwd` | Muestra la ubicación actual; debe terminar en `/inf44/LAB-08`. |

**Precaución:** si `LAB-08` contiene una actividad anterior, informa al docente antes de copiar.

## 2. Verificar el paquete recibido

```bash
sha256sum -c manifest_entrega.sha256
```

Los ocho archivos deben mostrar `OK` antes de editar. Si aparece `FAILED`, no reemplaces el manifiesto ni corrijas el archivo: informa al docente.

Después de completar la plantilla, ese archivo ya no coincidirá con el manifiesto. Es esperado: el manifiesto representa el paquete **inicial**.

## 3. Leer las fichas y los criterios de riesgo

```bash
less fichas-referencias.md
less criterios-de-riesgo-l07.md
less contexto-organizacional.md
```

Dentro de `less`, escribe `/texto` para buscar, `n` para ir a la coincidencia siguiente y `q` para salir. Por ejemplo, `/Qué no hace` salta a la fila que resume el límite de cada referencia.

## 4. Leer los CSV del caso

Para el producto obligatorio se consulta `necesidades-de-decision.csv`. Los otros dos CSV se usan en el cierre guiado o en una ampliación opcional:

```bash
column -s, -t necesidades-de-decision.csv | less -S
column -s, -t evaluaciones-previas.csv | less -S
column -s, -t propuestas-tratamiento.csv | less -S
```

| Parte | Explicación |
| --- | --- |
| `column -s, -t` | Presenta el CSV como tabla: `-s,` indica que la coma separa campos y `-t` alinea las columnas. |
| `\| less -S` | Abre la tabla en un visor sin partir las líneas largas; desplázate con las flechas laterales. |

Para ver una sola fila, por ejemplo la necesidad `ND-04`:

```bash
grep '^ND-04,' necesidades-de-decision.csv | tr ',' '\n'
```

| Parte | Explicación |
| --- | --- |
| `grep '^ND-04,'` | Muestra solo la línea que comienza con `ND-04,`. |
| `tr ',' '\n'` | Reemplaza cada coma por un salto de línea: cada campo queda en su propia línea. |

Para revisar solo el costo de cada propuesta:

```bash
cut -d, -f1,4 propuestas-tratamiento.csv
```

`cut -d, -f1,4` muestra los campos 1 y 4 de cada línea: el identificador y el costo anual estimado.

Si aparece `column: command not found`, usa `less archivo.csv`.

## 5. Completar la ficha

```bash
nano plantilla-entrega-leccion-08.md
```

| Tecla | Acción |
| --- | --- |
| `Ctrl+O` y Enter | Guarda los cambios. |
| `Ctrl+W` | Busca un texto, por ejemplo `## 4.` para saltar a la sección del ciclo. |
| `Ctrl+X` | Cierra el editor. |

Reemplaza cada marcador `[ ]` de respuesta por el contenido del equipo y conserva los títulos de sección. Los demás archivos no se editan.

## 6. Comprobar que la ficha quedó completa

Ejecuta este control **después del cierre individual**, cuando el registrador haya incorporado las tres respuestas y marcado las casillas:

```bash
grep -n '\[ \]' plantilla-entrega-leccion-08.md
```

Cada línea que aparezca contiene uno o más campos sin responder o una casilla sin marcar. La ficha está cerrada cuando el comando no devuelve ninguna línea.

## 7. Cerrar la entrega con integridad

```bash
sha256sum plantilla-entrega-leccion-08.md > entrega_equipo.sha256
sha256sum -c entrega_equipo.sha256
```

El resultado debe indicar `OK`. Si vuelves a editar la ficha, genera nuevamente `entrega_equipo.sha256` con la versión definitiva.

## Si aparece un error

| Situación | Qué revisar |
| --- | --- |
| `No such file or directory` | Ejecuta `pwd`; vuelve a `~/inf44/LAB-08` con `cd`. |
| Un archivo muestra `FAILED` antes de editar | Detente e informa al docente. |
| `column: command not found` | Usa `less archivo.csv`. |
| `grep` no muestra la fila buscada | Revisa que el identificador esté escrito en mayúsculas y seguido de una coma. |
| El manifiesto del equipo muestra `FAILED` | La ficha cambió después del cierre; genera de nuevo el manifiesto definitivo. |

## Comprobación final

- [ ] Trabajé sobre `~/inf44/LAB-08`.
- [ ] Verifiqué los ocho archivos antes de editar.
- [ ] Escribí todo el trabajo dentro de `plantilla-entrega-leccion-08.md`.
- [ ] El control de campos pendientes terminó sin salida.
- [ ] Generé y comprobé `entrega_equipo.sha256`.
