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

    test('Create list from api call', () async {
      final mockHttpClient = MockClient((request) async {
        final mapJson = {
          'books': [
            {
              "title": "Effective JavaScript",
              "subtitle": "68 Specific Ways to Harness the Power of JavaScript",
              "isbn13": "9780321812186",
              "price": "\$21.99",
              "image": "https://itbook.store/img/books/9780321812186.png",
              "url": "https://itbook.store/books/9780321812186"
            },
            {
              "title": "Learning JavaScript",
              "subtitle":
                  "A Hands-On Guide to the Fundamentals of Modern JavaScript",
              "isbn13": "9780321832740",
              "price": "\$8.99",
              "image": "https://itbook.store/img/books/9780321832740.png",
              "url": "https://itbook.store/books/9780321832740"
            },
          ]
        };
        return Response(json.encode(mapJson), 200);
      });

      final List<Book> bookList = await APIProvider.api.fetchBooks('java');
      expect(bookList.isNotEmpty, true);
    });
  });
}
