# Verificación de la Actividad 02

Fecha de verificación: 13 de noviembre de 2026
Proyecto Supabase: `uzgmzpesvvjdnlnwokkf` (producción)

La base contiene seis locales gastronómicos de Express GO: Hamburguesas 24, Pizza de Madrugada, Antojitos Camba, Tacos After, Salchipapas El Desvelo y Dulce Amanecer.

## Datos reales verificados

| Tabla | Filas verificadas |
|---|---:|
| negocios | 6 |
| productos | 12 |
| consultas | 3 |
| reservas | 3 |

Se verificaron tres consultas y tres reservas. Las inserciones finales se realizaron desde la APK release de Express GO para comprobar el flujo completo en la aplicación.

## Seguridad RLS

| Operación con cliente público | Resultado |
|---|---|
| Leer negocios activos | Permitido: 6 filas |
| Leer productos disponibles | Permitido: 12 filas |
| Insertar consulta válida | Permitido: HTTP 201 |
| Insertar reserva futura válida | Permitido: HTTP 201 |
| Modificar un negocio | Bloqueado: HTTP 401 |
| Leer consultas o reservas ajenas | No existe política pública de lectura |
| Actualizar o eliminar consultas/reservas | No existe permiso ni política pública |

## Pruebas de interfaz

| Caso | Resultado |
|---|---|
| Carga inicial del catálogo | Indicador de progreso visible |
| Catálogo remoto | Se muestran seis negocios |
| Espera remota prolongada | Finaliza a los 15 segundos y ofrece Reintentar |
| APK release en teléfono Android | Bienvenida y catálogo visibles |
| Detalle | Se cargan productos por negocio |
| Búsqueda sin coincidencias | Estado “Sin resultados” |
| Emulador sin conexión | Mensaje claro y botón “Reintentar” |
| Consulta vacía | Errores de nombre, teléfono y mensaje |
| Consulta válida | Se guarda y aparece confirmación |
| Reserva vacía | Errores de datos y fecha/hora |
| Reserva futura válida | Se guarda en Supabase |
| Botón durante el envío | Queda deshabilitado y muestra progreso |

## Pruebas automáticas

`flutter analyze --no-pub`: sin problemas.
`flutter test --no-pub`: 6 pruebas aprobadas.

La aplicación también fue verificada en un dispositivo Android físico. El catálogo de Express GO cargó datos reales después de corregir la espera indefinida mediante timeout.
