import 'package:admin/src/features/authentication/data/models/user_model.dart';
import 'package:admin/src/features/authentication/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<UserModel?> execute(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email e senha são obrigatórios');
    }

    if (!email.contains('@')) {
      throw Exception('Email inválido');
    }

    return _repository.signIn(email, password);
  }
}
