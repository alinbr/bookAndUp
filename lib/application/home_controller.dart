import 'package:books_app_up/application/home_state.dart';
import 'package:books_app_up/infrastructure/repositories/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextEditorProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final homeProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  final repository = ref.watch(bookRepository);
  final searchEditor = ref.watch(searchTextEditorProvider).state;
  return HomeController(repository, searchEditor);
});

class HomeController extends StateNotifier<HomeState> {
  final BaseBookRepository _repository;
  final TextEditingController _searchEditor;
  HomeController(this._repository, this._searchEditor)
      : super(HomeStateLoading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = HomeStateLoading();

    try {
      final items = await _repository.getPopularBooks();
      state = HomeStateLoaded(items);
    } on Exception catch (e) {
      state = HomeStateError(e);
    }
  }

  Future<void> search() async {
    if (_searchEditor.text == "") {
      state = HomeStateEmptySearch();
    } else {
      state = HomeStateSearching();

      try {
        final items = await _repository.search(_searchEditor.text);
        state = HomeStateSearchResults(items);
      } on Exception catch (e) {
        state = HomeStateError(e);
      }
    }
  }
}
