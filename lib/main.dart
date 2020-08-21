import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/screens/admin/new_business_screen.dart';
import 'package:gordos_pero_felizes/screens/admin/new_category_screen.dart';
import 'package:gordos_pero_felizes/screens/admin_panel_screen.dart';
import 'package:gordos_pero_felizes/screens/business_screen.dart';
import 'package:gordos_pero_felizes/screens/categories_screen.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';
import 'package:gordos_pero_felizes/screens/initial_screen.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:provider/provider.dart';

import 'models/app_user.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppUser>(
      create: (_) => AppUser.empty(),
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
          AdminPanelScreen.screenId: (context) => AdminPanelScreen(),
          NewCategoryScreen.screenId: (context) => NewCategoryScreen(),
          NewBusinessScreen.screenId: (context) => NewBusinessScreen(),
        },
        initialRoute: InitialScreen.screenId,
      ),
    );
  }
}
