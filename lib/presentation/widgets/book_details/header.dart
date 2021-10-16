import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String imageUrl;

  const Header({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.only(bottom: 24),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F2F3),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      ),
      child: imageUrl != ""
          ? Image(image: NetworkImage(imageUrl))
          : const Center(
              child: Icon(
                Icons.book,
                size: 32,
              ),
            ),
    );
  }
}
