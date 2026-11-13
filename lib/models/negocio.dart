class Negocio {
  const Negocio({
    required this.id,
    required this.nombre,
    required this.rubro,
    required this.descripcion,
    required this.imagenUrl,
    required this.telefono,
    required this.direccion,
  });

  factory Negocio.fromMap(Map<String, dynamic> map) => Negocio(
    id: map['id'] as int,
    nombre: map['nombre'] as String,
    rubro: map['rubro'] as String,
    descripcion: map['descripcion'] as String,
    imagenUrl: map['imagen_url'] as String,
    telefono: map['telefono'] as String,
    direccion: map['direccion'] as String,
  );

  final int id;
  final String nombre;
  final String rubro;
  final String descripcion;
  final String imagenUrl;
  final String telefono;
  final String direccion;
}
