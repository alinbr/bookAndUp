import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 22, bottom: 32),
      child: Text("Explore thousands of books on the go",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black)),
    );
  }
}
