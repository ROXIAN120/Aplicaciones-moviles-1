import 'package:flutter/material.dart';

import '../models/negocio.dart';

class NegocioCard extends StatelessWidget {
  const NegocioCard({super.key, required this.negocio, required this.onTap});

  final Negocio negocio;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Abrir ${negocio.nombre}, ${negocio.rubro}',
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  negocio.imagenUrl,
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 104,
                    height: 104,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    alignment: Alignment.center,
                    child: const Icon(Icons.storefront_outlined, size: 42),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      negocio.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Chip(
                      visualDensity: VisualDensity.compact,
                      avatar: const Icon(Icons.category_outlined, size: 16),
                      label: Text(negocio.rubro),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      negocio.descripcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            negocio.direccion,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
