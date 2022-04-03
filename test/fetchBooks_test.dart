import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:ringier_books_app/models/book.dart';
import 'package:ringier_books_app/providers/api_provider.dart';

//TODO: use mocking for testing instead of actuall api calls...

void main() {
  group('API tests', () {
    test('Fetch single book using isbn identifier', () async {
      final apiClient = APIProvider.api;

      final Book book = await apiClient.fetchBookDetails('9780321812186');
      expect(book.title, 'Effective JavaScript');
    });

    test('Create list from api call', () async {
      final List<Book> bookList = await APIProvider.api.fetchBooks('java');
      expect(bookList.isNotEmpty, true);
    });
  });
}
