import 'package:books_app_up/infrastructure/dtos/book.dart';
import 'package:books_app_up/infrastructure/repositories/book_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final booksProvider =
    StateNotifierProvider<BookController, AsyncValue<List<Book>>>((ref) {
  final repository = ref.watch(bookRepository);
  return BookController(repository);
});

class BookController extends StateNotifier<AsyncValue<List<Book>>> {
  final BaseBookRepository _repository;

  BookController(this._repository) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();

    try {
      final items = await _repository.retrieveBooks();
      state = AsyncValue.data(items);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
