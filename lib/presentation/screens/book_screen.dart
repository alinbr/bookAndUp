import 'package:books_app_up/application/favorites/helper.dart';
import 'package:books_app_up/application/providers.dart';
import 'package:books_app_up/infrastructure/dtos/book_dto.dart';
import 'package:books_app_up/infrastructure/services/favorites_service.dart';
import 'package:books_app_up/presentation/widgets/book_details/authors.dart';
import 'package:books_app_up/presentation/widgets/book_details/categories.dart';
import 'package:books_app_up/presentation/widgets/book_details/more_info.dart';
import 'package:books_app_up/presentation/widgets/book_details/preview_button.dart';
import 'package:books_app_up/presentation/widgets/book_details/header.dart';
import 'package:books_app_up/presentation/widgets/book_details/summary.dart';
import 'package:books_app_up/presentation/widgets/book_details/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookScreen extends ConsumerWidget {
  final BookDto book;

  const BookScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authStateProvider).value!.uid;
    final isUserFavorite =
        ref.watch(isUserFavoriteProvider(UserBook(userId, book.selfLink)));

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: PreviewButton(book: book),
        appBar: _buildAppBar(context, ref, isUserFavorite),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                imageUrl: book.image,
              ),
              BookTitle(
                title: book.title,
              ),
              Authors(authors: book.authors),
              MoreInfo(
                  averageRating: book.averageRating,
                  ratingsCount: book.ratingsCount,
                  pageCount: book.pageCount),
              if (book.categories.isNotEmpty)
                Categories(
                  categories: book.categories,
                ),
              Summary(description: book.description),
            ],
          ),
        ));
  }

  AppBar _buildAppBar(
      BuildContext context, WidgetRef ref, bool isUserFavorite) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFF3F2F3),
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
      actions: [
        IconButton(
            onPressed: () {
              String userId = ref.read(authStateProvider).value!.uid;

              if (isUserFavorite) {
                ref.read(favoritesService).remove(userId, book.selfLink);
              } else {
                ref.read(favoritesService).add(userId, book.selfLink);
              }
            },
            icon: isUserFavorite
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_outline, color: Colors.black)),
      ],
    );
  }
}
