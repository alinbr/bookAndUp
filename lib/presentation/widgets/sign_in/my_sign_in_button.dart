import 'package:flutter/material.dart';

class MySignInButton extends StatelessWidget {
  final String text;

  const MySignInButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.black,
          elevation: 4,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () async {},
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Colors.white),
            )));
  }
}
