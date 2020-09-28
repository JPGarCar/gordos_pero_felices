import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/loading_gif.dart';
import 'package:gordos_pero_felizes/widgets/card/business_card.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Title widget with back arrow and account circle, no search bar
            TitleWidget(
              isAppPadding: true,
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

            /// ListView with all businesses in the category;
            /// we use a stream builder to keep businesses updated in case they
            /// change while the user has them open;
            /// We then use a future builder to get a business local object
            /// out of the stream snapshot
            Expanded(
              child: ListView.builder(
                padding: k_appPadding,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                      stream: Provider.of<Category>(context)
                          .businessReferences[index]
                          .snapshots(),
                      builder: (context, snapshot) {
                        /// Check if there is data or for an error
                        if (!snapshot.hasData) {
                          return LoadingGif();
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error);
                        }

                        /// All good, we can continue
                        /// check if business is active, else do not build card
                        Business business =
                            Business.getBusinessFromDBForStream(snapshot.data);
                        return business.isActive
                            ? BusinessCard(
                                business: business,
                              )
                            : SizedBox();
                      });
                },
                itemCount:
                    Provider.of<Category>(context).businessReferences.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
