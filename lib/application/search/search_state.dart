import 'package:books_app_up/infrastructure/dtos/book_dto.dart';

abstract class SearchState {}

class SearchStateEmpty extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateResults extends SearchState {
  final List<BookDto> books;

  SearchStateResults(this.books);
}

class SearchStateError extends SearchState {
  final Exception error;

  SearchStateError(this.error);
}
