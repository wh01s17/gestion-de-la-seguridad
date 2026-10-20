---
title: "Actividad Lección 11 - Política de acceso remoto y auditoría en VM"
tags: [nota, course, curso, actividad, laboratorio]
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA2 - Gestión de riesgos y políticas de seguridad
lesson: "11"
author: Jordy
start: 2026-10-20
end: 2026-10-26
created_at: 2026-09-29
aliases:
  - "Actividad Lección 11 - Política de acceso remoto y auditoría en VM"
---

# Actividad Lección 11 - Política de acceso remoto y auditoría en VM

- **Modalidad:** laboratorio en parejas y entrega individual.
- **Duración:** 120 minutos.
- **Caso:** PACÍFICO RETAIL, política de acceso remoto y prueba de un control en VM.
- **Producto:** `plantilla-entrega-leccion-11.docx` completada, con las evidencias dentro del mismo archivo.

Vas a escribir reglas de acceso y comprobar una en dos máquinas virtuales. **Una política indica qué se debe cumplir; una evidencia permite comprobarlo.** Usa la guía de comandos si necesitas entender una orden y la guía de lectura para repasar conceptos.

## Caso y borrador

Los códigos vienen del caso de las lecciones 9 y 10: **R = riesgo** (lo que podría ocurrir) y **H = hallazgo** (lo observado y su estado de validación). El número identifica el registro, no su gravedad. Estos antecedentes permiten trabajar sin consultar esas actividades:

| Riesgo | Hecho disponible | Responsable |
| --- | --- | --- |
| R-01 · Uso de cuenta de exempleado | Una cuenta siguió activa 47 días tras la desvinculación; no se comprueban las bajas. | Recursos Humanos |
| R-03 · Acceso con contraseña robada | Siete personas acceden desde casa solo con contraseña; hay 3.400 intentos fallidos sin revisar. **H-01** confirma que el panel está expuesto y solo pide contraseña. | Gerencia comercial |
| R-06 · Abuso de cuenta técnica | `svc_backup` controla el sitio y los respaldos sin segundo factor. | Tecnología |

No se demostró acceso indebido ni cierre de H-01. **H-02** requiere confirmar si una IP pertenece a la empresa; **H-03**, si se aplicó el parche de CartPlus. Mantén el presupuesto de L10. Del **25 de octubre al 5 de diciembre** los cambios en producción necesitan una excepción autorizada.

En las VM entregadas, el problema **LAB11-SSH** consiste en que el firewall UFW permite llegar a SSH desde cualquier origen. **SSH permite abrir una terminal remota; UFW decide qué conexiones pueden entrar.** Corregir esa regla no corrige el panel H-01 de la empresa.

**Borrador ficticio PR-AR 0.1, sin aprobación:**

> Los usuarios pueden conectarse remotamente cuando lo necesiten. Se recomienda MFA y equipos seguros. Los proveedores pueden compartir una cuenta para facilitar el soporte. Se permitirán los servicios y horarios necesarios. Tecnología dará de baja los accesos cuando reciba el aviso. Se guardarán registros cuando sea posible. Las excepciones durarán mientras sean necesarias. La política se revisará cuando haya problemas.

En la **sección 1 del DOCX**, registra cuatro problemas del borrador, su posible consecuencia y el dato que falta para comprobar cada regla. Anota también el riesgo elegido y su relación con el tratamiento de L10.

## Paso 1 - Escribir qué debe cumplirse

Antes de cambiar UFW, escribe en la **sección 1 del DOCX** una obligación con responsable, acción, origen permitido, momento de revisión y evidencia. Ejemplo:

> El administrador de red debe permitir SSH (TCP/22) solo desde `10.10.10.0/24`. Después de cada cambio comprobará un acceso permitido y otro denegado, y guardará las reglas y los resultados.

Esta obligación corresponde a AR-03 de la política. La probarás en el laboratorio; las otras tres obligaciones solo tendrán un plan de comprobación.

