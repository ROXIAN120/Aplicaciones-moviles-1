import 'package:flutter/material.dart';

import '../services/conecta_cruz_repository.dart';
import 'catalogo_page.dart';

class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key, required this.repository});

  final ConectaCruzRepository repository;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF5F8FC),
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.delivery_dining_rounded,
                size: 96,
                color: Color(0xFFFF6B00),
              ),
              const SizedBox(height: 24),
              const Text(
                'Express GO',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A2418),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Comida de madrugada, de pequeños negocios\nde Santa Cruz directamente para ti.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Color(0xFF4B627A)),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => CatalogoPage(repository: repository),
                  ),
                ),
                icon: const Icon(Icons.storefront_outlined),
                label: const Text('Explorar locales'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
