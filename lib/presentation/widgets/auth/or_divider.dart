import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: const [
          Expanded(child: Divider(color: Colors.black)),
          SizedBox(
            width: 16,
          ),
          Text('or'),
          SizedBox(
            width: 16,
          ),
          Expanded(child: Divider(color: Colors.black)),
        ],
      ),
    );
  }
}
