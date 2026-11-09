import 'package:conecta_cruz/main.dart';
import 'package:conecta_cruz/models/negocio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('abre el catálogo desde la bienvenida y permite volver', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ConectaCruzApp());

    expect(find.text('ConectaCruz'), findsOneWidget);
    expect(find.text('Sabor Cruceño'), findsNothing);
    await tester.tap(find.text('Ver negocios'));
    await tester.pumpAndSettle();

    expect(find.text('Sabor Cruceño'), findsOneWidget);
    expect(negociosDemo, hasLength(6));

    await tester.scrollUntilVisible(find.text('Arte Guaraní'), 250);

    expect(find.text('Arte Guaraní'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Ver negocios'), findsOneWidget);
  });
}
