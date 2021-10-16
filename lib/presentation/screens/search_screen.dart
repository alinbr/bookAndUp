import 'package:books_app_up/application/search/search_controller.dart';
import 'package:books_app_up/application/search/search_state.dart';
import 'package:books_app_up/infrastructure/dtos/book_dto.dart';
import 'package:books_app_up/presentation/widgets/home/book_card.dart';
import 'package:books_app_up/presentation/widgets/search/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(searchProvider);

    Widget content;
    if (search is SearchStateEmpty) {
      content = buildInitialSearchEmpty(context);
    } else if (search is SearchStateLoading) {
      content = buildSearchStateLoading(context);
    } else if (search is SearchStateResults) {
      content = buildSearchStateResults(context, search.books);
    } else {
      content = const SizedBox.shrink();
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Header(),
              content,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchStateResults(BuildContext context, List<BookDto> books) {
    return books.isEmpty
        ? const Center(child: Text("No results found"))
        : Expanded(
            child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) => BookCard(
              book: books[index],
            ),
          ));
  }

  Widget buildSearchStateLoading(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildInitialSearchEmpty(BuildContext context) {
    return Container();
  }
}
