import 'dart:async';
import 'package:admin/src/features/authentication/data/models/user_model.dart';
import 'package:admin/src/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _authStateController = StreamController<UserModel?>.broadcast();
  UserModel? _currentUser;

  @override
  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  @override
  Future<UserModel?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<UserModel?> signIn(String email, String password) async {
    if (email == 'admin@example.com' && password == 'admin123') {
      _currentUser = UserModel(
        id: '1',
        email: email,
        name: 'Administrador',
        photoUrl: null,
      );
      _authStateController.add(_currentUser);
      return _currentUser;
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _authStateController.add(null);
  }

  void dispose() {
    _authStateController.close();
  }
}
