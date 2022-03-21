import 'package:flutter/material.dart';
import 'package:ringier_books_app/screens/details_screen.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  Book book;

  BookTile(this.book);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailsScreen(book)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.65,
                  heightFactor: 0.75,
                  child: Image.network(
                    book.image,
                    width: 110,
                  ),
                ),
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ]),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  Text(
                    book.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ListTile(
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(2),
//           child: Container(
//             child: Align(
//               alignment: Alignment.center,
//               widthFactor: 0.65,
//               heightFactor: 0.75,
//               child: Image.network(book.image),
//             ),
//           ),
//         ),
//         title: Text(
//           book.title,
//           overflow: TextOverflow.ellipsis,
//           maxLines: 2,
//           softWrap: true,
//         ),
//         subtitle: Text(book.subtitle,
//             overflow: TextOverflow.ellipsis, maxLines: 3, softWrap: true),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => DetailsScreen(book)));
//         },
//       ),
