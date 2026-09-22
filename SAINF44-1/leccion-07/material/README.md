# Material de trabajo - Lección 07

Paquete sintético del caso `PACÍFICO RETAIL SPA` para establecer el contexto, las escalas, las tolerancias y los propietarios del riesgo antes de valorar cualquier riesgo. Los datos son ficticios; no representan a una organización real.

## Archivos

| Archivo | Uso |
| --- | --- |
| `plantilla-entrega-leccion-07.md` | **Plantilla de entrega.** Es el único documento de contenido que el equipo completa y entrega. |
| `contexto-organizacional.md` | Perfil, objetivos, solicitud recibida, dependencias, obligaciones, restricciones y hechos de los últimos 24 meses. |
| `partes-interesadas.csv` | Doce partes interesadas con su interés, expectativa y autoridad real sobre las decisiones. |
| `procesos-criticos.csv` | Siete procesos con su soporte tecnológico, dependencia externa, dato personal y ventana crítica. |
| `eventos-historicos.csv` | Frecuencia e impacto de hechos observados; sirve para calibrar las escalas con datos y no con impresiones. |
| `manifest_entrega.sha256` | Control de integridad de los seis archivos del paquete, incluido este README. |

Los cuatro archivos de contexto son la entrada del caso y no se modifican. Todo el contenido que el equipo produce se escribe dentro de `plantilla-entrega-leccion-07.md`: escalas, tolerancias, propiedad de los riesgos y respuestas de cierre. La plantilla se entrega en Markdown junto con su archivo de integridad `entrega_equipo.sha256`.

## Inicio obligatorio

1. Trabaje sobre una copia y conserve el paquete recibido sin modificar:

   ```bash
   mkdir -p ~/inf44/LAB-07
   cp -a material/. ~/inf44/LAB-07/
   cd ~/inf44/LAB-07
   ```

2. Verifique el manifiesto desde la copia:

   ```bash
   sha256sum -c manifest_entrega.sha256
   ```

   Los seis archivos deben indicar `OK`. Si aparece un `FAILED`, detenga el trabajo e informe al docente.

3. Complete `plantilla-entrega-leccion-07.md` siguiendo las fases de la actividad. Reemplace cada marcador `[ ]` de respuesta por su contenido, marque como `[x]` las casillas finales que correspondan y conserve los títulos. No cree otros documentos de contenido ni copie dentro de la ficha las tablas de los archivos de contexto.

## Límites de la lección

- No se calculan niveles de riesgo ni se ordenan riesgos de mayor a menor: eso corresponde a las lecciones 09 y 10.
- No se exige formular escenarios desde cero: los dos escenarios proporcionados se revisarán en la Lección 09 junto con el inventario y el registro inicial.
- No se proponen controles ni costos: sin criterios definidos, cualquier priorización es arbitraria.
- Un dato que no está en el paquete se declara como faltante con su supuesto provisional; no se inventa.
- La sección de ampliación de la ficha no se considera incompleta si el producto obligatorio está cerrado.