## Paso 2 - Revisar el estado inicial

Abre las terminales desde las ventanas de las VM en VirtualBox: esa es la **consola local**. Usa las cuentas y contraseñas entregadas por el docente; al escribir una contraseña no aparecen caracteres.

1. Importa los OVA preparados por el docente. En VirtualBox, comprueba que las dos VM usen únicamente la red interna `lab_seguridad`.
2. **Cliente, como `docente`:** ejecuta `ip -br addr` e `ip route`. Deben aparecer `10.10.10.10/24` y `10.20.20.10/24`, sin línea `default` (ruta de salida a otras redes). Comprueba la comunicación:

   ```bash
   ping -c 2 10.10.10.20
   ping -c 2 10.20.20.20
   ```

3. **Consola local del servidor, como `admin01`:** revisa IP y rutas con los mismos comandos. Deben aparecer `10.10.10.20/24` y `10.20.20.20/24`, sin `default`. Consulta el firewall:

   ```bash
   sudo ufw status verbose
   sudo ufw status numbered
   ```

   Si `sudo` solicita contraseña, escribe la de `admin01`. UFW debe estar activo y mostrar `22/tcp ALLOW IN Anywhere` y el permiso `443/tcp`. `Anywhere` significa cualquier origen: esa es la regla demasiado amplia. Si el estado o la red son distintos, consulta al docente.

4. **Cliente, como `docente`:** comprueba si desde la red de terminales se alcanza SSH:

   ```bash
   ssh -o ConnectTimeout=8 admin01@10.20.20.20
   ```

   Al pedir contraseña o confirmar la identidad del servidor, cancela con `Ctrl+C`. Esto demuestra que alcanzaste el servicio, aunque no hayas iniciado sesión.

Guarda estas salidas como **E1, E2 y E3** en la sección 7 del DOCX. No necesitas una captura por cada orden: puedes agruparlas si se leen bien.

## Paso 3 - Cambiar la regla y comprobar el resultado

### Cambiar UFW · servidor, consola local, `admin01`

Haz el cambio desde VirtualBox para conservar el acceso si te equivocas. Primero permite la red de administración y después elimina el permiso general:

```bash
sudo ufw allow from 10.10.10.0/24 to any port 22 proto tcp
sudo ufw delete allow 22/tcp
sudo ufw status numbered
sudo ufw status verbose
```

Comprueba tres cosas: SSH permitido solo desde `10.10.10.0/24`, entrada denegada por defecto y permiso `443/tcp` conservado. No debe quedar un permiso general SSH, tampoco `(v6)`. Guarda comandos y resultados como **E4**.

### Probar el acceso permitido · cliente, `docente`

```bash
ssh -o ConnectTimeout=8 admin01@10.10.10.20
```

Si aparece la pregunta de identidad del servidor, verifica la huella con el docente antes de aceptarla. Escribe la contraseña de **`admin01` del servidor**. Debes entrar y ver `admin01@servidor-lab:~$`. Guarda la prueba como **E5** y sal:

```bash
exit
```

Comprueba que volviste a `docente@cliente-lab:~$` antes de continuar.

### Probar el acceso denegado · cliente, `docente`

```bash
ssh -o ConnectTimeout=8 admin01@10.20.20.20
```

Debe mostrar `Connection timed out` sin pedir contraseña. Anota la hora: buscarás ese intento en el registro del servidor.

### Buscar el bloqueo · servidor, consola local, `docente`

Vuelve a la ventana del servidor en VirtualBox. Cierra la sesión local de `admin01` con `exit` e ingresa como **`docente`**. Comprueba que veas `docente@servidor-lab:~$` y ejecuta la siguiente orden; si `sudo` solicita contraseña, usa la de `docente`:

```bash
sudo journalctl -k --since -20min | grep 'UFW BLOCK' | tail -5
```

