import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/screens/business_screen.dart';
import 'package:gordos_pero_felizes/screens/categories_screen.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';
import 'package:gordos_pero_felizes/screens/initial_screen.dart';

import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gordos Pero Felizes',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.red,
      ),
      routes: {
        HomeScreen.screenId: (context) => HomeScreen(),
        CategoryScreen.screenId: (context) => CategoryScreen(),
        BusinessScreen.screenId: (context) => BusinessScreen(),
        InitialScreen.screenId: (context) => InitialScreen(),
        CategoriesScreen.screenId: (context) => CategoriesScreen(),
      },
      initialRoute: HomeScreen.screenId,
    );
  }
}
