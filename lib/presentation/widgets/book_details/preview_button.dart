import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewButton extends StatelessWidget {
  const PreviewButton({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
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
            )));
  }
}
