import 'package:admin/src/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:admin/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:admin/src/features/authentication/application/usecases/get_current_user_usecase.dart';
import 'package:admin/src/features/authentication/application/usecases/sign_in_usecase.dart';
import 'package:admin/src/features/authentication/application/usecases/sign_out_usecase.dart';
import 'package:admin/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:admin/src/shared/menu_app/controllers/menu_app_controller.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repositories
  injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // Use Cases
  injector.registerLazySingleton(() => SignInUseCase(injector()));
  injector.registerLazySingleton(() => SignOutUseCase(injector()));
  injector.registerLazySingleton(() => GetCurrentUserUseCase(injector()));

  // Controllers
  final authController = await AuthController.initialize(
    signInUseCase: injector(),
    signOutUseCase: injector(),
    getCurrentUserUseCase: injector(),
    authRepository: injector(),
  );

  injector.registerSingleton(authController);
  injector.registerLazySingleton(() => MenuAppController());
}
