import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final String description;

  const Summary({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Text(
          'Summary',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          description.isNotEmpty ? description : "n/a",
          style: Theme.of(context).textTheme.bodyText2,
          maxLines: 50,
        ),
      ),
      const SizedBox(
        height: 100,
      ),
    ]);
  }
}
