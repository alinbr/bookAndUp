import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:books_app_up/presentation/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorsLabel = book.authors.isNotEmpty
        ? "by " + book.authors.join(", ")
        : "unkown author";
    String? chipLabel = book.categories.isNotEmpty ? book.categories[0] : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookScreen(book: book),
            ));
      },
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 4,
                blurRadius: 8,
              ),
            ]),
        child: Row(
          children: [
            CoverImage(imageUrl: book.image, id: book.id),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorsLabel,
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      book.title,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFEB749),
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        book.averageRating != 0.0
                            ? book.averageRating.toString()
                            : "n/a",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  if (chipLabel != null)
                    Chip(
                        backgroundColor: const Color(0xFF9DDCFF),
                        label: Text(
                          chipLabel,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: const Color(0xFF14A4FF)),
                        ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  final String id;

  const CoverImage({
    Key? key,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: imageUrl != ""
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == ""
          ? const Center(
              child: Icon(
              Icons.book,
              color: Colors.grey,
            ))
          : Container(),
    );
  }
}
