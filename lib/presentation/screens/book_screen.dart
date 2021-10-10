import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookScreen extends StatelessWidget {
  final Book book;

  const BookScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorsLabel = book.authors.isNotEmpty
        ? "by " + book.authors.join(", ")
        : "unkown author";

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              elevation: 4,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            onPressed: () async {
              if (book.previewLink != "") {
                await canLaunch(book.previewLink)
                    ? await launch(book.previewLink)
                    : throw 'Could not launch ${book.previewLink}';
              }
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "Preview in Google Books",
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ))),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF3F2F3),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline, color: Colors.black)),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F2F3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32)),
                ),
                child: book.image != ""
                    ? Image(image: NetworkImage(book.image))
                    : const Center(
                        child: Icon(
                          Icons.book,
                          size: 32,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  book.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  authorsLabel,
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFEB749),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      book.averageRating != 0.0
                          ? '${book.averageRating} / ${book.ratingsCount} ratings'
                          : "n/a",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.book_rounded,
                      color: Colors.black,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      book.pageCount > 0
                          ? "${book.pageCount} pages"
                          : "n/a pages",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              if (book.categories.isNotEmpty)
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 56,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: book.categories.length,
                      itemBuilder: (context, index) => Chip(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey.withOpacity(0.3), width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          label: Text(
                            book.categories[index],
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.black),
                          )),
                    )),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Summary',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  book.description.isNotEmpty ? book.description : "n/a",
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 50,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ));
  }
}
