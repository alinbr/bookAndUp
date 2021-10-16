import 'package:books_app_up/infrastructure/dtos/book_dto.dart';

abstract class FavoritesState {}

class FavoritesStateLoading extends FavoritesState {}

class FavoritesStateLoaded extends FavoritesState {
  final List<BookDto> books;

  FavoritesStateLoaded(this.books);
}

class FavoritesStateError extends FavoritesState {
  final Exception error;

  FavoritesStateError(this.error);
}