Busca una línea de la hora de la prueba con `SRC=10.20.20.10` (origen), `DST=10.20.20.20` (destino) y `DPT=22` (puerto). Guarda el intento denegado y ese extracto como **E6**. Si no aparece, escribe «causa no confirmada»: un tiempo agotado por sí solo no demuestra que UFW bloqueó la conexión.

## Paso 4 - Completar la entrega

Escribe frases breves y completa las tablas del DOCX. No copies las instrucciones ni repitas capturas.

| Sección del DOCX | Qué completar |
| --- | --- |
| 2 · Política | Cuatro obligaciones: AR-01, cuenta individual y MFA (más de un factor de autenticación); AR-03, origen, servicios y permisos; AR-04, terceros; AR-06, bajas e inactividad. Indica quién debe hacer qué, cuándo y con qué evidencia. Completa objetivo, alcance, roles, aprobación, revisión, excepciones e incumplimiento. |
| 3 · Plan y métricas | Tres hitos para aprobar/comunicar/capacitar, aplicar el cambio con opción de deshacerlo y comprobar resultados. Define dos medidas: cobertura MFA y cuentas inactivas. La plantilla indica qué datos incluir; no inventes resultados. |
| 4 · Auditoría | Para cada obligación, indica cómo la comprobarías y qué evidencia pedirías. Examinar = revisar documentos o configuración; entrevistar = preguntar al responsable; probar = ejecutar y observar. Muestra = qué casos revisarías y cuántos. |
| 5 · Problema y cierre | Qué incumplía la regla, qué corregiste, cómo evitarías que se repita, responsable, plazo y resultado necesario para dar el problema por resuelto. Explica los límites de la prueba. |
| 6 · Desarrollo seguro | Elige una opción D y una C de las síntesis incluidas. Conviértelas en dos obligaciones para el portal, con responsable, momento y evidencia. No debes programar. |
| 7 · Evidencias | E1: entorno; E2: UFW antes; E3: alcance inicial; E4: cambio y UFW después; E5: acceso permitido; E6: denegado y registro. Indica hora, resultado y origen de cada evidencia. |

En la auditoría, **solo AR-03 usa el laboratorio ejecutado** (o evidencia proporcionada, si así ocurrió). AR-01, AR-04 y AR-06 quedan como **«no ejecutado: diseño»**. Para AR-04 escribe tres preguntas abiertas al responsable interno de un proveedor y qué documento permitiría comprobar cada respuesta. No entrevistes a un compañero ni inventes respuestas.

La simulación demuestra una restricción SSH en las condiciones probadas. No demuestra MFA, no cierra H-01 y conservar `443/tcp` no prueba que exista un sitio HTTPS funcionando.

## Entrega y criterios

Entrega **un solo archivo**, `apellido-nombre-leccion-11.docx`, con respuestas individuales y evidencias incorporadas. Puedes compartir capturas con tu pareja; explica los resultados con tus propias palabras. El docente indicará fecha y canal de entrega. Si solicita PDF, exporta este mismo documento.

La actividad es formativa, sin nota. Los 20 puntos orientan la retroalimentación antes de la Evaluación UA2:

| Criterio | Puntos |
| --- | ---: |
| Riesgo y política: cuatro obligaciones claras, roles, excepciones y revisión. | 5 |
| Prueba SSH: estado inicial, cambio, estado final y dos pruebas con evidencia y límites. | 6 |
| Plan: tres hitos y dos métricas con fuentes y acciones. | 3 |
| Auditoría y cierre: cuatro validaciones, problema, acciones, responsable y criterio de cierre. | 4 |
| Desarrollo seguro: dos obligaciones adaptadas, con fuente, responsable y evidencia. | 2 |
| **Total** | **20** |

Si falla una VM, avisa al docente: puede darte salidas para analizar, identificándolas como proporcionadas. Guarda las evidencias antes de cerrar las VM. Si necesitas recuperar el escenario, consulta al docente para importar los OVA en copias separadas sin sobrescribir tu trabajo.
