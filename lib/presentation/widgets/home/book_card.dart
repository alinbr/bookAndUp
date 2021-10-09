import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookCard extends StatelessWidget {
  final String imageUrl;
  final List<String> authors;
  final String title;
  final double rating;
  final List<String> categories;

  const BookCard(
      {Key? key,
      required this.imageUrl,
      required this.authors,
      required this.title,
      required this.rating,
      required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorsLabel =
        authors.isNotEmpty ? "by " + authors.join(", ") : "unkown author";
    String? chipLabel = categories.isNotEmpty ? categories[0] : null;

    return Container(
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
          CoverImage(imageUrl: imageUrl),
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
                    title,
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
                      rating != 0.0 ? rating.toString() : "n/a",
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
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.imageUrl,
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
