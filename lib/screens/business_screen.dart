import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BusinessScreenState();
  }
}

class _BusinessScreenState extends State<BusinessScreen> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("GPF"),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Center(
                      child: Image.asset(
                        "images/ryoshi_img$i.jpg",
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            // Row with Business Name and Icon Rating
            Container(
              height: 40,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OverflowBox(
                      child: Text(
                        "Ryoshi",
                        style: TextStyle(fontSize: 50),
                      ),
                      alignment: Alignment.bottomLeft,
                      maxHeight: 100,
                      minHeight: 20,
                      maxWidth: 160,
                    ),
                    flex: 1,
                  ), // Business Name
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        // Row of $
                        Padding(
                          padding: const EdgeInsets.all(2.5),
                          child:
                              Row(children: getIconList(Icons.attach_money, 3)),
                        ),

                        // Row of Happy Faces
                        Padding(
                          padding: const EdgeInsets.all(2.5),
                          child: Row(children: getIconList(Icons.tag_faces, 3)),
                        ),

                        // Row of Houses
                        Padding(
                          padding: const EdgeInsets.all(2.5),
                          child: Row(children: getIconList(Icons.home, 3)),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                ],
              ),
            ),
            // Carousel with the business images

            // Tabs with information
            /*
             * 1- Review
             * 2- pros
             * 3- Cons
             * 4- Final
             * 5- Menu
             */
            // TODO TabBar
            Container(
              height: 300,
              child: DefaultTabController(
                length: 5,
                child: Scaffold(
                  appBar: TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: "Review",
                      ),
                      Tab(
                        text: "Pros",
                      ),
                      Tab(
                        text: "Cons",
                      ),
                      Tab(
                        text: "Final",
                      ),
                      Tab(
                        text: "Menu",
                      ),
                    ],
                    labelColor: Colors.red,
                  ),
                  body: TabBarView(children: [
                    Card(
                      child: Center(
                        child: Text(
                          "Sample Text",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      color: Colors.red,
                    ),
                    Text("Sample Text"),
                    Text("Sample Text"),
                    Text("Sample Text"),
                    Text("Sample Text")
                  ]),
                ),
              ),
            ),

            // Divider
            Divider(
              height: 25,
              thickness: 2,
              color: Colors.red.shade200,
              endIndent: 5,
              indent: 5,
            ),

            // Row with Links to Order and Phone
            // TODO
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Text("Uber Eats Image"),
                  ),
                  Container(
                    height: 50,
                    child: Text("Rappi Image"),
                  ),
                  Container(
                    height: 50,
                    child: Text("Phone Number"),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),

            // Google Map
            // TODO
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                child: Center(
                  child: Text("Google Maps"),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
