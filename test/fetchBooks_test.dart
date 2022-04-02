import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:ringier_books_app/models/book.dart';
import 'package:ringier_books_app/providers/api_provider.dart';

void main() {
  group('API tests', () {
    test('Fetch single book using isbn identifier', () async {
      final mockHttpClient = MockClient((request) async {
        final mapJson = {'title': 'Effective JavaScript'};
        return Response(json.encode(mapJson), 200);
      });

      final Book book = await APIProvider.api.fetchBookDetails('9780321812186');
      expect(book.title, 'Effective JavaScript');
    });
  });
}
