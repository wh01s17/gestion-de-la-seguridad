---
title: "Material Lección 14 - BIA, RTO y RPO"
course: INF44 - Gestión de la Seguridad
lesson: "14"
---

# Material Lección 14 - DELTA LOGÍSTICA SPA

Este paquete acompaña la actividad de la Lección 14. Continúa el caso de la lección 13. No requiere herramientas ni red: se trabaja leyendo y razonando sobre los datos.

| Archivo | Contenido |
| --- | --- |
| `escenario.md` | Situación después del corte, encargo de la gerencia, criterios de impacto, política de continuidad y tolerancia de datos. |
| `impactos.csv` | Consecuencias de cada proceso por horizonte de tiempo. |
| `capacidad.csv` | Recursos, dependencias, tiempo de recuperación, si se probó y punto de recuperación. |
| `estrategias.csv` | Opciones de estrategia con RTO, RPO, costo anual y supuestos. |
| `manifest_entrega.sha256` | Hashes de los archivos del material para verificar integridad. |

Para leer los CSV en pantalla con columnas alineadas:

```bash
column -s, -t < impactos.csv
column -s, -t < capacidad.csv
column -s, -t < estrategias.csv
```

Si una línea es muy larga, se puede ver un proceso a la vez:

```bash
grep -E '^id|Despacho' impactos.csv | column -s, -t
```

Verificar integridad:

```bash
sha256sum -c manifest_entrega.sha256
```

El producto de la actividad no se construye aquí: se registra en `plantilla-entrega-leccion-14.docx`, en la carpeta de la lección.
