import 'dart:convert';

import 'package:books_app_up/infrastructure/dtos/book_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final bookService = Provider<BaseBookService>((ref) {
  return BookService();
});

abstract class BaseBookService {
  Future<List<BookDto>> getFamousBooks();
  Future<List<BookDto>> search(String input);
  Future<List<BookDto>> getBooks(List<String> booksUrl);
}

class BookService implements BaseBookService {
  final String baseUrl = 'https://www.googleapis.com/books/v1/volumes?q=';

  @override
  Future<List<BookDto>> getFamousBooks() async {
    return search("ernest heming");
  }

  @override
  Future<List<BookDto>> search(String input) async {
    var q = baseUrl + input.trim().replaceAll(' ', '+');

    try {
      final result = await http.get(Uri.parse(q));

      if (result.statusCode != 200) {
        throw Exception(result.body);
      }
      final books = <BookDto>[];
      final list = (jsonDecode(result.body))['items'] as List<dynamic>?;
      if (list == null) return [];
      for (var e in list) {
        books.add(BookDto.fromJson(e));
      }
      return books;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BookDto>> getBooks(List<String> booksUrl) async {
    List<BookDto> booksToReturn = [];

    for (int i = 0; i <= booksUrl.length - 1; i++) {
      try {
        final result = await http.get(Uri.parse(booksUrl[i]));

        if (result.statusCode != 200) {
          throw Exception(result.body);
        }

        final book = jsonDecode(result.body);

        booksToReturn.add(BookDto.fromJson(book));
      } on Exception catch (e) {
        throw Exception(e);
      }
    }
    return booksToReturn;
  }
}
