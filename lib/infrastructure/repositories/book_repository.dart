import 'dart:convert';

import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final bookRepository = Provider<BaseBookRepository>((ref) {
  return BookRepository();
});

abstract class BaseBookRepository {
  Future<List<Book>> retrieveBooks();
}

class BookRepository implements BaseBookRepository {
  @override
  Future<List<Book>> retrieveBooks() async {
    var q =
        'https://www.googleapis.com/books/v1/volumes?q=' + 'punguta+cu+2+bani';

    final result = await http.get(Uri.parse(q));

    if (result.statusCode == 200) {
      final books = <Book>[];
      final list = (jsonDecode(result.body))['items'] as List<dynamic>?;
      if (list == null) return [];
      list.forEach((e) {
        books.add(Book.fromJson(e));
      });
      return books;
    } else {
      throw (result.body);
    }
  }
}
