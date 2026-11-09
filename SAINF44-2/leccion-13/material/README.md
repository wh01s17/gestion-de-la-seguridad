---
title: "Material Lección 13 - Recuperación frente a desastres"
course: INF44 - Gestión de la Seguridad
lesson: "13"
---

# Material Lección 13 - DELTA LOGÍSTICA SPA

Este paquete acompaña la actividad de la Lección 13. No requiere herramientas ni red: se trabaja leyendo y razonando sobre el escenario.

| Archivo | Contenido |
| --- | --- |
| `escenario.md` | Narrativa del evento, línea de tiempo y restricciones. |
| `procesos.csv` | Procesos del negocio, criticidad, MTPD y sistemas asociados. |
| `dependencias.csv` | Recursos y servicios, ubicación, dependencias y respaldo. |
| `manifest_entrega.sha256` | Hashes de los archivos del material para verificar integridad. |

Para leer los CSV en pantalla con columnas alineadas:

```bash
column -s, -t < procesos.csv
column -s, -t < dependencias.csv
```

Verificar integridad:

```bash
sha256sum -c manifest_entrega.sha256
```

El producto de la actividad no se construye aquí: se registra en `plantilla-entrega-leccion-13.docx`, en la carpeta de la lección.
