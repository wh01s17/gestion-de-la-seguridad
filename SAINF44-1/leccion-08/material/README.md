# Material de trabajo - Lección 08

Paquete sintético del caso `PACÍFICO RETAIL SPA` para comparar metodologías de gestión del riesgo, seleccionar un enfoque y diseñar el ciclo que se aplicará en las lecciones 09 a 11. Los datos son ficticios; no representan a una organización real.

## Archivos

| Archivo | Uso |
| --- | --- |
| `plantilla-entrega-leccion-08.md` | **Plantilla de entrega.** Es el único documento de contenido que el equipo completa y entrega. |
| `contexto-organizacional.md` | Perfil del caso. Es el mismo archivo de la Lección 07, sin cambios. |
| `criterios-de-riesgo-l07.md` | Escalas y tolerancias consolidadas al cierre de la Lección 07. Son la única escala del ciclo. |
| `fichas-referencias.md` | Resumen de ISO/IEC 27005, NIST SP 800-30, NIST CSF 2.0 y, como apoyo, NIST IR 8286A. |
| `necesidades-de-decision.csv` | Seis necesidades de decisión planteadas por distintas partes del caso. |
| `evaluaciones-previas.csv` | Cuatro valoraciones incompatibles para el modelado y la ampliación opcional. |
| `propuestas-tratamiento.csv` | Cinco propuestas para el cierre guiado y la ampliación opcional. |
| `manifest_entrega.sha256` | Control de integridad de los ocho archivos del paquete, incluido este README. |

Los archivos de antecedentes no se modifican. El producto obligatorio compara tres referencias en cuatro dimensiones, selecciona un proceso rector y bosqueja el ciclo. Todo el contenido que produce el equipo se escribe en `plantilla-entrega-leccion-08.md`, que se entrega en Markdown junto con `entrega_equipo.sha256`.

## Inicio obligatorio

1. Trabaje sobre una copia y conserve el paquete recibido sin modificar:

   ```bash
   mkdir -p ~/inf44/LAB-08
   cp -a material/. ~/inf44/LAB-08/
   cd ~/inf44/LAB-08
   ```

2. Verifique el manifiesto desde la copia:

   ```bash
   sha256sum -c manifest_entrega.sha256
   ```

   Los ocho archivos deben indicar `OK`. Si aparece un `FAILED`, detenga el trabajo e informe al docente.

3. Complete `plantilla-entrega-leccion-08.md` siguiendo los pasos de la actividad.

## Límites de la lección

- No se asignan niveles de probabilidad, impacto ni riesgo a los escenarios del caso: eso corresponde a la Lección 10.
- No se decide el orden de ejecución de los tratamientos: requiere la valoración.
- No se formulan escenarios nuevos: el inventario y el registro inicial se construyen en la Lección 09.
- Un dato que no está en el paquete se declara como faltante; no se inventa.
