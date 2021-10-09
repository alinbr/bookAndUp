import 'package:books_app_up/application/home_controller.dart';
import 'package:books_app_up/application/home_state.dart';
import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:books_app_up/presentation/screens/search_screen.dart';
import 'package:books_app_up/presentation/widgets/home/book_card.dart';
import 'package:books_app_up/presentation/widgets/home/search_box.dart';
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
    } else if (home is HomeStateSearching) {
      return buildSearchingState(context);
    } else if (home is HomeStateSearchResults) {
      return buildSearchResultsState(context, home.books);
    } else if (home is HomeStateEmptySearch) {
      return buildSearchReadyState(context);
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
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 22, bottom: 32),
                          child: Text("Explore thousands of books on the go",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()),
                              );
                            },
                            child: Hero(child: SearchBox(), tag: "search")),
                        const Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Famous Books",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Center(
                          child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BookCard(
                          imageUrl: books[index].image,
                          authors: books[index].authors,
                          title: books[index].title,
                          rating: books[index].averageRating,
                          categories: books[index].categories);
                    },
                    itemCount: books.length,
                  )))
                ]))));
  }

  Widget buildInitialStateLoading(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 22),
                          child: Text("Explore thousands of books on the go",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                        ),
                        SearchBox(),
                        SizedBox(
                          width: double.infinity,
                          child: Text("Famous Books",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                ]))));
  }

  Widget buildSearchingState(
    BuildContext context,
  ) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: const SearchBox(),
                  ),
                  const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                ]))));
  }

  Widget buildSearchReadyState(
    BuildContext context,
  ) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: const SearchBox(
                      autofocus: true,
                    ),
                  ),
                ]))));
  }

  Widget buildSearchResultsState(BuildContext context, List<Book> books) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: const SearchBox(),
                  ),
                  Expanded(
                      child: Center(
                          child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BookCard(
                          imageUrl: books[index].image,
                          authors: books[index].authors,
                          title: books[index].title,
                          rating: books[index].averageRating,
                          categories: books[index].categories);
                    },
                    itemCount: books.length,
                  )))
                ]))));
  }
}
