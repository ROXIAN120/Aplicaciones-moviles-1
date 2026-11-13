import 'package:conecta_cruz/main.dart';
import 'package:conecta_cruz/models/negocio.dart';
import 'package:conecta_cruz/models/producto.dart';
import 'package:conecta_cruz/services/conecta_cruz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('carga el catálogo una sola vez y abre el detalle', (
    WidgetTester tester,
  ) async {
    final repository = _FakeRepository();
    await tester.pumpWidget(ConectaCruzApp(repository: repository));

    expect(find.text('Express GO'), findsOneWidget);
    await tester.tap(find.text('Explorar locales'));
    await tester.pumpAndSettle();

    expect(find.text('Sabor Cruceño'), findsOneWidget);
    expect(repository.lecturasNegocios, 1);

    await tester.tap(find.text('Sabor Cruceño'));
    await tester.pumpAndSettle();
    expect(find.text('Productos y servicios'), findsOneWidget);
    expect(find.text('Majadito tradicional'), findsOneWidget);
    expect(repository.lecturasProductos, 1);
  });

  testWidgets('muestra errores de validación en la consulta', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final repository = _FakeRepository();
    await tester.pumpWidget(ConectaCruzApp(repository: repository));
    await tester.tap(find.text('Explorar locales'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sabor Cruceño'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Consultar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Enviar consulta'));
    await tester.pump();

    expect(find.text('Ingresa tu nombre.'), findsOneWidget);
    expect(find.text('Ingresa tu teléfono.'), findsOneWidget);
    expect(find.text('Escribe tu consulta.'), findsOneWidget);
    expect(repository.consultas, 0);
  });
}

class _FakeRepository implements ConectaCruzRepository {
  int lecturasNegocios = 0;
  int lecturasProductos = 0;
  int consultas = 0;

  static const negocio = Negocio(
    id: 1,
    nombre: 'Sabor Cruceño',
    rubro: 'Gastronomía',
    descripcion: 'Comida tradicional de Santa Cruz.',
    imagenUrl: 'https://invalid.local/negocio.jpg',
    telefono: '70000000',
    direccion: 'Centro, Santa Cruz de la Sierra',
  );

  @override
  Future<List<Negocio>> obtenerNegocios() async {
    lecturasNegocios++;
    return const [negocio];
  }

  @override
  Future<List<Producto>> obtenerProductos(int negocioId) async {
    lecturasProductos++;
    return const [
      Producto(
        id: 1,
        nombre: 'Majadito tradicional',
        descripcion: 'Arroz, charque, huevo y plátano.',
        precioBs: 35,
        imagenUrl: 'https://invalid.local/producto.jpg',
      ),
    ];
  }

  @override
  Future<void> enviarConsulta({
    required int negocioId,
    required String nombre,
    required String telefono,
    required String mensaje,
  }) async {
    consultas++;
  }

  @override
  Future<void> enviarReserva({
    required int negocioId,
    required String nombre,
    required String telefono,
    required DateTime fechaHora,
    required int personas,
  }) async {}
}
