import 'package:books_app_up/infrastructure/dtos/book.dart';

abstract class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<Book> books;

  HomeStateLoaded(this.books);
}

class HomeStateEmptySearch extends HomeState {}

class HomeStateSearching extends HomeState {}

class HomeStateSearchResults extends HomeState {
  final List<Book> books;

  HomeStateSearchResults(this.books);
}

class HomeStateError extends HomeState {
  final Exception error;

  HomeStateError(this.error);
}
