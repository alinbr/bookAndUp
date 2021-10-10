import 'package:books_app_up/application/home/home_state.dart';
import 'package:books_app_up/infrastructure/repositories/book_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  final repository = ref.watch(bookRepository);
  return HomeController(repository);
});

class HomeController extends StateNotifier<HomeState> {
  final BaseBookRepository _repository;
  HomeController(this._repository) : super(HomeStateLoading()) {
    getFamousBooks();
  }

  Future<void> getFamousBooks() async {
    state = HomeStateLoading();

    try {
      final items = await _repository.getFamousBooks();
      state = HomeStateLoaded(items);
    } on Exception catch (e) {
      state = HomeStateError(e);
    }
  }
}
