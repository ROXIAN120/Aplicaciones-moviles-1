import '../models/negocio.dart';
import '../models/producto.dart';

abstract class ConectaCruzRepository {
  Future<List<Negocio>> obtenerNegocios();

  Future<List<Producto>> obtenerProductos(int negocioId);

  Future<void> enviarConsulta({
    required int negocioId,
    required String nombre,
    required String telefono,
    required String mensaje,
  });

  Future<void> enviarReserva({
    required int negocioId,
    required String nombre,
    required String telefono,
    required DateTime fechaHora,
    required int personas,
  });
}
