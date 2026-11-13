# Express GO

Express GO es una aplicación Flutter para descubrir pequeños negocios gastronómicos que atienden entre las 00:00 y las 06:00 en Santa Cruz de la Sierra. La Actividad 02 adapta el caso académico ConectaCruz a un catálogo nocturno con datos reales, consultas y reservas en Supabase.

## Datos del proyecto

- **Proyecto:** Express GO, adaptación del caso académico ConectaCruz.
- **Rubro:** gastronomía nocturna para pequeños negocios que atienden de 00:00 a 06:00.
- **Integrante:** Rodrigo Ledezma Sanchez.
- **Docente:** Jimmy Nataniel Requena Llorentty.
- **Materia:** Aplicaciones Móviles I.
- **Ubicación:** Santa Cruz de la Sierra, Bolivia.

## Actividad 01 · Frameworks móviles

- [Informe IMRyD de Express GO en PDF](entrega_actividad_01/Informe_IMRyD_ConectaCruz_Ampliado.pdf)
- [Presentación detallada de Express GO en PDF](entrega_actividad_01/Presentacion_Defensa_ConectaCruz.pdf)

## Evidencias de la Actividad 01

- [Capturas originales de flutter doctor](evidencias_actividad_01/flutter_doctor)
- [Bienvenida de ConectaCruz en el emulador Android](evidencias_actividad_01/bienvenida_emulador_actual.png)

## Actividad 02 · Express GO con Supabase

Esta versión reemplaza los datos locales por datos reales de Supabase e incluye:

- Catálogo y productos leídos con `FutureBuilder`.
- Estados de carga, error, lista vacía y reintento.
- Timeout de 15 segundos para evitar una carga indefinida.
- Navegación bienvenida → catálogo → detalle.
- Formularios de consulta y reserva con validaciones.
- Botones bloqueados mientras se envían los datos.
- Políticas RLS: lectura pública limitada, escritura validada y sin permisos de modificación.
- Pruebas automáticas y pruebas manuales documentadas.
- APK release instalada y verificada en un dispositivo Android.

### Entregables

- [Informe de la Actividad 02 en PDF](entrega_actividad_02/Informe_Actividad_02_Express_GO_Supabase.pdf)
- [Presentación de la Actividad 02](entrega_actividad_02/Presentacion_Actividad_02_Express_GO_Supabase.pptx)
- [Presentación en PDF](entrega_actividad_02/Presentacion_Actividad_02_Express_GO_Supabase.pdf)
- [APK ejecutable de Express GO](entrega_actividad_02/Express_GO_Actividad_02.apk)

### Ejecución segura

La URL y la clave publicable no se escriben directamente en el código fuente: se inyectan en tiempo de compilación. La APK incorpora esa configuración pública y puede ser inspeccionada, por lo que la protección real depende de RLS y de no usar credenciales secretas:

```powershell
flutter run --dart-define=SUPABASE_URL=https://uzgmzpesvvjdnlnwokkf.supabase.co --dart-define=SUPABASE_PUBLISHABLE_KEY=TU_CLAVE_PUBLICABLE
```

Nunca se debe usar una clave `secret` o `service_role` dentro de una aplicación móvil.

### Base de datos

Ejecutar en orden los scripts de [supabase](supabase):

1. `01_tablas.sql`
2. `02_rls_lectura.sql`
3. `02b_datos_semilla.sql`
4. `03_escritura_publica.sql`

El script `04_datos_express_go.sql` actualiza una base de la versión anterior con los seis locales gastronómicos nocturnos sin cambiar sus identificadores.

### Evidencias

- [Bienvenida de Express GO en un teléfono](evidencias_actividad_02/17_express_go_bienvenida_dispositivo.png)
- [Catálogo alimentado por Supabase](evidencias_actividad_02/18_express_go_catalogo_dispositivo.png)
- [Búsqueda local](evidencias_actividad_02/19_express_go_busqueda_dispositivo.png)
- [Detalle con productos reales](evidencias_actividad_02/20_express_go_detalle_productos_dispositivo.png)
- [Formulario de reserva](evidencias_actividad_02/21_express_go_reserva_dispositivo.png)
- [Formulario de consulta](evidencias_actividad_02/22_express_go_consulta_dispositivo.png)
- [Estado vacío](evidencias_actividad_02/23_express_go_estado_vacio.png)
- [Error de conexión y reintento](evidencias_actividad_02/24_express_go_error_conexion.png)
- [Consulta enviada correctamente desde la APK](evidencias_actividad_02/25_express_go_consulta_enviada.png)
- [Reserva enviada correctamente desde la APK](evidencias_actividad_02/26_express_go_reserva_enviada.png)
- [Filas verificadas en Supabase de producción](evidencias_actividad_02/27_supabase_filas_verificadas.png)
- [Panel oficial de Supabase con los conteos de las tablas](evidencias_actividad_02/28_supabase_panel_tablas.png)
- [Resultados de pruebas y verificación RLS](evidencias_actividad_02/resultado_pruebas.md)

La verificación final registró 6 negocios, 12 productos, 3 consultas y 3 reservas en el proyecto de producción.

## Código fuente

El proyecto está en la raíz del repositorio. Las pantallas están en [lib/pages](lib/pages), los modelos en [lib/models](lib/models), el acceso a Supabase en [lib/services](lib/services) y las pruebas en [test](test).
