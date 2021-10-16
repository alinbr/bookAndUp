import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final List<String> categories;

  const Categories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => Chip(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              label: Text(
                categories[index],
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.black),
              )),
        ));
  }
}
