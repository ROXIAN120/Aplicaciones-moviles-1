import 'package:flutter/material.dart';

import '../models/negocio.dart';
import '../models/producto.dart';
import '../services/conecta_cruz_repository.dart';
import 'consulta_page.dart';
import 'reserva_page.dart';

class DetalleNegocioPage extends StatefulWidget {
  const DetalleNegocioPage({
    super.key,
    required this.negocio,
    required this.repository,
  });

  final Negocio negocio;
  final ConectaCruzRepository repository;

  @override
  State<DetalleNegocioPage> createState() => _DetalleNegocioPageState();
}

class _DetalleNegocioPageState extends State<DetalleNegocioPage> {
  late Future<List<Producto>> _productos;

  @override
  void initState() {
    super.initState();
    _productos = widget.repository.obtenerProductos(widget.negocio.id);
  }

  void _recargar() => setState(() {
    _productos = widget.repository.obtenerProductos(widget.negocio.id);
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.negocio.nombre)),
    body: ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        AspectRatio(
          aspectRatio: 16 / 8,
          child: Image.network(
            widget.negocio.imagenUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: const Icon(Icons.storefront_outlined, size: 80),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.negocio.nombre,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Chip(label: Text(widget.negocio.rubro)),
              const SizedBox(height: 8),
              Text(widget.negocio.descripcion),
              const SizedBox(height: 14),
              _Dato(
                icon: Icons.location_on_outlined,
                texto: widget.negocio.direccion,
              ),
              const SizedBox(height: 8),
              _Dato(icon: Icons.phone_outlined, texto: widget.negocio.telefono),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => ConsultaPage(
                            negocio: widget.negocio,
                            repository: widget.repository,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text('Consultar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => ReservaPage(
                            negocio: widget.negocio,
                            repository: widget.repository,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.event_available_outlined),
                      label: const Text('Reservar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Productos y servicios',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              FutureBuilder<List<Producto>>(
                future: _productos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return _MensajeProductos(
                      icon: Icons.cloud_off_outlined,
                      texto: 'No se pudieron cargar los productos.',
                      accion: TextButton.icon(
                        onPressed: _recargar,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reintentar'),
                      ),
                    );
                  }
                  final productos = snapshot.data ?? const <Producto>[];
                  if (productos.isEmpty) {
                    return const _MensajeProductos(
                      icon: Icons.inventory_2_outlined,
                      texto: 'Este negocio todavía no publicó productos.',
                    );
                  }
                  return Column(
                    children: productos
                        .map(
                          (producto) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _ProductoCard(producto: producto),
                          ),
                        )
                        .toList(growable: false),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Dato extends StatelessWidget {
  const _Dato({required this.icon, required this.texto});
  final IconData icon;
  final String texto;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
      const SizedBox(width: 8),
      Expanded(child: Text(texto)),
    ],
  );
}

class _ProductoCard extends StatelessWidget {
  const _ProductoCard({required this.producto});
  final Producto producto;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              producto.imagenUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 72,
                height: 72,
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(producto.descripcion),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Bs ${producto.precioBs.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    ),
  );
}

class _MensajeProductos extends StatelessWidget {
  const _MensajeProductos({
    required this.icon,
    required this.texto,
    this.accion,
  });
  final IconData icon;
  final String texto;
  final Widget? accion;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Icon(icon, size: 42),
        const SizedBox(height: 8),
        Text(texto, textAlign: TextAlign.center),
        ?accion,
      ],
    ),
  );
}
