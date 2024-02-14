// ignore_for_file: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/api_service.dart';
import '../cubits/book_cubit.dart';
import '../repositories/book_repository.dart';

var getIt = GetIt.I;

void serviceLocator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  BookRepository bookRepository = BookRepository(getIt.call());
  getIt.registerLazySingleton(() => bookRepository);

  BookCubit bookCubit = BookCubit(getIt.call());
  getIt.registerLazySingleton(() => bookCubit);
}
