import 'package:flutter/material.dart';
import 'package:pixabayapp/screen/image.dart';
import 'package:pixabayapp/screen/secoundpage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'SecondPage': (context) => const SecondPage(),
      },
    ),
  );
}
