import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:books_app_up/presentation/widgets/auth/field_wrapper.dart';
import 'package:books_app_up/presentation/widgets/auth/my_sign_in_button.dart';
import 'package:books_app_up/presentation/widgets/auth/or_divider.dart';
import 'package:books_app_up/presentation/widgets/auth/register_footer.dart';
import 'package:books_app_up/presentation/widgets/auth/sign_in_footer.dart';
import 'package:books_app_up/presentation/widgets/core/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
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
                  "Hello!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8),
                Text(
                  "Let's get you started!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 24),
                _buildEmailField(context),
                _buildPasswordField(context),
                _buildRepeatPassField(context),
                _buildRegisterButton(context),
                const OrDivider(),
                const SizedBox(height: 32),
                SignInButton(
                  Buttons.Google,
                  text: "Register with Google",
                  onPressed: () {},
                  elevation: 6,
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                const Spacer(),
                const RegisterFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      child: MySignInButton(
        text: "Register",
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Creating your account')),
            );

            String msg = await ref
                .read(authProvider)
                .signUpWithEmailAndPassword(
                    _emailController.text, _passwordController.text);

            if (msg == "Signed up") {
              Navigator.push(
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

  Widget _buildRepeatPassField(BuildContext context) {
    return FieldWrapper(
      textFormField: TextFormField(
        validator: (value) {
          if (value != _passwordController.text) {
            return "Passwords does not match!";
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
            hintText: 'Repeat Password'),
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
