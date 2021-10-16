import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:books_app_up/presentation/widgets/auth/field_wrapper.dart';
import 'package:books_app_up/presentation/widgets/auth/google_sign_in_button.dart';
import 'package:books_app_up/presentation/widgets/auth/login/login_footer.dart';
import 'package:books_app_up/presentation/widgets/auth/login/login_header.dart';
import 'package:books_app_up/presentation/widgets/auth/action_button.dart';
import 'package:books_app_up/presentation/widgets/auth/or_divider.dart';
import 'package:books_app_up/presentation/widgets/auth/registration/registration_footer.dart';
import 'package:books_app_up/presentation/widgets/auth/registration/registration_header.dart';
import 'package:books_app_up/presentation/widgets/core/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
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
    final authMode = ref.watch(authModeProvider);

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
                if (authMode.state == AuthMode.login) const LoginHeader(),
                if (authMode.state == AuthMode.registration)
                  const RegistrationHeader(),
                const SizedBox(height: 24),
                _buildEmailField(context),
                _buildPasswordField(context),
                if (authMode.state == AuthMode.registration)
                  _buildRepeatPassField(context, authMode.state),
                ActionButton(
                  text:
                      authMode.state == AuthMode.login ? "Sign in" : "Register",
                  onPressed: () async {
                    await authenticateUser(context, authMode.state);
                  },
                ),
                const OrDivider(),
                const GoogleSignInButton(),
                const Spacer(),
                if (authMode.state == AuthMode.login) const LoginFooter(),
                if (authMode.state == AuthMode.registration)
                  const RegistrationFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> authenticateUser(BuildContext context, AuthMode authMode) async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(authMode == AuthMode.registration
                ? 'Creating your account..'
                : 'Logging you in..')),
      );

      String msg = authMode == AuthMode.registration
          ? await ref.read(authProvider).signUpWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          : await ref.read(authProvider).signInWithEmailAndPassword(
              _emailController.text, _passwordController.text);

      if (msg == "Signed up" || msg == "Signed in") {
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
    }
  }

  Widget _buildRepeatPassField(BuildContext context, AuthMode authMode) {
    return FieldWrapper(
      textFormField: TextFormField(
        validator: (value) {
          if (authMode == AuthMode.registration &&
              value != _passwordController.text) {
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
