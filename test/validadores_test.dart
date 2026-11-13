import 'package:conecta_cruz/core/validadores.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validadores', () {
    test('acepta teléfono boliviano de ocho dígitos', () {
      expect(Validadores.telefono('70000000'), isNull);
      expect(Validadores.telefono('61234567'), isNull);
    });

    test('rechaza teléfono incompleto o que no comienza con 6/7', () {
      expect(Validadores.telefono('1234'), isNotNull);
      expect(Validadores.telefono('81234567'), isNotNull);
    });

    test('exige consulta de al menos diez caracteres', () {
      expect(Validadores.mensaje('Muy corta'), isNotNull);
      expect(Validadores.mensaje('¿Atienden pedidos esta noche?'), isNull);
    });

    test('limita la cantidad de personas entre uno y cincuenta', () {
      expect(Validadores.personas('0'), isNotNull);
      expect(Validadores.personas('2'), isNull);
      expect(Validadores.personas('51'), isNotNull);
    });
  });
}
