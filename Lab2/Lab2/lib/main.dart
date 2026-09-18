import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const GemStoreApp());
}

class GemStoreApp extends StatelessWidget {
  const GemStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GemStore',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}