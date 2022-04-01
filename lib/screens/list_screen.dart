// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ringier_books_app/providers/api_provider.dart';
import '../models/book.dart';
import '../components/book_tile.dart';
import '../providers/api_provider.dart';

class ListScreen extends StatefulWidget {
  String searchString;

  ListScreen(this.searchString);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final Book book = Book(title: "test book");
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
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
                automaticallyImplyLeading: false,
                toolbarHeight: 60,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                title: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.white.withOpacity(.85),
                    child: Center(
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: widget.searchString == ""
                              ? 'Search for book title or author...'
                              : widget.searchString,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          suffixIcon: widget.searchString != ""
                              ? IconButton(
                                  icon: Icon(Icons.cancel, color: Colors.black),
                                  onPressed: () {
                                    textController.clear();
                                    setState(() {
                                      widget.searchString = "";
                                    });
                                  })
                              : null,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.searchString = value;
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
                    child: widget.searchString == ""
                        ? SizedBox(
                            height: 500,
                            child: Center(
                              child: Text(
                                'Use searchbar for searching for books...',
                              ),
                            ),
                          )
                        : FutureBuilder(
                            future:
                                APIProvider.api.fetchBooks(widget.searchString),
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
