import 'package:ch6/FirstPage.dart';
import 'package:flutter/material.dart';

import 'SecondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const FirstPage(),
        routes: {
          '/first' : (context)=>FirstPage(),
          '/second' : (context)=>SecondPage(),
        }
    );
  }
}