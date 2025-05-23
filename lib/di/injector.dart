import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/http/http_client.dart';
import '../shared/http/dio_client.dart';
import '../services/produto_service.dart';
import '../controllers/produto_controller.dart';

Future<void> setupInjector() async {
  final injector = Injector.appInstance;
  final prefs = await SharedPreferences.getInstance();

  // Shared Preferences
  injector.registerSingleton<SharedPreferences>(() => prefs);

  // HTTP Client
  injector.registerSingleton<IHttpClient>(
    () => DioClient(baseUrl: 'https://api.example.com'),
  );

  // Services
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
}
