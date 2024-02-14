import '../api/api_service.dart';
import '../models/book.dart';

class BookRepository {
  final ApiService _apiService;

  BookRepository(this._apiService);

  Future<Book> searchBook(String searchKey) async =>
      await _apiService.searchBook(searchKey);
}
