import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:books_app_up/presentation/widgets/book_details/preview_button.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  final Book book;

  const BookScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: PreviewButton(book: book),
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildTitle(context),
              const SizedBox(height: 8),
              _buildAuthors(context),
              const SizedBox(height: 8),
              _buildMoreInfo(context),
              if (book.categories.isNotEmpty) _buildCategories(),
              const SizedBox(height: 16),
              _buildSummary(context)
            ],
          ),
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Column _buildSummary(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
    ]);
  }

  Container _buildCategories() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: book.categories.length,
          itemBuilder: (context, index) => Chip(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              label: Text(
                book.categories[index],
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.black),
              )),
        ));
  }

  Padding _buildMoreInfo(BuildContext context) {
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
            book.pageCount > 0 ? "${book.pageCount} pages" : "n/a pages",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  Padding _buildAuthors(BuildContext context) {
    String authorsLabel = book.authors.isNotEmpty
        ? "by " + book.authors.join(", ")
        : "unkown author";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        authorsLabel,
        style: Theme.of(context).textTheme.subtitle2,
        maxLines: 2,
      ),
    );
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        book.title,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.bold),
        maxLines: 3,
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F2F3),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      ),
      child: book.image != ""
          ? Image(image: NetworkImage(book.image))
          : const Center(
              child: Icon(
                Icons.book,
                size: 32,
              ),
            ),
    );
  }
}
