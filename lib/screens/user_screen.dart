import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'package:gordos_pero_felizes/widgets/card/custom_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static final String screenId = 'userScreen';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  User _appUser;

  @override
  void initState() {
    _appUser = Provider.of<AppUser>(context, listen: false);
    super.initState();
  }

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
              TitleWidget(
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                mainText: 'Nombre Usuario',
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return CustomCard(
                            // TODO finish
                            isOffline: true,
                            name: _appUser.favoriteBusinessList[index],
                            imageAssetPath: 'images/gourmet_burger.jpg',
                          );
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
        ),
      ),
    );
  }
}
