import 'package:flutter/material.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
