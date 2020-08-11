import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String screenId = 'homeScreen';
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          // TODO construct the side menu as a list
          child: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            primary: false,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/categoryPage");
                },
                child: Card(
                  color: Colors.red.shade400,
                  child: Center(child: Text("Category")),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("GPF"),
          centerTitle: true,
          primary: true,
          actions: <Widget>[
            // TODO link the icons to the pages
            Icon(Icons.favorite),
            Container(
              width: 10,
            ),
            Icon(Icons.account_circle),
          ],
          // TODO add the search bar as a bottom
          bottom: AppBar(
            automaticallyImplyLeading: false,
            leading: Icon(Icons.search),
            title: TextField(),
            actions: <Widget>[
              RaisedButton(
                onPressed: null,
                child: Text("Sorprendeme!"),
              )
            ],
          ),
        ),
        // TODO to be determined,
      ),
    );
  }
}
