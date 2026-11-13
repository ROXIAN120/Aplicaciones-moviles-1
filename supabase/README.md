# Base de datos de ConectaCruz

Los scripts se ejecutan en orden y son idempotentes para facilitar la demostración:

1. `01_tablas.sql`: crea negocios, productos, consultas, reservas, pedidos y detalle de pedidos.
2. `02_rls_lectura.sql`: activa RLS en las seis tablas y permite leer únicamente negocios activos y productos disponibles.
3. `02b_datos_semilla.sql`: carga seis negocios y doce productos de ejemplo.
4. `03_escritura_publica.sql`: permite insertar consultas y reservas válidas, sin permitir lectura, actualización ni eliminación de datos ajenos.

La aplicación móvil se conecta con una clave publicable mediante `--dart-define`. Las claves privadas no pertenecen al repositorio ni al cliente móvil.
