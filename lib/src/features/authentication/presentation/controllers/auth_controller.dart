import 'dart:convert';
import 'package:admin/src/features/authentication/application/usecases/get_current_user_usecase.dart';
import 'package:admin/src/features/authentication/application/usecases/sign_in_usecase.dart';
import 'package:admin/src/features/authentication/application/usecases/sign_out_usecase.dart';
import 'package:admin/src/features/authentication/data/models/user_model.dart';
import 'package:admin/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  bool get isAuthenticated => user != null;

  AuthState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthController extends ValueNotifier<AuthState> {
  static const String _userKey = 'user_data';
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final AuthRepository authRepository;

  AuthController({
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
    required this.authRepository,
  }) : super(const AuthState(isLoading: true));

  static Future<AuthController> initialize({
    required SignInUseCase signInUseCase,
    required SignOutUseCase signOutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required AuthRepository authRepository,
  }) async {
    final controller = AuthController(
      signInUseCase: signInUseCase,
      signOutUseCase: signOutUseCase,
      getCurrentUserUseCase: getCurrentUserUseCase,
      authRepository: authRepository,
    );

    await controller._init();
    return controller;
  }

  Future<void> _init() async {
    try {
      authRepository.authStateChanges.listen((user) {
        value = value.copyWith(user: user);
        _persistUserData(user);
      });

      await _loadPersistedUser();
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }

  Future<void> _persistUserData(UserModel? user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (user != null) {
        await prefs.setString(_userKey, jsonEncode(user.toJson(user)));
      } else {
        await prefs.remove(_userKey);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loadPersistedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson != null) {
        final user = UserModel.fromJson(jsonDecode(userJson));
        value = value.copyWith(user: user);
      }
    } catch (e) {
      value = value.copyWith(error: e.toString());
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      value = value.copyWith(isLoading: true, error: null);

      await Future.delayed(const Duration(seconds: 1));

      final user = await signInUseCase.execute(email, password);
      if (user != null) {
        value = value.copyWith(user: user);
        await _persistUserData(user);
      }
      return user != null;
    } catch (e) {
      value = value.copyWith(error: e.toString());
      return false;
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }

  Future<void> signOut() async {
    try {
      value = value.copyWith(isLoading: true, error: null);
      await signOutUseCase.execute();
      await _persistUserData(null);
      value = value.copyWith(user: null);
    } catch (e) {
      value = value.copyWith(error: e.toString());
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }

  Future<void> getCurrentUser() async {
    try {
      value = value.copyWith(isLoading: true, error: null);
      final user = await getCurrentUserUseCase.execute();
      if (user != null) {
        value = value.copyWith(user: user);
        await _persistUserData(user);
      }
    } catch (e) {
      value = value.copyWith(error: e.toString());
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }
}
