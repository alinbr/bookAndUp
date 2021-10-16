import 'package:books_app_up/application/home/home_state.dart';
import 'package:books_app_up/infrastructure/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeController extends StateNotifier<HomeState> {
  final BaseBookService _bookService;
  HomeController(this._bookService) : super(HomeStateLoading()) {
    getFamousBooks();
  }

  Future<void> getFamousBooks() async {
    state = HomeStateLoading();

    try {
      final items = await _bookService.getFamousBooks();
      state = HomeStateLoaded(items);
    } on Exception catch (e) {
      state = HomeStateError(e);
    }
  }
}
