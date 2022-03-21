import 'package:flutter/material.dart';
import 'package:ringier_books_app/models/book.dart';
import 'package:ringier_books_app/providers/api_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Book book;

  DetailsScreen(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

  const BookDetails(this.book);

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
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 0.65,
                              heightFactor: 0.75,
                              child: Image.network(_book!.image),
                            ),
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.25),
                                spreadRadius: 7,
                                blurRadius: 23,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(book.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('by ${_book?.authors}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    color:
                                        const Color.fromARGB(255, 202, 202, 202)
                                            .withOpacity(.2),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const Text('Rating'),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 241, 205, 0),
                                              size: 20,
                                            ),
                                            Text(
                                              '${_book!.rating}/5',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      color: Colors.grey.withOpacity(.5),
                                      thickness: 2,
                                    ),
                                    Column(
                                      children: [
                                        const Text('Pages'),
                                        Text(
                                          _book.pages,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      color: Colors.grey.withOpacity(.5),
                                      thickness: 2,
                                    ),
                                    Column(
                                      children: [
                                        const Text('Language'),
                                        Text(
                                          _book.language,
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
                            const SizedBox(height: 20),
                            Text(
                              _book.desc,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Published by ${_book.publisher} in the ${_book.year}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
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
