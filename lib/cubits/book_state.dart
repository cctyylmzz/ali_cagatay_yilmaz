part of 'book_cubit.dart';

abstract class BookState extends Equatable {
  const BookState();
}

class BookInitial extends BookState {
  @override
  List<Object?> get props => [];
}

class BookLoading extends BookState {
  @override
  List<Object?> get props => [];
}

class BookSuccess extends BookState {
  final Book response;

  const BookSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class BookError extends BookState {
  final String errorMessage;

  const BookError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
