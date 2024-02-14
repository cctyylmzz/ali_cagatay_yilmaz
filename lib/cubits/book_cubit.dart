import 'package:ali_cagatay_yilmaz/repositories/book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/book.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository _bookRepository;
  BookCubit(this._bookRepository) : super(BookInitial());

  String searchKey = '';
  List<Item> orginalItems = [];

  Future<void> searchBook() async {
    try {
      emit(BookLoading());
      orginalItems.clear();
      final response = await _bookRepository.searchBook(searchKey);
      orginalItems = response.items!;
      emit(BookSuccess(response));
    } catch (e) {
      emit(const BookError('Beklenilmeyen bir hata oluştu.'));
    }
  }
}
