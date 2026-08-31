---
title: "Instalación de las VMs - Lección 04"
tags:
  - nota
  - course
  - curso
institution: CFT San Antonio
course: INF44 - Gestión de la Seguridad
unit: UA1 - Vectores de ataque y controles de seguridad
lesson: "04"
author: Jordy
created_at: 2026-08-29
aliases:
  - "Instalación de las VMs - Lección 04"
---
# Instalación de las VMs - Lección 04

## 1. Importar

Descarga `SERVIDOR-LAB.ova` y `CLIENTE-LAB.ova`. En VirtualBox: **Archivo → Importar servicio virtualizado**, y repite con el segundo archivo.

Acepta la configuración que trae cada uno. No cambies memoria ni procesadores.

## 2. Comprobar la red

En **cada** VM: **Configuración → Red → Adaptador 1**. Debe decir:

| Campo | Valor |
| --- | --- |
| Conectado a | Red interna |
| Nombre | `lab_seguridad` |

Escrito idéntico en las dos. VirtualBox no valida ese campo: si una dice `lab_seguridad` y la otra `lab-seguridad`, quedan en redes separadas y no se ven, sin ningún mensaje de error.

**No habilites NAT, puente ni adaptadores adicionales.** El laboratorio trabaja aislado, y comprobarlo es parte de la fase 1.

## 3. Crear la instantánea

Con **ambas VMs apagadas**, en cada una: **Instantáneas → Tomar**, con el nombre `LAB04-INICIAL`.

Este paso no es opcional. La exportación a OVA no conserva las instantáneas del docente, así que tu copia llega sin ninguna. La actividad exige un punto de restauración antes de modificar `sudoers`, SSH o UFW: si algo sale mal durante la evaluación, es lo que te permite volver a empezar en segundos en vez de perder el laboratorio.

El **paso 0 de la etapa A** de la actividad te pedirá comprobar que esta instantánea existe, y es la fila `snapshot` de `linea_base.csv`. Si llegas a clase sin ella, pierdes tiempo de laboratorio creándola.

## 4. Comprobar que arrancan

Enciende las dos. Inicia sesión con las credenciales que entregó el docente.

Desde `CLIENTE-LAB`:

```bash
ip -br addr
```

```bash
ping -c 2 10.10.10.20
```

```bash
ping -c 2 10.20.20.20
```

Debes ver `enp0s3` con las direcciones `10.10.10.10/24` y `10.20.20.10/24`, y ambos ping respondiendo.

```bash
ip route
```

**No debe aparecer ninguna línea `default`.** Esa ausencia es el aislamiento del laboratorio.

Si algún ping falla, revisa el paso 2: casi siempre es una diferencia en el nombre de la red interna.

## Qué contiene cada VM

| VM | Direcciones | Rol |
| --- | --- | --- |
| `SERVIDOR-LAB` | 10.10.10.20 y 10.20.20.20 | SSH, `sudoers` y UFW |
| `CLIENTE-LAB` | 10.10.10.10 y 10.20.20.10 | Origina las conexiones de prueba |

Ambas llegan con las cuentas `admin01`, `soporte01` y `auditor01` creadas y con sus roles asignados, SSH activo, y **UFW instalado pero inactivo**. Activarlo y escribir su política es parte de lo que se evalúa.

Las credenciales las entrega el docente por separado; no están en ningún archivo del paquete.
