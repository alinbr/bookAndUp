import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:books_app_up/presentation/widgets/auth/field_wrapper.dart';
import 'package:books_app_up/presentation/widgets/auth/my_sign_in_button.dart';
import 'package:books_app_up/presentation/widgets/auth/or_divider.dart';
import 'package:books_app_up/presentation/widgets/auth/sign_in_footer.dart';
import 'package:books_app_up/presentation/widgets/core/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEECF4),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffEEECF4), Colors.white],
                  stops: [0.5, 0.9],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  "Welcome back!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8),
                Text(
                  "Let's get you exploring books!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 32),
                _buildEmailField(context),
                _buildPasswordField(context),
                _buildSignInButton(context),
                const OrDivider(),
                const SizedBox(height: 32),
                SignInButton(
                  Buttons.Google,
                  text: "Sign in with Google",
                  onPressed: () async {
                    String msg =
                        await ref.read(authProvider).signInWithGoogle();

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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                const Spacer(),
                const SignInFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      child: MySignInButton(
        text: "Sign In",
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging in')),
            );

            String msg = await ref
                .read(authProvider)
                .signInWithEmailAndPassword(
                    _emailController.text, _passwordController.text);

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
          }
        },
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return FieldWrapper(
      textFormField: TextFormField(
        controller: _passwordController,
        validator: (value) {
          if (value == null || value.length < 6) {
            return "Password must have at least 6 characters";
          }

          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Password'),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return FieldWrapper(
      textFormField: TextFormField(
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email can't be empty";
          }
          if (!value.contains("@")) {
            return "Invalid email";
          }
          return null;
        },
        maxLines: 1,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Email'),
      ),
    );
  }
}
