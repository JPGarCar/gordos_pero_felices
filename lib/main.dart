import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/screens/business_screen.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';

import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gordos Pero Felizes',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        "/": (context) => HomeScreen(),
        "/categoryPage": (context) => CategoryScreen(),
        "/businessPage": (context) => BusinessScreen(),
      },
      initialRoute: "/",
    );
  }
}
