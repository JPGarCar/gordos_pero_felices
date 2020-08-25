import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'file:///C:/Users/juapg/_Programming_Projects/AndroidStudioProjects/GordosPeroFelizes/gordos_pero_felizes/lib/widgets/card/business_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

/// This screen holds all the businesses in one category!
class CategoryScreen extends StatefulWidget {
  static final String screenId = 'categoryScreen';
  @override
  State<StatefulWidget> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: k_whiteColor,
        body: Container(
          padding: k_appPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Title widget with back arrow and account circle, no search bar
              TitleWidget(
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                rightIcon: Icons.account_circle,
                onPressedRightIcon: () =>
                    Navigator.pushNamed(context, UserScreen.screenId),
                mainText:
                    'Restaurantes ${Provider.of<Category>(context, listen: false).name}',
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              /// Listbuilder of all the businessReferences in the category
              /// itemBuilder calls a FutureBuilder which grabs the Business
              /// from a businessReferences in the category by calling the
              /// Business static function getBusinessFromDB()
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: Business.getBusinessFromDB(
                          Provider.of<Category>(context, listen: false)
                              .businessReferences[index]),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        /// Check if there is data or for an error
                        if (!snapshot.hasData) {
                          return Icon(
                              Icons.update); // TODO return loading widget
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error);
                        }

                        /// All good, we can continue
                        /// check if business is active, else do not build card
                        Business business = snapshot.data;
                        return business.isActive
                            ? BusinessCard(
                                business: business,
                              )
                            : SizedBox();
                      },
                    );
                  },
                  itemCount: Provider.of<Category>(context, listen: false)
                      .businessReferences
                      .length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
