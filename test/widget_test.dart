import 'package:conecta_cruz/main.dart';
import 'package:conecta_cruz/models/negocio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra el catálogo con seis negocios', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ConectaCruzApp());

    expect(find.text('ConectaCruz'), findsOneWidget);
    expect(find.text('Sabor Cruceño'), findsOneWidget);
    expect(negociosDemo, hasLength(6));

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pump();

    expect(find.text('Arte Guaraní'), findsOneWidget);
  });
}
