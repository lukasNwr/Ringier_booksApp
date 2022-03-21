// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ringier_books_app/providers/api_provider.dart';
import '../models/book.dart';
import '../components/book_tile.dart';
import '../providers/api_provider.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Book book = Book(title: "test book");

  String searchString = "";
  Icon searchIcon = Icon(Icons.search, color: Colors.black);
  Widget appBarMainArea = Text(
    "Search for Books",
    style: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shadowColor: Colors.black.withOpacity(.4),
        backgroundColor: Colors.white,
        elevation: 10,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: appBarMainArea,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (searchIcon.icon == Icons.search) {
                  searchIcon = Icon(Icons.cancel, color: Colors.black);
                  appBarMainArea = ListTile(
                    title: TextField(
                        cursorColor: Colors.black,
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            searchString = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '  Type title or author...',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(.5)),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black)),
                  );
                } else {
                  searchIcon = Icon(Icons.search, color: Colors.black);
                  appBarMainArea = Text(
                    "Search for Books",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              });
            },
            icon: searchIcon,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            child: searchString == ""
                ? Center(child: Text("Use searchbar for searching the books"))
                : FutureBuilder(
                    future: APIProvider.api.fetchBooks(searchString),
                    builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Container(
                              padding: EdgeInsets.all(2),
                              height: MediaQuery.of(context).size.height,
                              child: ListView(
                                  children: snapshot.data!
                                      .map((book) => BookTile(book))
                                      .toList()));
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
      ),
    );
  }
}
