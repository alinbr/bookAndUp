import 'package:books_app_up/application/favorites/favorites_controller.dart';
import 'package:books_app_up/application/favorites/favorites_state.dart';
import 'package:books_app_up/infrastructure/dtos/book_dto.dart';
import 'package:books_app_up/presentation/widgets/core/my_drawer.dart';
import 'package:books_app_up/presentation/widgets/home/book_card.dart';
import 'package:books_app_up/presentation/widgets/favorites/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesStateProvider);

    Widget content;
    if (favorites is FavoritesStateLoading) {
      content = buildLoading();
    } else if (favorites is FavoritesStateLoaded) {
      content = buildLoaded(favorites.books);
    } else if (favorites is FavoritesStateError) {
      content = buildError();
    } else {
      content = const SizedBox.shrink();
    }

    return Scaffold(
      drawer: const MyDrawer(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: content,
        ),
      ),
    );
  }

  Widget buildLoaded(List<BookDto> books) {
    return ListView.builder(
        itemCount: books.length + 1,
        itemBuilder: (context, index) => index == 0
            ? const Header()
            : BookCard(
                book: books[index - 1],
              ));
  }

  Widget buildError() {
    return Column(
      children: const [
        Header(),
        Expanded(
          child: Center(
            child: Text('Some unexpected error'),
          ),
        )
      ],
    );
  }

  Widget buildLoading() {
    return Column(
      children: const [
        Header(),
        Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
