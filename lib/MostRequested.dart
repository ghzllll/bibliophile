
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MostRequested extends StatefulWidget {
  @override
  _MostRequestedState createState() => _MostRequestedState();
}
class _MostRequestedState extends State<MostRequested> {
  Color color = Color(0xffe6d9b8);
  final snackBar = SnackBar(content: Text("Congrats \n this book is now yours! "));

  List<Map<String, dynamic>> _books = [];
  bool _loading = true;
  List<bool> _selected = [];

  List<int> _prics = [10,20,30,40,50,60,80,90,100,55];

  @override
  void initState() {
    super.initState();
    _loadBooks();
    setState(() {
    });
  }
  void _loadBooks() async {
    final url = 'https://www.googleapis.com/books/v1/volumes?q=search+terms';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final books = data['items'] as List<dynamic>;
    final newBooks = books.map<Map<String, dynamic>>((book) {
      final volumeInfo = book['volumeInfo'];
      return {
        'title': volumeInfo['title'] ?? '',
        'authors': volumeInfo['authors']?.cast<String>() ?? ['Unknown Author'],
        'description': volumeInfo['description'] ?? '',
        'thumbnail': volumeInfo['imageLinks']['thumbnail'] ?? '',
      //  'priceIndex': books.indexOf(book)
        'available': true,
      };
    }).toList();
    setState(() {
      _books = newBooks;
      _selected = List.generate(_books.length, (index) => false);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: Color(0xff988763),
        title: Text(
          'Most Requested',
          style: TextStyle(
            fontSize: 35,
            fontFamily: "ShadowsIntoLight",
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          final startindex=4;
          return ExpansionTile(
            leading: Image.network(
              _books[index+startindex]['thumbnail'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    _books[index+startindex]['title'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: _selected[index+startindex] ? Color(0xff988763) : Colors.black,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '\$${_prics[index]}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: _selected[index] ? Color(0xff988763) : Colors.black,
                      ),
                    ),
                    Text(
                      ' one month',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: _selected[index] ? Color(0xff988763) : Colors.black,
                      ),
                    ),

                  ],
                ),
              ],
            ),
            subtitle: Text(
              _books[index+startindex]['authors'].join(', '),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[800],
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      _books[index+startindex]['description'],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 230,right: 10),

                          child: ElevatedButton(
                            child: Text('Rent'),
                            onPressed: () {
                              final book = _books[index];
                              if (book['available']) {
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                setState(() {
                                  // تحديث: تحويل حالة "available" إلى false
                                  _books[index]['available'] = false;
                                });
                              } else {
                                // الكتاب غير متاح
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Book Not Available'),
                                    content: Text('This book is currently not available .'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK',style:TextStyle(color: Colors.brown[800])),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              primary: Colors.brown,
                            ),
                          ),
                        ),

                        Container(
                          //padding: EdgeInsets.only(left: 150,right: 100),

                          child: ElevatedButton(
                            child: Text('Buy'),
                            onPressed: () {
                              final book = _books[index];
                              if (book['available']) {
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                setState(() {
                                  // تحديث: تحويل حالة "available" إلى false
                                  _books[index]['available'] = false;
                                });
                              } else {
                                // الكتاب غير متاح
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Book Not Available'),
                                    content: Text('This book is currently not available for purchase.'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              primary: Colors.brown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            onExpansionChanged: (bool selected) {
              setState(() {
                _selected[index+startindex] = selected;
              });
            },
          );
        },

      ),
    );
  }
}