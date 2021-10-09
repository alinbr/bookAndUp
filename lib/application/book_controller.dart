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

  bool showingSearchResults = false;

  BookController(this._repository) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();
    showingSearchResults = false;
    try {
      final items = await _repository.getPopularBooks();
      state = AsyncValue.data(items);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> search(String input) async {
    state = const AsyncValue.loading();
    showingSearchResults = true;
    try {
      final items = await _repository.search(input);
      state = AsyncValue.data(items);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
