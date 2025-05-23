import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'http://localhost:3000';

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }
}
