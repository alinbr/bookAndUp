import 'package:books_app_up/infrastructure/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authProvider = Provider<BaseAuthService>(
    (ref) => FirebaseAuthService(ref.watch(firebaseAuthProvider)));

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

enum AuthMode {
  login,
  registration,
}

final authModeProvider = StateNotifierProvider<AuthController, AuthMode>((ref) {
  return AuthController(ref.watch(authProvider));
});

class AuthController extends StateNotifier<AuthMode> {
  final BaseAuthService _authService;

  AuthController(this._authService) : super(AuthMode.registration);

  changeState(AuthMode newState) {
    state = newState;
  }

  Future<String> signUp(String email, String password) async {
    return await _authService.signUpWithEmailAndPassword(email, password);
  }

  Future<String> signIn(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(email, password);
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Password must have at least 6 characters";
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    if (!value.contains("@")) {
      return "Invalid email";
    }
    return null;
  }

  String? validateRepeatPassword(String? value, String? password) {
    if (state == AuthMode.registration && value != password) {
      return "Passwords does not match!";
    }
    return null;
  }
}
