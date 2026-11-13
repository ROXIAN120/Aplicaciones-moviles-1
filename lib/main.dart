import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/config.dart';
import 'pages/bienvenida_page.dart';
import 'services/conecta_cruz_repository.dart';
import 'services/supabase_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.validar();
  await Supabase.initialize(
    url: Config.supabaseUrl,
    publishableKey: Config.supabasePublishableKey,
  );
  runApp(const ConectaCruzApp());
}

class ConectaCruzApp extends StatelessWidget {
  const ConectaCruzApp({super.key, this.repository});

  final ConectaCruzRepository? repository;

  @override
  Widget build(BuildContext context) {
    final dataSource =
        repository ?? SupabaseRepository(Supabase.instance.client);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Express GO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6B00)),
        useMaterial3: true,
        cardTheme: const CardThemeData(elevation: 2, margin: EdgeInsets.zero),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
      home: BienvenidaPage(repository: dataSource),
    );
  }
}
