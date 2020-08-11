import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';

const k_cardIconSize = 15.0;

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
        backgroundColor: k_whiteColor,
        bottomSheet: BottomSheet(
            onClosing: () {},
            builder: (context) {
              return SizedBox(
                height: 20,
              );
            }
            // TODO to be determined,
            ),
        body: Container(
          padding: k_appPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.list,
                    color: k_redColor,
                    size: k_iconSize,
                  ),
                  Icon(
                    Icons.account_circle,
                    color: k_redColor,
                    size: k_iconSize,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  height: 80,
                  child: Image.asset('images/gordos_logo.png'),
                ),
              ),
              Text(
                'Restaurante para cualquiér ocasión',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 30),
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: k_redColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                      color: k_whiteColor,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: k_whiteColor,
                      ),
                      hintStyle: TextStyle(
                        color: k_whiteColor,
                        fontSize: 16,
                      ),
                      hintText: 'Busca restaurantes...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: Container(
                        height: 225,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(k_circularBorderRadius),
                          image: DecorationImage(
                            image: AssetImage('images/gourmet_burger.jpg'),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black54, BlendMode.darken),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              k_circularBorderRadius),
                                          bottomLeft: Radius.circular(
                                              k_circularBorderRadius)),
                                      color: Colors.grey.shade900),
                                  height: 80,
                                  width: 115,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // TODO this should be dynamic
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.attach_money,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.attach_money,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.attach_money,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.home,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.home,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.home,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.home,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.tag_faces,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.tag_faces,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.tag_faces,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.tag_faces,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                          Icon(
                                            Icons.tag_faces,
                                            color: Colors.white,
                                            size: k_cardIconSize,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  child: Text(
                                    // TODO this title should be dynamic
                                    'Restaurantes Nuevos',
                                    style: TextStyle(
                                      color: k_whiteColor,
                                      fontSize: 26,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
