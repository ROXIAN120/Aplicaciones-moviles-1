import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/negocio.dart';
import '../models/producto.dart';
import 'conecta_cruz_repository.dart';

class SupabaseRepository implements ConectaCruzRepository {
  const SupabaseRepository(this._db);

  final SupabaseClient _db;
  static const _tiempoLimite = Duration(seconds: 15);

  @override
  Future<List<Negocio>> obtenerNegocios() async {
    final rows = await _db
        .from('negocios')
        .select('id,nombre,rubro,descripcion,imagen_url,telefono,direccion')
        .order('nombre')
        .timeout(_tiempoLimite);
    return rows.map<Negocio>(Negocio.fromMap).toList(growable: false);
  }

  @override
  Future<List<Producto>> obtenerProductos(int negocioId) async {
    final rows = await _db
        .from('productos')
        .select('id,nombre,descripcion,precio_bs,imagen_url')
        .eq('negocio_id', negocioId)
        .order('nombre')
        .timeout(_tiempoLimite);
    return rows.map<Producto>(Producto.fromMap).toList(growable: false);
  }

  @override
  Future<void> enviarConsulta({
    required int negocioId,
    required String nombre,
    required String telefono,
    required String mensaje,
  }) async {
    await _db
        .from('consultas')
        .insert({
          'negocio_id': negocioId,
          'nombre_cliente': nombre.trim(),
          'telefono': telefono.trim(),
          'mensaje': mensaje.trim(),
        })
        .timeout(_tiempoLimite);
  }

  @override
  Future<void> enviarReserva({
    required int negocioId,
    required String nombre,
    required String telefono,
    required DateTime fechaHora,
    required int personas,
  }) async {
    await _db
        .from('reservas')
        .insert({
          'negocio_id': negocioId,
          'nombre_cliente': nombre.trim(),
          'telefono': telefono.trim(),
          'fecha': _fecha(fechaHora),
          'hora': _hora(fechaHora),
          'personas': personas,
        })
        .timeout(_tiempoLimite);
  }

  String _fecha(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  String _hora(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:'
      '${value.minute.toString().padLeft(2, '0')}:00';
}
