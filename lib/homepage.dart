import 'package:books_app_up/book_card.dart';
import 'package:books_app_up/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                const Text("Explore thousands of books on the go",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 24,
                ),
                const BookCard(
                    imageUrl: "aa",
                    author: "Joshua Becker",
                    title: "The More of Less",
                    rating: "4.5",
                    category: "Minimalism"),
                const BookCard(
                    imageUrl: "aa",
                    author: "Don Felker",
                    title: "The Good Surgeon",
                    rating: "4.5",
                    category: "Medical"),
                const BookCard(
                    imageUrl: "aa",
                    author: "George orwell",
                    title: "1984",
                    rating: "4.5",
                    category: "Fiction"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
