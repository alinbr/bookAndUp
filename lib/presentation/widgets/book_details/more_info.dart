import 'package:flutter/material.dart';

class MoreInfo extends StatelessWidget {
  final double averageRating;
  final int ratingsCount;
  final int pageCount;

  const MoreInfo(
      {Key? key,
      required this.averageRating,
      required this.ratingsCount,
      required this.pageCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            averageRating != 0.0
                ? '$averageRating / $ratingsCount ratings'
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
            pageCount > 0 ? "$pageCount pages" : "n/a pages",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
