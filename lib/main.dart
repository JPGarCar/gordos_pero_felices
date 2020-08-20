import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/screens/business_screen.dart';
import 'package:gordos_pero_felizes/screens/categories_screen.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';
import 'package:gordos_pero_felizes/screens/initial_screen.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<User>(
      create: (_) => User.empty(),
      child: MaterialApp(
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
          UserScreen.screenId: (context) => UserScreen(),
        },
        initialRoute: HomeScreen.screenId,
      ),
    );
  }
}
