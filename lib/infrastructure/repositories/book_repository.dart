import 'dart:convert';

import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final bookRepository = Provider<BaseBookRepository>((ref) {
  return BookRepository();
});

abstract class BaseBookRepository {
  Future<List<Book>> getFamousBooks();
  Future<List<Book>> search(String input);
}

class BookRepository implements BaseBookRepository {
  final String baseUrl = 'https://www.googleapis.com/books/v1/volumes?q=';

  @override
  Future<List<Book>> getFamousBooks() async {
    return search("ernest heming");
  }

  @override
  Future<List<Book>> search(String input) async {
    var q = baseUrl + input.trim().replaceAll(' ', '+');

    try {
      final result = await http.get(Uri.parse(q));
      if (result.statusCode != 200) {
        throw Exception(result.body);
      }
      final books = <Book>[];
      final list = (jsonDecode(result.body))['items'] as List<dynamic>?;
      if (list == null) return [];
      for (var e in list) {
        books.add(Book.fromJson(e));
      }
      return books;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
