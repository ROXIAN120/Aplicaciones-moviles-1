import 'package:flutter/material.dart';

import '../core/validadores.dart';
import '../models/negocio.dart';
import '../services/conecta_cruz_repository.dart';

class ConsultaPage extends StatefulWidget {
  const ConsultaPage({
    super.key,
    required this.negocio,
    required this.repository,
  });

  final Negocio negocio;
  final ConectaCruzRepository repository;

  @override
  State<ConsultaPage> createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _telefono = TextEditingController();
  final _mensaje = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    _nombre.dispose();
    _telefono.dispose();
    _mensaje.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false) || _enviando) return;
    setState(() => _enviando = true);
    try {
      await widget.repository.enviarConsulta(
        negocioId: widget.negocio.id,
        nombre: _nombre.text,
        telefono: _telefono.text,
        mensaje: _mensaje.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Consulta enviada correctamente.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se pudo enviar la consulta. Revisa tu conexión e inténtalo otra vez.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Enviar consulta')),
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
              'Completa tus datos. El negocio recibirá tu pregunta y podrá contactarte.',
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
              autofillHints: const [AutofillHints.telephoneNumber],
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                hintText: 'Ej.: 70000000',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _mensaje,
              validator: Validadores.mensaje,
              minLines: 4,
              maxLines: 6,
              maxLength: 1000,
              decoration: const InputDecoration(
                labelText: 'Consulta',
                hintText: 'Escribe una pregunta de al menos 10 caracteres.',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.chat_bubble_outline),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _enviando ? null : _enviar,
              icon: _enviando
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_outlined),
              label: Text(_enviando ? 'Enviando…' : 'Enviar consulta'),
            ),
          ],
        ),
      ),
    ),
  );
}
