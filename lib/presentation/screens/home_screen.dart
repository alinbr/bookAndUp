import 'package:books_app_up/application/book_controller.dart';
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
    final books = watch(booksProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: books.when(
              data: (data) => ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              const Text("Explore thousands of books on the go",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black)),
                              const SizedBox(height: 32),
                              const SearchBox(),
                              const SizedBox(height: 32),
                              Container(
                                width: double.infinity,
                                child: const Text("Famous Books",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black)),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        );
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: BookCard(
                            imageUrl: data[index - 1].image,
                            author: data[index - 1].authors.isNotEmpty
                                ? data[index - 1].authors[0]
                                : "",
                            title: data[index - 1].title,
                            rating: data[index - 1].averageRating.toString(),
                            category: data[index - 1].categories.isNotEmpty
                                ? data[index - 1].categories[0]
                                : ""),
                      );
                    },
                    itemCount: data.length + 1,
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Text("some error")),
        ),
      ),
    );
  }
}
