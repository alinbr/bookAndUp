import 'package:books_app_up/application/search/search_state.dart';
import 'package:books_app_up/infrastructure/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchController extends StateNotifier<SearchState> {
  final BaseBookService _bookService;
  final TextEditingController _searchEditor;
  String _previousSearchInput = "";

  SearchController(this._bookService, this._searchEditor)
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
        final items = await _bookService.search(inputSearch);
        if (inputSearch == _searchEditor.text) {
          state = SearchStateResults(items);
        }
      } on Exception catch (e) {
        state = SearchStateError(e);
      }
    }
  }
}
