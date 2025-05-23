import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/produto_controller.dart';

Future<void> setupInjector() async {
  final injector = Injector.appInstance;
  final prefs = await SharedPreferences.getInstance();

  injector.registerSingleton<SharedPreferences>(() => prefs);
  injector.registerSingleton<ProdutoController>(() => ProdutoController());
}
