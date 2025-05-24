import 'package:admin/di/injector.dart';
import 'package:admin/router.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:admin/services/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:injector/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());

  // Carrega as variáveis de ambiente
  await dotenv.load(fileName: '.env');

  // Configura o injetor de dependências
  await setupInjector();

  // Verifica se o DashboardService está registrado
  final injector = Injector.appInstance;
  try {
    injector.get<DashboardService>();
  } catch (e) {
    throw Exception('DashboardService não está registrado!');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      routerConfig: router,
      theme: AppTheme.darkTheme,
    );
  }
}
