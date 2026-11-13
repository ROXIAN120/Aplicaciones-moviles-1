class Validadores {
  const Validadores._();

  static String? nombre(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Ingresa tu nombre.';
    if (text.length < 2) return 'El nombre debe tener al menos 2 caracteres.';
    return null;
  }

  static String? telefono(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Ingresa tu teléfono.';
    if (!RegExp(r'^[67][0-9]{7}$').hasMatch(text)) {
      return 'Usa 8 dígitos y comienza con 6 o 7.';
    }
    return null;
  }

  static String? mensaje(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Escribe tu consulta.';
    if (text.length < 10) {
      return 'La consulta debe tener al menos 10 caracteres.';
    }
    return null;
  }

  static String? personas(String? value) {
    final number = int.tryParse(value?.trim() ?? '');
    if (number == null) return 'Ingresa una cantidad válida.';
    if (number < 1 || number > 50) {
      return 'La cantidad debe estar entre 1 y 50.';
    }
    return null;
  }
}
