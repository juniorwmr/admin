import 'package:admin/src/features/authentication/data/models/user_model.dart';
import 'package:admin/src/features/authentication/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UserModel?> execute() async {
    return _repository.getCurrentUser();
  }
}
