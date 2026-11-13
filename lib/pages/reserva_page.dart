import 'package:flutter/material.dart';

import '../core/validadores.dart';
import '../models/negocio.dart';
import '../services/conecta_cruz_repository.dart';

class ReservaPage extends StatefulWidget {
  const ReservaPage({
    super.key,
    required this.negocio,
    required this.repository,
  });

  final Negocio negocio;
  final ConectaCruzRepository repository;

  @override
  State<ReservaPage> createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _telefono = TextEditingController();
  final _personas = TextEditingController(text: '2');
  DateTime? _fecha;
  TimeOfDay? _hora;
  bool _enviando = false;
  String? _errorFechaHora;

  @override
  void dispose() {
    _nombre.dispose();
    _telefono.dispose();
    _personas.dispose();
    super.dispose();
  }

  DateTime? get _fechaHora {
    if (_fecha == null || _hora == null) return null;
    return DateTime(
      _fecha!.year,
      _fecha!.month,
      _fecha!.day,
      _hora!.hour,
      _hora!.minute,
    );
  }

  Future<void> _seleccionarFecha() async {
    final ahora = DateTime.now();
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime(ahora.year, ahora.month, ahora.day),
      lastDate: ahora.add(const Duration(days: 365)),
      initialDate: _fecha ?? ahora.add(const Duration(days: 1)),
      helpText: 'Selecciona la fecha de reserva',
    );
    if (value != null) setState(() => _fecha = value);
  }

  Future<void> _seleccionarHora() async {
    final value = await showTimePicker(
      context: context,
      initialTime: _hora ?? const TimeOfDay(hour: 20, minute: 0),
      helpText: 'Selecciona la hora de reserva',
    );
    if (value != null) setState(() => _hora = value);
  }

  Future<void> _enviar() async {
    FocusScope.of(context).unfocus();
    final formValido = _formKey.currentState?.validate() ?? false;
    final fechaHora = _fechaHora;
    setState(() {
      _errorFechaHora = fechaHora == null
          ? 'Selecciona la fecha y la hora.'
          : !fechaHora.isAfter(DateTime.now())
          ? 'La reserva debe ser para una fecha y hora futuras.'
          : null;
    });
    if (!formValido || _errorFechaHora != null || _enviando) return;

    setState(() => _enviando = true);
    try {
      await widget.repository.enviarReserva(
        negocioId: widget.negocio.id,
        nombre: _nombre.text,
        telefono: _telefono.text,
        fechaHora: fechaHora!,
        personas: int.parse(_personas.text.trim()),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reserva enviada correctamente.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se pudo guardar la reserva. Revisa tu conexión e inténtalo otra vez.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  String _fechaTexto(BuildContext context) => _fecha == null
      ? 'Elegir fecha'
      : MaterialLocalizations.of(context).formatMediumDate(_fecha!);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Realizar reserva')),
    body: SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              widget.negocio.nombre,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            const Text(
              'Selecciona un horario futuro y confirma los datos de contacto.',
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nombre,
              validator: Validadores.nombre,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telefono,
              validator: Validadores.telefono,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              maxLength: 8,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                hintText: 'Ej.: 70000000',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _personas,
              validator: Validadores.personas,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cantidad de personas',
                prefixIcon: Icon(Icons.groups_outlined),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _enviando ? null : _seleccionarFecha,
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(_fechaTexto(context)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _enviando ? null : _seleccionarHora,
                    icon: const Icon(Icons.schedule),
                    label: Text(
                      _hora == null ? 'Elegir hora' : _hora!.format(context),
                    ),
                  ),
                ),
              ],
            ),
            if (_errorFechaHora != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorFechaHora!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _enviando ? null : _enviar,
              icon: _enviando
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.event_available_outlined),
              label: Text(_enviando ? 'Guardando…' : 'Confirmar reserva'),
            ),
          ],
        ),
      ),
    ),
  );
}
