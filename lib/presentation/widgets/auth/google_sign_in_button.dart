import 'package:books_app_up/application/providers.dart';
import 'package:books_app_up/presentation/widgets/core/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SignInButton(
      Buttons.Google,
      text: "Sign in with Google",
      onPressed: () async {
        String msg = await ref.read(authServiceProvider).signInWithGoogle();

        if (msg == "Signed in") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthWrapper(),
              ));
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        }

        return;
      },
      elevation: 6,
      padding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
