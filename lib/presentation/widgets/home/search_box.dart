import 'package:books_app_up/application/book_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBox extends ConsumerWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
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
      child: TextField(
        onChanged: (value) {
          value == ""
              ? watch(booksProvider.notifier).retrieveItems()
              : watch(booksProvider.notifier).search(value);
        },
        decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(CupertinoIcons.search),
            hintText: 'Search for books...'),
        maxLines: 1,
      ),
    );
  }
}
