import 'package:books_app_up/application/providers.dart';
import 'package:books_app_up/presentation/screens/search_screen.dart';
import 'package:books_app_up/presentation/widgets/core/search_box.dart';
import 'package:books_app_up/presentation/widgets/home/header_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'header_subtitle.dart';

class Header extends ConsumerWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)),
          const HeaderTitle(),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () => _onTapSearchBar(ref, context),
            child: const Hero(child: SearchBox(), tag: "search"),
          ),
          const HeaderSubtitle()
        ],
      ),
    );
  }

  void _onTapSearchBar(WidgetRef ref, BuildContext context) {
    ref.read(searchControllerProvider.notifier).reset();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SearchPage(),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      ref.read(focusSearchProvider).state = true;
    });
  }
}
