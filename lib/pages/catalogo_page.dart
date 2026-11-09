import 'package:flutter/material.dart';

import '../models/negocio.dart';
import '../widgets/negocio_card.dart';

class CatalogoPage extends StatelessWidget {
  const CatalogoPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ConectaCruz'), centerTitle: true),
    body: ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: negociosDemo.length,
      itemBuilder: (context, index) => NegocioCard(
        key: Key('negocio-${negociosDemo[index].nombre}'),
        negocio: negociosDemo[index],
      ),
    ),
  );
}
