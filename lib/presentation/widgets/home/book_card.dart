import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookCard extends StatelessWidget {
  final String imageUrl;
  final String author;
  final String title;
  final String rating;
  final String category;

  const BookCard(
      {Key? key,
      required this.imageUrl,
      required this.author,
      required this.title,
      required this.rating,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 32),
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
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "by $author",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFEB749),
                        size: 12,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        rating,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Chip(
                      backgroundColor: const Color(0xFF9DDCFF),
                      label: Text(
                        category,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: const Color(0xFF14A4FF)),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
