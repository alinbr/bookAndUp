import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 4,
            blurRadius: 8,
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(CupertinoIcons.search),
            hintText: 'Search for books...'),
        maxLines: 1,
      ),
    );
  }
}
