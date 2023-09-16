import 'dart:convert';
import 'package:bibliophile/AllBooks.dart';
import 'package:bibliophile/home.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bibliophile',
      home: home(),
    );
  }
}
