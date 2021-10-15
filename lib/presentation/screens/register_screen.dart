import 'package:books_app_up/presentation/screens/login_screen.dart';
import 'package:books_app_up/presentation/widgets/sign_in/input_button.dart';
import 'package:books_app_up/presentation/widgets/sign_in/my_sign_in_button.dart';
import 'package:books_app_up/presentation/widgets/sign_in/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              const SizedBox(height: 32),
              const Center(
                child: InputButton(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                  child: InputButton(
                hintText: 'Password',
              )),
              const SizedBox(height: 16),
              const Center(
                  child: InputButton(
                hintText: 'Repeat password',
              )),
              const SizedBox(height: 32),
              const MySignInButton(text: "Register"),
              const SizedBox(height: 32),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: const Text("Login instead!"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
