import 'package:books_app_up/application/providers.dart';
import 'package:books_app_up/presentation/widgets/core/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Header extends ConsumerWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(searchTextEditorProvider).state.clear();
                ref.read(focusSearchProvider).state = false;
              },
              icon: const Icon(Icons.arrow_back)),
          const Expanded(
            child: Hero(
              tag: "search",
              child: SearchBox(
                enabled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
