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
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 22),
                        child: Text("Explore thousands of books on the go",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.black)),
                      ),
                      const SearchBox(),
                      if (!watch(booksProvider.notifier).showingSearchResults)
                        const SizedBox(
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
                Expanded(
                    child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.03],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Container(
                    child: books.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(
                              child: Text("No results found!"),
                            );
                          }

                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BookCard(
                                  imageUrl: data[index].image,
                                  authors: data[index].authors,
                                  title: data[index].title,
                                  rating: data[index].averageRating,
                                  categories: data[index].categories);
                            },
                            itemCount: data.length,
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (_, __) => const Center(
                              child:
                                  Text("Unexpected error. Please try again!"),
                            )),
                  ),
                )),
              ],
            )),
      ),
    );
  }
}
