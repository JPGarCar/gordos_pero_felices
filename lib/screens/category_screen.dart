import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gordos_pero_felizes/widgets/custom_popupMenuButton.dart';

class CategoryScreen extends StatefulWidget {
  static final String screenId = 'categoryScreen';
  @override
  State<StatefulWidget> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Widget> getIconList(IconData iconData, int amount) {
    List<Widget> moneyList = new List();
    for (var i = 0; i < amount; i++) {
      moneyList.add(Icon(
        iconData,
        color: Colors.red,
      ));
    }
    return moneyList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("GPF"),
          centerTitle: true,
          actions: <Widget>[
            // TODO link the icons to the pages
            Icon(Icons.favorite),
            Container(
              width: 10,
            ),
            Icon(Icons.account_circle),
          ],
        ),
        body: Column(
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      border: Border.all(color: Colors.red, width: 2)),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Category Name"),
                      Row(
                        children: <Widget>[
                          CustomPopupMenuButton(iconData: Icons.attach_money),
                          CustomPopupMenuButton(iconData: Icons.tag_faces),
                          CustomPopupMenuButton(iconData: Icons.home),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/businessPage");
                    },
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Center(child: Text("Image")),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    children:
                                        getIconList(Icons.attach_money, 2),
                                  ),
                                  Row(
                                    children: getIconList(Icons.tag_faces, 1),
                                  ),
                                  Row(
                                    children: getIconList(Icons.home, 3),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: Container(
                      height: 250,
                    ),
                  ),
                  Card(
                    child: Container(
                      height: 250,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
