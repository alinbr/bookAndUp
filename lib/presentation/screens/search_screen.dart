import 'package:books_app_up/application/search/search_controller.dart';
import 'package:books_app_up/application/search/search_state.dart';
import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:books_app_up/presentation/widgets/core/search_box.dart';
import 'package:books_app_up/presentation/widgets/home/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final search = watch(searchProvider);

    Widget _resultsWidget;
    if (search is SearchStateEmpty) {
      _resultsWidget = buildInitialSearchEmpty(context);
    } else if (search is SearchStateLoading) {
      _resultsWidget = buildSearchStateLoading(context);
    } else if (search is SearchStateResults) {
      _resultsWidget = buildSearchStateResults(context, search.books);
    } else {
      _resultsWidget = const SizedBox.shrink();
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              buildHeader(context),
              _resultsWidget,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchStateResults(BuildContext context, List<Book> books) {
    return books.isEmpty
        ? const Center(child: Text("No results found"))
        : Expanded(
            child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) => BookCard(
                imageUrl: books[index].image,
                authors: books[index].authors,
                title: books[index].title,
                rating: books[index].averageRating,
                categories: books[index].categories),
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

  Padding buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read(searchTextEditorProvider).state.clear();
                context.read(focusSearchKeyboard).state = false;
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
