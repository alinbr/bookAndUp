import 'package:flutter/material.dart';

class Authors extends StatelessWidget {
  final List<String> authors;

  const Authors({Key? key, required this.authors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorsLabel =
        authors.isNotEmpty ? "by " + authors.join(", ") : "unkown author";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        authorsLabel,
        style: Theme.of(context).textTheme.subtitle2,
        maxLines: 2,
      ),
    );
  }
}
