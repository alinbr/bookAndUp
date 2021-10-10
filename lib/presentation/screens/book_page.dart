import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
        body: Column(
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
              child: const Image(
                  image: NetworkImage(
                      "http://books.google.com/books/content?id=mYkddwGb_IgC&printsec=frontcover&img=1&zoom=1&source=gbs_api")),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Ernest Hemingway on Writing",
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
                "by Jean-Pierre Pustienne",
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
                    "4.5 / 300 reviews",
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
                    "120 pages",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 56,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Chip(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: Text(
                        "Medical",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.black),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Chip(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: Text(
                        "Fiction",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.black),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Chip(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      label: Text(
                        "Fantasy",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.black),
                      )),
                ],
              ),
            ),
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
                "The 'icon' Ernest Hemingway analyzed under all his aspects, or better as the mythical 'Papa': the hunter and fisherman, the bullfight fan, the special correspondent, the globe-trotter, the drinker, the brave soldier, the volunteer, the lover.",
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 16,
              ),
            ),
          ],
        ));
  }
}
