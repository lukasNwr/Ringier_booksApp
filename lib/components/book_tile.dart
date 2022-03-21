import 'package:flutter/material.dart';
import 'package:ringier_books_app/screens/details_screen.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  Book book;

  BookTile(this.book);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.network(book.image, height: 100, fit: BoxFit.fill),
        title: Text(
          book.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          softWrap: true,
        ),
        subtitle: Text(book.subtitle,
            overflow: TextOverflow.ellipsis, maxLines: 3, softWrap: true),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailsScreen(book)));
        },
      ),
    );
  }
}
