import 'dart:convert';

import 'package:ringier_books_app/models/book.dart';
import 'package:http/http.dart' as http;

class APIProvider {
  static final APIProvider api = APIProvider._();

  APIProvider._();

  Future<List<Book>> fetchBooks(String searchString, int pageNumber) async {
    String url =
        'https://api.itbook.store/1.0//search/$searchString/$pageNumber';

    print('url: ' + url);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return parseBooksJson(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  List<Book> parseBooksJson(String jsonStr) {
    final jsonMap = json.decode(jsonStr);
    final jsonList = (jsonMap['books'] as List);
    if (jsonList == null) {
      return [];
    }
    return jsonList.map((data) => Book.bookListFromJson(data)).toList();
  }

  Future<Book> fetchBookDetails(String isbn) async {
    String url = 'https://api.itbook.store/1.0/books/${isbn}';

    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Book.bookDetailsFromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
