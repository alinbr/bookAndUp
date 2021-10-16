import 'package:flutter/material.dart';

class HeaderSubtitle extends StatelessWidget {
  const HeaderSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24),
      child: SizedBox(
        width: double.infinity,
        child: Text("Famous Books",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black)),
      ),
    );
  }
}
