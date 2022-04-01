import 'package:flutter/material.dart';
import 'list_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final textController = TextEditingController();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.7,
                    child: Image.asset('assets/axel_logo.png'),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: Text(
                      "book app",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        color: Colors.white,
                        child: TextField(
                          controller: textController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Search for book title or author...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            suffixIcon: searchString != ""
                                ? IconButton(
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.black),
                                    onPressed: () {
                                      textController.clear();
                                      setState(() {
                                        searchString = "";
                                      });
                                    })
                                : null,
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.grey,
                          onChanged: (value) {
                            setState(() {
                              searchString = value;
                            });
                          },
                          onSubmitted: (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListScreen(searchString),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
