import 'package:books_app_up/book_card.dart';
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
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text("Explore thousands of books on the go",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(CupertinoIcons.search),
                        hintText: 'Search for books...'),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.infinity,
                  child: const Text("Famous Books",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
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
