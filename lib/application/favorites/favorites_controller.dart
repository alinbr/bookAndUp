import 'package:books_app_up/application/auth/auth_controller.dart';
import 'package:books_app_up/application/favorites/favorites_state.dart';
import 'package:books_app_up/infrastructure/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  final BaseBookService _bookService;
  final AsyncValue<List<String>> _favoritesBooks;

  FavoritesController(this._bookService, this._favoritesBooks)
      : super(FavoritesStateLoading()) {
    getFavoritesBooks();
  }

  Future<void> getFavoritesBooks() async {
    state = FavoritesStateLoading();

    List<String> booksUrls = _favoritesBooks.when(
        data: (data) => data,
        error: (_, __, ___) => List<String>.empty(),
        loading: (_) => List<String>.empty());

    try {
      final items = await _bookService.getBooks(booksUrls);
      state = FavoritesStateLoaded(items);
    } on Exception catch (e) {
      state = FavoritesStateError(e);
    }
  }
}
