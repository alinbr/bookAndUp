import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
