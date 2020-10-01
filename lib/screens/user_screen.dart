import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/widgets/card/business_card.dart';
import 'package:gordos_pero_felizes/widgets/loading_gif.dart';
import 'package:gordos_pero_felizes/widgets/parent_widget.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static final String screenId = 'userScreen';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  AppUser _appUser;

  @override
  void initState() {
    _appUser = Provider.of<AppUser>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      bodyChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleWidget(
            isAppPadding: true,
            leftIcon: Icons.arrow_back,
            onPressedLeftIcon: () => Navigator.pop(context),
            mainText: _appUser.name,
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            secondaryText: 'Tus Favoritos',
            secondaryTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          _appUser.favoriteBusinessList.isNotEmpty
              ? Expanded(
                  child: GridView.builder(
                    padding: k_appPadding,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                          future: Business.getBusinessFromDB(
                              _appUser.favoriteBusinessList[index]),
                          builder: (context, snapshot) {
                            /// Check if there is data or for an error
                            if (!snapshot.hasData) {
                              return LoadingGif();
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error);
                            }

                            /// All good, we can continue
                            /// check if business is active, else do not build card
                            Business business = snapshot.data;
                            return business.isActive
                                ? BusinessCard(
                                    isOverlay: false,
                                    business: business,
                                  )
                                : SizedBox();
                          });
                    },
                    itemCount: _appUser.favoriteBusinessList.length,
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text('Aun no tienes favoritos!'),
                  ),
                ),
        ],
      ),
    );
  }
}
