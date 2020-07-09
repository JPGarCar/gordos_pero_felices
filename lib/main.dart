import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/business_page.dart';
import 'package:gordos_pero_felizes/category_page.dart';

import 'home_page.dart';

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
        "/": (context) => HomePage(),
        "/categoryPage": (context) => CategoryPage(),
        "/businessPage": (context) => BusinessPage(),
      },
      initialRoute: "/",
    );
  }
}
