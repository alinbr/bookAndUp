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

final authModeProvider =
    StateProvider<AuthMode>((ref) => AuthMode.registration);
