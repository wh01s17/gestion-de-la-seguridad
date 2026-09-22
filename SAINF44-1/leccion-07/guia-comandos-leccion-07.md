---
title: "Guía práctica de comandos Lección 07 - Paquete de contexto"
tags:
  - nota
  - course
  - curso
  - guia-comandos
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "07"
author: Jordy
start: 2026-09-21
end: 2026-09-22
created_at: 2026-09-18
aliases:
  - "Guía práctica de comandos Lección 07 - Paquete de contexto"
---

# Guía práctica de comandos Lección 07 - Paquete de contexto

## Objetivo y alcance

Usa esta guía solo para trabajar con los archivos del caso `PR-2027-01`. Al finalizar tendrás una copia de trabajo, la verificación inicial del paquete, la ficha completa y un manifiesto propio de la entrega.

Los comandos se ejecutan en la estación Linux del laboratorio (Kali), desde la terminal local y sin conexión de red. Todos son utilidades estándar del sistema: no se instala nada y ningún comando requiere `sudo`. La definición del alcance, las escalas, las tolerancias y la asignación de autoridad se desarrolla en la actividad de la lección. La terminal sirve para copiar, leer y comprobar archivos; no toma decisiones de riesgo.

## 1. Crear la copia de trabajo

Desde la carpeta de la Lección 07, ejecuta:

```bash
mkdir -p ~/inf44/LAB-07
cp -a material/. ~/inf44/LAB-07/
cd ~/inf44/LAB-07
pwd
```

| Parte | Explicación |
| --- | --- |
| `mkdir -p` | Crea la carpeta de trabajo si todavía no existe. |
| `cp -a` | Copia el paquete y conserva su estructura y metadatos disponibles. |
| `material/.` | Indica que se copia todo el contenido de `material`. |
| `cd` | Cambia la terminal a la copia. |
| `pwd` | Muestra la ubicación actual; debe terminar en `/inf44/LAB-07`. |

**Precaución:** si `LAB-07` contiene una actividad anterior, informa al docente antes de copiar. No mezcles respuestas de dos equipos.

## 2. Verificar el paquete recibido

```bash
sha256sum -c manifest_entrega.sha256
```

| Parte | Explicación |
| --- | --- |
| `sha256sum` | Calcula huellas SHA-256. No modifica los archivos. |
| `-c` | Activa el modo comprobar y compara con las huellas de referencia. |
| `manifest_entrega.sha256` | Contiene los nombres y las huellas del paquete recibido. |

Los seis archivos deben mostrar `OK` antes de editar. Si aparece `FAILED`, no reemplaces el manifiesto ni corrijas el archivo: registra la discrepancia e informa al docente.

Después de completar la plantilla, el archivo editado ya no coincidirá con este manifiesto. Eso es esperado porque el manifiesto representa el paquete **inicial**.

## 3. Leer los datos del caso

```bash
less contexto-organizacional.md
column -s, -t procesos-criticos.csv | less -S
column -s, -t partes-interesadas.csv | less -S
column -s, -t eventos-historicos.csv | less -S
```

| Parte | Explicación |
| --- | --- |
| `less archivo` | Abre un visor que no modifica el contenido. Se sale con `q`. |
| `column` | Presenta las filas del CSV como una tabla legible. |
| `-s,` | Indica que la coma separa los campos. |
| `-t` | Alinea los campos en columnas. |
| `\|` | Envía la tabla producida por `column` al visor. |
| `less -S` | Evita partir líneas largas; usa las flechas laterales para desplazarte. |

Dentro de `less`, escribe `/texto` para buscar una palabra, `n` para avanzar a la coincidencia siguiente y `q` para salir. Consulta solo los archivos necesarios para justificar cada decisión.

Si aparece `column: command not found`, usa `less archivo.csv`. La presentación será menos cómoda, pero el contenido no cambia.

## 4. Completar la ficha

Todo el trabajo del equipo se escribe en un solo archivo:

```bash
nano plantilla-entrega-leccion-07.md
```

