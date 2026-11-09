class Negocio {
  const Negocio({
    required this.nombre,
    required this.rubro,
    required this.descripcion,
    required this.imagen,
  });

  final String nombre;
  final String rubro;
  final String descripcion;
  final String imagen;
}

const List<Negocio> negociosDemo = [
  Negocio(
    nombre: 'Sabor Cruceño',
    rubro: 'Gastronomía',
    descripcion: 'Comida típica cruceña preparada al momento.',
    imagen: 'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=600&q=80',
  ),
  Negocio(
    nombre: 'Café de la Plaza',
    rubro: 'Gastronomía',
    descripcion: 'Café, postres y opciones para compartir.',
    imagen: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=600&q=80',
  ),
  Negocio(
    nombre: 'Rutas del Piraí',
    rubro: 'Turismo',
    descripcion: 'Recorridos locales junto al río Piraí.',
    imagen: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=600&q=80',
  ),
  Negocio(
    nombre: 'Aventura Samaipata',
    rubro: 'Turismo',
    descripcion: 'Experiencias de naturaleza cerca de Santa Cruz.',
    imagen: 'https://images.unsplash.com/photo-1500534623283-312aade485b7?auto=format&fit=crop&w=600&q=80',
  ),
  Negocio(
    nombre: 'Manos Chiquitanas',
    rubro: 'Artesanía',
    descripcion: 'Piezas artesanales inspiradas en la Chiquitanía.',
    imagen: 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?auto=format&fit=crop&w=600&q=80',
  ),
  Negocio(
    nombre: 'Arte Guaraní',
    rubro: 'Artesanía',
    descripcion: 'Regalos hechos a mano con identidad local.',
    imagen: 'https://images.unsplash.com/photo-1452860606245-08befc0ff44b?auto=format&fit=crop&w=600&q=80',
  ),
];
