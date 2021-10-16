import 'package:books_app_up/application/favorites/favorites_controller.dart';
import 'package:books_app_up/application/favorites/favorites_state.dart';
import 'package:books_app_up/application/favorites/providers.dart';
import 'package:books_app_up/infrastructure/dtos/book_dto.dart';
import 'package:books_app_up/presentation/widgets/core/my_drawer.dart';
import 'package:books_app_up/presentation/widgets/home/book_card.dart';
import 'package:books_app_up/presentation/widgets/home/header_subtitle.dart';
import 'package:books_app_up/presentation/widgets/home/header_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesStateProvider);

    if (favorites is FavoritesStateLoading) {
      return buildInitialStateLoading(context, ref);
    } else if (favorites is FavoritesStateLoaded) {
      return buildInitialStateLoaded(context, favorites.books, ref);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildInitialStateLoaded(
      BuildContext context, List<BookDto> books, WidgetRef ref) {
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
          const HeaderSubtitle()
        ],
      ),
    );
  }
}
