import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_testing/fetch_books.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group("test fetch books api", () {
    test("test api", () async {
      final mockDio = MockDio();
      when(mockDio.get(fetchBooksURL)).thenAnswer((realInvocation) async =>
          Response(
              statusCode: 200,
              data:
              '[{"id" : 1,"name": "The 5 Second Rule","auther": "Mel Robbins"},{"id" : 2,"name": "The Alchemist","auther": "Paul Coelho"}]',
              requestOptions: RequestOptions()));

      expect(await fetchBooks(mockDio), isA<List<BooksListModel>>());
    });
  });
}
