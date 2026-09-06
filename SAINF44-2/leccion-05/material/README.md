# Material de laboratorio - Lección 05

Paquete sintético para construir y afinar una regla IDS con Snort 3. Todo el análisis se realiza **offline** sobre `trafico_l05.pcap`; no se captura tráfico institucional ni se generan ataques.

## Archivos

| Archivo | Uso |
| --- | --- |
| `contexto_controles.csv` | Referencia mínima de AAA, firewall y accounting. |
| `matriz_pruebas.csv` | Registro de pruebas e integración con firewall, AAA y accounting. |
| `registros_l05.csv` | Eventos sintéticos de AAA, firewall y accounting para la correlación. |
| `regla_inicial.rules` | Regla deliberadamente amplia que debe analizarse y ajustarse. |
| `trafico_l05.pcap` | Cinco sesiones TCP sintéticas con establecimiento completo. |
| `manifest_entrega.sha256` | Control de integridad de los seis archivos del paquete. |

## Inicio obligatorio

1. Verifica el manifiesto desde esta carpeta:

   ```bash
   sha256sum -c manifest_entrega.sha256
   ```

2. Conserva `regla_inicial.rules` sin cambios y trabaja sobre una copia llamada `local_l05.rules`.
3. Examina solo la PCAP entregada. No uses captura en vivo.

Si el manifiesto falla o una herramienta no está disponible, detén el paso técnico y solicita la contingencia docente. No inventes alertas.
