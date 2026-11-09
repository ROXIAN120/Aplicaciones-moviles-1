import 'package:flutter/material.dart';

import 'pages/catalogo_page.dart';

void main() => runApp(const ConectaCruzApp());

class ConectaCruzApp extends StatelessWidget {
  const ConectaCruzApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ConectaCruz',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
      useMaterial3: true,
      cardTheme: const CardThemeData(elevation: 2, margin: EdgeInsets.zero),
    ),
    home: const BienvenidaPage(),
  );
}

class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key});

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
                Icons.location_city_rounded,
                size: 96,
                color: Color(0xFF1565C0),
              ),
              const SizedBox(height: 24),
              const Text(
                'ConectaCruz',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF17365D),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Conectamos pequeños negocios de\nSanta Cruz de la Sierra contigo.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Color(0xFF4B627A)),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const CatalogoPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.storefront_outlined),
                label: const Text('Ver negocios'),
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
