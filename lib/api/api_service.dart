// ignore_for_file: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/book.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('books/v1/volumes?q={searchKey}')
  Future<Book> searchBook(@Path('searchKey') String searchKey);
}
