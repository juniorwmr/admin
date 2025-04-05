import 'package:admin/src/features/authentication/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> execute() async {
    await _repository.signOut();
  }
}
