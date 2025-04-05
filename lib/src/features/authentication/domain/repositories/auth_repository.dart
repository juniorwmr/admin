import 'package:admin/src/features/authentication/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signIn(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Stream<UserModel?> get authStateChanges;
}
