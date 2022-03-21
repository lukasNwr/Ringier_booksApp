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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverAppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "Search for books",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              bottom: AppBar(
                toolbarHeight: 60,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                title: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.white.withOpacity(.8),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for book title or author...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchString = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: searchString == ""
                        ? SizedBox(
                            height: 400,
                            child: Center(
                              child: Text(
                                'Use searchbar for book searching',
                              ),
                            ),
                          )
                        : FutureBuilder(
                            future: APIProvider.api.fetchBooks(searchString),
                            builder:
                                (context, AsyncSnapshot<List<Book>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  return Container(
                                      padding: EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView(
                                          children: snapshot.data!
                                              .map((book) => BookTile(book))
                                              .toList()));
                                }
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
