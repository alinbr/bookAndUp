import 'package:flutter/material.dart';

class BookTitle extends StatelessWidget {
  final String title;
  const BookTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.bold),
        maxLines: 3,
      ),
    );
  }
}