| Parte | Explicación |
| --- | --- |
| `nano` | Abre un editor de texto en la terminal. |
| `plantilla-entrega-leccion-07.md` | Es la plantilla de entrega y el único archivo que se edita. |
| `Ctrl+O` | Guarda los cambios; confirma el nombre con Enter. |
| `Ctrl+X` | Cierra el editor. |

Reemplaza cada marcador `[ ]` de respuesta por el contenido del equipo y conserva los títulos de sección tal como están: son los que usa el docente para revisar. Al final, cambia a `[x]` las casillas de comprobación que efectivamente cumplan. Los cuatro archivos de contexto contienen los antecedentes del caso y no deben editarse.

Los escenarios `R-01` y `R-02` de la sección 6 vienen redactados. Conserva su texto y completa solo propietario, responsable interno del control, dato faltante y supuesto provisional. La formulación de escenarios desde cero se trabaja en la Lección 09.

## 5. Comprobar que la ficha quedó completa

```bash
grep -n '\[ \]' plantilla-entrega-leccion-07.md
```

| Parte | Explicación |
| --- | --- |
| `grep` | Busca un texto dentro del archivo. |
| `-n` | Muestra el número de línea de cada coincidencia. |
| `'\[ \]'` | Busca los marcadores de respuesta pendiente. Las barras evitan que los corchetes se interpreten como un conjunto de caracteres. |

Cada línea que aparezca contiene uno o más campos sin responder. Las casillas de la lista de comprobación final también aparecen mientras no las marques: se marcan escribiendo `[x]` entre los corchetes. Como todos los campos obligatorios contienen un marcador, la ficha está cerrada cuando el comando no devuelve ninguna línea.

## 6. Cerrar la entrega con integridad

```bash
sha256sum plantilla-entrega-leccion-07.md > entrega_equipo.sha256
sha256sum -c entrega_equipo.sha256
```

| Parte | Explicación |
| --- | --- |
| `sha256sum archivo` | Calcula la huella del documento que entrega el equipo. |
| `>` | Guarda la salida en un archivo nuevo. |
| `entrega_equipo.sha256` | Es el manifiesto del equipo; no reemplaza el manifiesto recibido. |
| `sha256sum -c entrega_equipo.sha256` | Comprueba que la ficha sigue igual después del cierre. |

El resultado debe indicar `OK`. Si vuelves a editar la ficha, genera nuevamente `entrega_equipo.sha256` cuando la versión definitiva esté cerrada.

## Evidencia mínima de cierre

| Evidencia mínima | Qué comprobar o conservar |
| --- | --- |
| `pwd` | La ruta mostrada debe terminar en `/inf44/LAB-07`. |
| Verificación inicial | Seis archivos en `OK` o la discrepancia informada. |
| Datos consultados | La referencia concreta que sustenta cada decisión, no la salida completa de la terminal. |
| `entrega_equipo.sha256` | Huella del documento entregado. |

## Si aparece un error

| Situación | Qué revisar |
| --- | --- |
| `No such file or directory` | Ejecuta `pwd`; vuelve a `~/inf44/LAB-07` con `cd`. |
| Un archivo muestra `FAILED` antes de editar | Detente e informa al docente. No reemplaces el manifiesto. |
| `column: command not found` | Usa `less archivo.csv`. |
| La tabla aparece descuadrada | Revisa si algún campo contiene una coma adicional. |
| El manifiesto del equipo muestra `FAILED` | El archivo cambió después del cierre; revisa y vuelve a generar el manifiesto definitivo. |

## Comprobación final

- [ ] Trabajé sobre `~/inf44/LAB-07`.
- [ ] Verifiqué los seis archivos antes de editar.
- [ ] Escribí todo el trabajo dentro de `plantilla-entrega-leccion-07.md` y no modifiqué los archivos de contexto.
- [ ] El control de campos pendientes terminó sin salida.
- [ ] Cada decisión se apoya en un dato del caso.
- [ ] Generé y comprobé `entrega_equipo.sha256`.
