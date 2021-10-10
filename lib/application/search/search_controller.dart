import 'package:books_app_up/application/search/search_state.dart';
import 'package:books_app_up/infrastructure/repositories/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextEditorProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final focusSearchKeyboard = StateProvider<bool>((ref) => false);

final searchProvider =
    StateNotifierProvider<SearchController, SearchState>((ref) {
  final repository = ref.watch(bookRepository);
  final searchEditor = ref.watch(searchTextEditorProvider).state;
  return SearchController(repository, searchEditor);
});

class SearchController extends StateNotifier<SearchState> {
  final BaseBookRepository _repository;
  final TextEditingController _searchEditor;
  String _previousSearchInput = "";

  SearchController(this._repository, this._searchEditor)
      : super(SearchStateEmpty());

  void reset() {
    state = SearchStateEmpty();
  }

  Future<void> search() async {
    if (_previousSearchInput == _searchEditor.text) {
      return;
    } else {
      _previousSearchInput = _searchEditor.text;
    }

    if (_searchEditor.text == "") {
      state = SearchStateEmpty();
    } else {
      state = SearchStateLoading();

      try {
        var inputSearch = _searchEditor.text;
        final items = await _repository.search(inputSearch);
        if (inputSearch == _searchEditor.text) {
          state = SearchStateResults(items);
        }
      } on Exception catch (e) {
        state = SearchStateError(e);
      }
    }
  }
}
