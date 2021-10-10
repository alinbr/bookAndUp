import 'package:books_app_up/application/home/home_controller.dart';
import 'package:books_app_up/application/home/home_state.dart';
import 'package:books_app_up/application/search/search_controller.dart';
import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:books_app_up/presentation/screens/search_screen.dart';
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
  Widget build(BuildContext context, ScopedReader watch) {
    final home = watch(homeProvider);

    if (home is HomeStateLoading) {
      return buildInitialStateLoading(context);
    } else if (home is HomeStateLoaded) {
      return buildInitialStateLoaded(context, home.books);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildInitialStateLoaded(BuildContext context, List<Book> books) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView.builder(
            itemCount: books.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return buildHeader(context);
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

  Widget buildInitialStateLoading(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              buildHeader(context),
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

  Widget buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const HeaderTitle(),
          GestureDetector(
            onTap: () {
              context.read(searchProvider.notifier).reset();
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const SearchPage(),
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
              Future.delayed(const Duration(milliseconds: 300), () {
                context.read(focusSearchKeyboard).state = true;
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
