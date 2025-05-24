import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'http://localhost:3000';

  static String get apiUrl =>
      dotenv.env['API_URL'] ?? 'http://localhost:3000/api';

  static Future<void> init() async {
    // O dotenv já foi inicializado no main.dart
    // Aqui podemos adicionar outras configurações se necessário
  }
}
