import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/future_provider/model/book_model.dart';
import 'package:riverpod_project/future_provider/services/services.dart';

final booksDataProvider = FutureProvider<List<BookModel>>((ref) => ApisServices().fetchBooks());
