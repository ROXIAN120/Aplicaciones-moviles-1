class Producto {
  const Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precioBs,
    required this.imagenUrl,
  });

  factory Producto.fromMap(Map<String, dynamic> map) => Producto(
    id: map['id'] as int,
    nombre: map['nombre'] as String,
    descripcion: map['descripcion'] as String,
    precioBs: (map['precio_bs'] as num).toDouble(),
    imagenUrl: map['imagen_url'] as String,
  );

  final int id;
  final String nombre;
  final String descripcion;
  final double precioBs;
  final String imagenUrl;
}
