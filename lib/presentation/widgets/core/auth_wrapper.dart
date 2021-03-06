import 'package:books_app_up/application/providers.dart';
import 'package:books_app_up/presentation/screens/auth_screen.dart';
import 'package:books_app_up/presentation/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);

    return auth.when(
        data: (data) {
          if (data == null) {
            return const AuthScreen();
          }
          return const HomeScreen();
        },
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (_, __, ___) => const Text("error"));
  }
}
