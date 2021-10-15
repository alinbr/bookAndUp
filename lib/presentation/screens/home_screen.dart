import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:books_app_up/application/home/home_controller.dart';
import 'package:books_app_up/application/home/home_state.dart';
import 'package:books_app_up/application/search/search_controller.dart';
import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:books_app_up/presentation/screens/favorites_screen.dart';
import 'package:books_app_up/presentation/screens/search_screen.dart';
import 'package:books_app_up/presentation/widgets/core/auth_wrapper.dart';
import 'package:books_app_up/presentation/widgets/core/my_drawer.dart';
import 'package:books_app_up/presentation/widgets/home/book_card.dart';
import 'package:books_app_up/presentation/widgets/core/search_box.dart';
import 'package:books_app_up/presentation/widgets/home/header_subtitle.dart';
import 'package:books_app_up/presentation/widgets/home/header_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeProvider);

    if (home is HomeStateLoading) {
      return buildInitialStateLoading(context, ref);
    } else if (home is HomeStateLoaded) {
      return buildInitialStateLoaded(context, home.books, ref);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildInitialStateLoaded(
      BuildContext context, List<Book> books, WidgetRef ref) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView.builder(
            itemCount: books.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return buildHeader(context, ref);
              }

              return BookCard(
                book: books[index - 1],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialStateLoading(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              buildHeader(context, ref),
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)),
          const HeaderTitle(),
          GestureDetector(
            onTap: () {
              ref.read(searchProvider.notifier).reset();
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const SearchPage(),
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
              Future.delayed(const Duration(milliseconds: 300), () {
                ref.read(focusSearchKeyboard).state = true;
              });
            },
            child: const Hero(child: SearchBox(), tag: "search"),
          ),
          const HeaderSubtitle()
        ],
      ),
    );
  }
}
