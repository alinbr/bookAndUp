import 'package:books_app_up/application/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBox extends ConsumerWidget {
  final bool autofocus;
  final bool enabled;

  const SearchBox({Key? key, this.autofocus = false, this.enabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Material(
      child: Container(
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
        child: Focus(
          // onFocusChange: (hasFocus) {
          //   if (hasFocus) {
          //     context.read(homeProvider.notifier).search();
          //   }
          // },
          child: TextField(
            onChanged: (value) {
              value == ""
                  ? context.read(homeProvider.notifier).retrieveItems()
                  : context.read(homeProvider.notifier).search();
            },
            enabled: enabled,
            autofocus: autofocus,
            controller: watch(searchTextEditorProvider).state,
            decoration: const InputDecoration(
                border: InputBorder.none,
                icon: Icon(CupertinoIcons.search),
                hintText: 'Search for books...'),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
