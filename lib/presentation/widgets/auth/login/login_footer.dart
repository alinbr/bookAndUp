import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFooter extends ConsumerWidget {
  const LoginFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Not a member?'),
          TextButton(
              onPressed: () {
                ref
                    .read(authModeProvider.notifier)
                    .changeState(AuthMode.registration);
              },
              child: const Text("Register now!"))
        ],
      ),
    );
  }
}
