import 'package:flutter/material.dart';

import '../models/negocio.dart';
import '../services/conecta_cruz_repository.dart';
import '../widgets/negocio_card.dart';
import 'detalle_negocio_page.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key, required this.repository});

  final ConectaCruzRepository repository;

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  late Future<List<Negocio>> _future;
  String _busqueda = '';

  @override
  void initState() {
    super.initState();
    _future = widget.repository.obtenerNegocios();
  }

  void _recargar() => setState(() {
    _future = widget.repository.obtenerNegocios();
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Locales nocturnos'),
      actions: [
        IconButton(
          onPressed: _recargar,
          tooltip: 'Actualizar catálogo',
          icon: const Icon(Icons.refresh),
        ),
      ],
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Buscar local o comida',
              hintText: 'Ej.: hamburguesas',
              prefixIcon: Icon(Icons.search),
            ),
            textInputAction: TextInputAction.search,
            onChanged: (value) => setState(() {
              _busqueda = value.trim().toLowerCase();
            }),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Negocio>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const _Estado(
                  icon: Icons.cloud_download_outlined,
                  title: 'Cargando locales…',
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                final esTiempoAgotado = snapshot.error.toString().contains(
                  'TimeoutException',
                );
                return _Estado(
                  icon: Icons.cloud_off_outlined,
                  title: 'No pudimos cargar el catálogo',
                  message: esTiempoAgotado
                      ? 'La conexión tardó demasiado. Comprueba internet y pulsa Reintentar.'
                      : 'Comprueba tu conexión a internet y vuelve a intentarlo.',
                  action: FilledButton.icon(
                    onPressed: _recargar,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                );
              }

              final negocios = snapshot.data ?? const <Negocio>[];
              final visibles = negocios
                  .where((negocio) {
                    if (_busqueda.isEmpty) return true;
                    return negocio.nombre.toLowerCase().contains(_busqueda) ||
                        negocio.rubro.toLowerCase().contains(_busqueda) ||
                        negocio.descripcion.toLowerCase().contains(_busqueda);
                  })
                  .toList(growable: false);

              if (negocios.isEmpty) {
                return const _Estado(
                  icon: Icons.storefront_outlined,
                  title: 'Todavía no hay locales publicados',
                  message: 'Vuelve pronto para descubrir nuevas opciones.',
                );
              }
              if (visibles.isEmpty) {
                return const _Estado(
                  icon: Icons.search_off,
                  title: 'Sin resultados',
                  message: 'Prueba otra palabra o rubro.',
                );
              }

              return RefreshIndicator(
                onRefresh: () async => _recargar(),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: visibles.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final negocio = visibles[index];
                    return NegocioCard(
                      negocio: negocio,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => DetalleNegocioPage(
                            negocio: negocio,
                            repository: widget.repository,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

class _Estado extends StatelessWidget {
  const _Estado({
    required this.icon,
    required this.title,
    this.message,
    this.child,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? child;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 72, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(message!, textAlign: TextAlign.center),
          ],
          if (child != null) ...[const SizedBox(height: 20), child!],
          if (action != null) ...[const SizedBox(height: 20), action!],
        ],
      ),
    ),
  );
}
