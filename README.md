# INF44 · Gestión de la Seguridad

Repositorio académico de **INF44 — Gestión de la Seguridad**, asignatura de la carrera Técnico de Nivel Superior en Ciberseguridad del CFT San Antonio. Aquí se publican materiales de clase, actividades, casos y recursos de apoyo para las secciones diurna y vespertina del segundo semestre de 2026.

La asignatura estudia cómo proteger los activos de información de una organización mediante la identificación y valoración de riesgos, la selección de controles, la formulación de políticas y la preparación para responder y recuperarse de incidentes. El objetivo no es instalar controles aislados, sino relacionarlos con necesidades del negocio, responsables, evidencia de operación y criterios verificables de efectividad.

## Información general

| Antecedente | Detalle |
| --- | --- |
| Sigla | INF44 |
| Carrera | TNS en Ciberseguridad |
| Requisitos | No considera |
| Carga total | 54 horas: 18 teóricas y 36 prácticas |
| Dedicación semanal | 3 horas |
| Créditos | 6 |
| Periodo académico | Segundo semestre de 2026 |
| Secciones | SAINF44-1, jornada diurna; SAINF44-2, jornada vespertina |

## Propósito formativo

Al finalizar el curso, cada estudiante deberá ser capaz de gestionar controles de seguridad de acuerdo con los riesgos, el contexto de la organización y las prácticas de la industria. Esto incluye comprobar si los controles existen, están implementados, operan correctamente y reducen de manera efectiva el riesgo para el cual fueron seleccionados.

En particular, se espera que pueda:

- reconocer vectores de ataque y relacionarlos con modelos como Cyber Kill Chain y MITRE ATT&CK;
- diferenciar controles administrativos, técnicos y físicos, así como sus funciones preventivas, detectivas, correctivas y de recuperación;
- implementar y verificar controles de acceso, AAA, firewall e IDS en laboratorios autorizados;
- identificar activos, amenazas, vulnerabilidades, probabilidad, impacto y riesgo;
- construir matrices y registros de riesgo, priorizar escenarios y definir su tratamiento;
- diseñar, comunicar, mantener y auditar políticas de seguridad;
- realizar un análisis de impacto al negocio y utilizar RTO, RPO y otros criterios de recuperación;
- elaborar planes de respuesta a incidentes y recuperación frente a desastres;
- probar los planes, interpretar métricas y proponer mejoras;
- priorizar vulnerabilidades y documentar un plan de mitigación con responsables y evidencia de cierre.

## Unidades de aprendizaje

| Unidad | Horas | Contenidos principales | Evaluación |
| --- | ---: | --- | ---: |
| UA1 · Vectores de ataque y controles de seguridad | 18 | Cyber Kill Chain, vectores de ataque, tipos de controles, CIS Controls, AAA, firewall e IDS Snort. | 30% |
| UA2 · Gestión de riesgos y políticas de seguridad | 18 | Identificación, análisis y tratamiento de riesgos; matrices, riesgo residual, políticas, implementación, validación y auditoría. | 20% |
| UA3 · Recuperación frente a desastres | 15 | Continuidad, BIA, RTO, RPO, recuperación, respuesta a incidentes, pruebas, métricas y mitigación de vulnerabilidades. | 20% |
| Evaluación final integradora | 3 | Resolución de un caso organizacional mediante controles, políticas, mitigación, respuesta y recuperación. | 30% |

Las ponderaciones suman el 100% de la calificación. Las fechas, modalidades y condiciones específicas de cada evaluación se comunican mediante los canales institucionales de la asignatura.

## Ruta del semestre

La secuencia común comprende 18 lecciones:

1. **Lecciones 01–06 — Ataques y controles:** Cyber Kill Chain, vectores, clasificación y priorización de controles, AAA, firewall e IDS. La lección 06 integra la UA1.
2. **Lecciones 07–12 — Riesgos y políticas:** contexto, activos, amenazas, vulnerabilidades, matrices, tratamiento, riesgo residual, diseño y auditoría de políticas. La lección 12 integra la UA2.
3. **Lecciones 13–17 — Recuperación y respuesta:** BIA, RTO, RPO, continuidad, recuperación frente a desastres, respuesta a incidentes, ejercicios, métricas y mitigación. La lección 17 integra la UA3.
4. **Lección 18 — Evaluación final:** caso organizacional que relaciona riesgos, controles, políticas, vulnerabilidades, respuesta y recuperación.

Ambas secciones desarrollan el mismo núcleo formativo en 18 clases de tres horas, de acuerdo con el calendario institucional de cada jornada.

## Metodología de trabajo

El curso combina exposiciones breves, análisis de escenarios, laboratorios guiados, estudio de casos, trabajo cooperativo y aprendizaje basado en problemas. Las actividades conectan cada riesgo con un objetivo de control, un responsable, una forma de implementación y evidencia que permita evaluar su funcionamiento.

Para los casos de gestión se recomienda seguir este flujo:

