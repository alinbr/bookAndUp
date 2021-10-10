import 'package:books_app_up/application/search/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBox extends ConsumerWidget {
  final bool autofocus;
  final bool enabled;

  const SearchBox({
    Key? key,
    this.autofocus = false,
    this.enabled = false,
  }) : super(key: key);

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
          child: TextField(
            onChanged: (value) {
              context.read(searchProvider.notifier).search();
            },
            enabled: enabled,
            autofocus: autofocus,
            controller: watch(searchTextEditorProvider).state,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                icon: enabled ? null : const Icon(CupertinoIcons.search),
                hintText: 'Search for books...'),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}