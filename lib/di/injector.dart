import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/http/http_client.dart';
import '../shared/http/dio_client.dart';
import '../features/produtos/services/produto_service.dart';
import '../features/produtos/controllers/produto_controller.dart';
import '../services/dashboard_service.dart';

Future<void> setupInjector() async {
  try {
    final injector = Injector.appInstance;
    final prefs = await SharedPreferences.getInstance();

    // Shared Preferences
    injector.registerSingleton<SharedPreferences>(() => prefs);

    // HTTP Client
    injector.registerSingleton<IHttpClient>(
      () => DioClient(baseUrl: 'http://localhost:3000/api'),
    );

    // Services
    injector.registerSingleton<DashboardService>(
      () => DashboardService(),
    );

    injector.registerSingleton<IProdutoService>(
      () => ProdutoService(injector.get<IHttpClient>()),
    );

    // Controllers
    injector.registerSingleton<ProdutoController>(
      () => ProdutoController(
        injector.get<IProdutoService>(),
        injector.get<SharedPreferences>(),
      ),
    );

    // Verifica se o DashboardService está registrado
    try {
      injector.get<DashboardService>();
    } catch (e) {
      throw Exception('DashboardService não está registrado!');
    }
  } catch (e) {
    print('Erro ao configurar injector: $e');
    rethrow;
  }
}
