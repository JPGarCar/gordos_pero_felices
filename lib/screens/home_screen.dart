import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/widgets/business_card.dart';
import 'package:gordos_pero_felizes/widgets/category_card.dart';

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
                    return CategoryCard(
                      category: Category(
                        name: 'Burgers',
                        imageAssetPath: 'images/gourmet_burger.jpg',
                      ),
                    );
                  },
                  itemCount: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