1. Comprender el contexto, el alcance y los objetivos de la organización.
2. Identificar activos, procesos, dependencias, amenazas y vulnerabilidades.
3. Estimar probabilidad e impacto con criterios explícitos y consistentes.
4. Priorizar los riesgos y seleccionar una opción de tratamiento.
5. Asociar controles proporcionales, responsables, plazos y recursos.
6. Definir evidencia, pruebas y métricas para verificar implementación y efectividad.
7. Documentar riesgo residual, excepciones, decisiones y acciones de mejora.

## Organización del repositorio

```text
.
├── SAINF44-1/
│   └── leccion-XX/       # materiales de la sección diurna
├── SAINF44-2/
│   └── leccion-XX/       # materiales de la sección vespertina
└── cheatsheets/          # ayudas de Linux, Git y Markdown
```

Dentro de cada lección pueden existir guías, actividades, configuraciones de laboratorio, casos y documentos de apoyo. Se debe trabajar en la carpeta de la sección correspondiente y respetar las instrucciones particulares de cada entrega.

## Criterios de una buena solución

Una propuesta de seguridad debe ser proporcional y verificable. No basta con nombrar una herramienta o copiar una lista de controles: se debe explicar qué riesgo aborda, cómo se implementará, quién será responsable, qué evidencia demostrará su operación y cómo se medirá el riesgo residual.

Como mínimo, los entregables deberían mantener trazabilidad entre:

```text
activo → amenaza → vulnerabilidad → escenario de riesgo
       → tratamiento → control → responsable → evidencia → métrica
```

## Ética, seguridad e integridad académica

- Configura y prueba controles solo en infraestructura propia, simulada o expresamente autorizada.
- No escanees, interceptes ni modifiques redes, cuentas o servicios reales sin permiso escrito.
- No publiques credenciales, datos personales, configuraciones sensibles ni información institucional.
- Respalda las decisiones con evidencia y declara los supuestos cuando falten datos.
- Cita normas, marcos, documentación técnica y cualquier asistencia utilizada según las reglas de la actividad.
- Distingue cumplimiento documental de seguridad efectiva: una política o control debe poder comprobarse mediante examen, entrevista o prueba.

## Bibliografía

### Bibliografía del programa

- Dirección Académica. (2022). *Programa de asignatura INF44: Gestión de la Seguridad* [Programa de asignatura].
- Miguel Pérez, J. C. (2015). *Protección de datos y seguridad de la información*. RA-MA. ISBN 978-84-9964-591-9.
- Costas Santos, J. (2011). *Mantenimiento de la seguridad en sistemas informáticos*. RA-MA. ISBN 978-84-9964-336-6.

### Referencias técnicas complementarias

- National Institute of Standards and Technology. (2024). [*The NIST Cybersecurity Framework (CSF) 2.0*](https://www.nist.gov/publications/nist-cybersecurity-framework-csf-20).
- Center for Internet Security. (2024). [*CIS Critical Security Controls, versión 8.1*](https://www.cisecurity.org/controls/v8-1).
- MITRE. (s. f.). [*MITRE ATT&CK Enterprise Matrix*](https://attack.mitre.org/matrices/enterprise/).
- Joint Task Force. (2020). [*Security and Privacy Controls for Information Systems and Organizations* (NIST SP 800-53 Rev. 5)](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final). National Institute of Standards and Technology.
- National Institute of Standards and Technology. (2012). [*Guide for Conducting Risk Assessments* (NIST SP 800-30 Rev. 1)](https://csrc.nist.gov/pubs/sp/800/30/r1/final).
- National Institute of Standards and Technology. (2025). [*Integrating Cybersecurity and Enterprise Risk Management* (NIST IR 8286 Rev. 1)](https://csrc.nist.gov/pubs/ir/8286/r1/final).
- National Institute of Standards and Technology. (2010). [*Contingency Planning Guide for Federal Information Systems* (NIST SP 800-34 Rev. 1)](https://csrc.nist.gov/pubs/sp/800/34/r1/upd1/final).
- National Institute of Standards and Technology. (2025). [*Incident Response Recommendations and Considerations for Cybersecurity Risk Management* (NIST SP 800-61 Rev. 3)](https://csrc.nist.gov/pubs/sp/800/61/r3/final).
- Cybersecurity and Infrastructure Security Agency. (s. f.). [*Incident and Vulnerability Response Playbooks*](https://www.cisa.gov/resources-tools/resources/federal-government-cybersecurity-incident-and-vulnerability-response-playbooks).
- Snort. (s. f.). [*Snort 3 Rule Writing Guide*](https://docs.snort.org/).
- OWASP Foundation. (s. f.). [*Application Security Verification Standard*](https://owasp.org/www-project-application-security-verification-standard/).
- OWASP Foundation. (s. f.). [*Web Security Testing Guide*](https://owasp.org/www-project-web-security-testing-guide/).

Las normas ISO/IEC 27001, ISO/IEC 27002, ISO/IEC 27005 e ISO 22301 son referencias relevantes para gestión, controles, riesgo y continuidad. Sus fichas públicas pueden consultarse en el sitio de ISO, pero el texto completo normalmente requiere acceso institucional o compra.
