import 'package:books_app_up/infrastructure/dtos/book_dto.dart';

abstract class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<BookDto> books;

  HomeStateLoaded(this.books);
}

class HomeStateError extends HomeState {
  final Exception error;

  HomeStateError(this.error);
}
