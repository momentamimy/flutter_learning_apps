import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_project/future_provider/model/book_model.dart';

class ApisServices{

  String fetchBooksURL =
      'https://raw.githubusercontent.com/Richa0305/mock-json/main/book.json';

  Future<List<BookModel>> fetchBooks() async {
    print("run_________fetchBooksApi");
    final Dio dio = Dio();
    final response = await dio.get(fetchBooksURL,options: Options()); // Call API

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return List<BookModel>.from(
          json.decode(response.data).map((x) => BookModel.fromJson(x)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}