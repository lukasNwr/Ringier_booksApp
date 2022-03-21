import 'package:flutter/material.dart';
import 'package:ringier_books_app/models/book.dart';
import 'package:ringier_books_app/providers/api_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Book book;

  const DetailsScreen(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.black.withOpacity(.4),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(book.title),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BookDetails(book),
      ),
    );
  }
}

class BookDetails extends StatelessWidget {
  final Book book;

  BookDetails(this.book);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIProvider.api.fetchBookDetails(book.isbn13),
        builder: (context, AsyncSnapshot<Book> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error ${snapshot.error}'));
            } else {
              Book? _book = snapshot.data;
              return Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(_book!.image, width: 300),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(book.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('by ${_book!.authors}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text('Rating'),
                                  Text(
                                    _book.rating,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 30),
                              Column(
                                children: [
                                  Text('Pages'),
                                  Text(
                                    _book.pages,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 30),
                              Column(
                                children: [
                                  Text('Language'),
                                  Text(
                                    _book.language,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 30),
                              Column(
                                children: [
                                  Text('Publisher'),
                                  Text(
                                    _book.publisher,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  _book.desc,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
