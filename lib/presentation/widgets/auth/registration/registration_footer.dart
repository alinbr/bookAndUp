import 'package:books_app_up/application/auth/auth_enum.dart';
import 'package:books_app_up/application/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationFooter extends ConsumerWidget {
  const RegistrationFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already a member?'),
          TextButton(
              onPressed: () {
                ref
                    .read(authControllerProvider.notifier)
                    .changeState(AuthMode.login);
              },
              child: const Text("Login instead!"))
        ],
      ),
    );
  }
}
