import 'dart:convert';
import 'package:dio/dio.dart';

String fetchBooksURL =
    'https://raw.githubusercontent.com/Richa0305/mock-json/main/book.json';

Future<List<BooksListModel>> fetchBooks(Dio dio) async {
  final response = await dio.get(fetchBooksURL); // Call API

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return List<BooksListModel>.from(
        json.decode(response.data).map((x) => BooksListModel.fromJson(x)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class BooksListModel {
  BooksListModel({
    required this.id,
    required this.name,
    required this.auther,
    required this.decription,
    required this.amazon,
  });

  int? id;
  String? name;
  String? auther;
  String? decription;
  String? amazon;

  factory BooksListModel.fromJson(Map<String, dynamic> json) => BooksListModel(
        id: json["id"],
        name: json["name"],
        auther: json["auther"],
        decription: json["decription"],
        amazon: json["amazon"],
      );
}
