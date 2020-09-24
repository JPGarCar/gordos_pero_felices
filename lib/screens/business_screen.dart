import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/services/g_p_f_icons_icons.dart';
import 'package:gordos_pero_felizes/widgets/card/custom_card.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessScreen extends StatefulWidget {
  static final String screenId = 'businessScreen';
  @override
  State<StatefulWidget> createState() {
    return _BusinessScreenState();
  }
}

class _BusinessScreenState extends State<BusinessScreen> {
  /// Default image height is 400
  // var imageHeight = 400.0; will use aspect ratio fot better quality

  // padding to be used between all the info sections
  var itemPadding = EdgeInsets.symmetric(vertical: 15);

  /// Deals with creating the cards for the carousel slider
  List<Widget> carouselItems(List<String> pathList) {
    List<Widget> list = List<Widget>();

    for (String path in pathList) {
      list.add(
        CustomCard(
          imageAssetPath: path,
          height: 400,
          isColorFilter: false,
          isOffline: false,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final Business business = ModalRoute.of(context).settings.arguments;
    // imageHeight = MediaQuery.of(context).size.height / 2;
    return SafeArea(
      child: Scaffold(
        backgroundColor: k_whiteColor,
        body: Column(
          children: [
            TitleWidget.business(
              onPressedLeftIcon: () => Navigator.pop(context),
              onPressedRightIcon: () =>
                  Navigator.pushNamed(context, UserScreen.screenId),
              mainText: business.businessName,
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              businessName: business.businessName,
              // TODO change this to user favorite
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  // only give bottom padding to differentiate between carousel
                  // and the information
                  padding: EdgeInsets.only(bottom: k_appPaddingVertical),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          //height: imageHeight,
                          autoPlay: true,
                          // this is the aspect ratio that instagram uses
                          aspectRatio: 4 / 5,
                          enlargeCenterPage: true,
                        ),
                        items: carouselItems(business.imageAssetList),
                      ),
                      Padding(
                        // resume horizontal padding outside the image carousel
                        padding: EdgeInsets.symmetric(
                            horizontal: k_appPaddingHorizontal),
                        child: Column(
                          // main column with all the information
                          children: [
                            /// Main text
                            Container(
                              padding: itemPadding,
                              child: Text(
                                business.textReview,
                                style: TextStyle(fontSize: k_textFontSize),
                              ),
                            ),

                            /// Icon reviews
                            Padding(
                              padding: itemPadding,
                              child: IconReviewRow(business: business),
                            ),

                            /// Best Plates
                            CustomListView(
                              padding: itemPadding,
                              list: business.bestPlateList,
                              title: 'Lo Que Pedimos:',
                            ),

                            /// List of tips
                            CustomListView(
                              padding: itemPadding,
                              list: business.tipList,
                              title: 'Nuestros Gordo Tips:',
                            ),

                            /// Menu TODO

                            // Wraper to make sure the area looks clean and is
                            // still responsive to the phone
                            Padding(
                              padding: itemPadding,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 15,
                                spacing: 10,
                                children: [
                                  /// Google maps
                                  RedRoundedButton(
                                    imageAsset:
                                        'images/Google_Maps_logo_icon.png',
                                    imageHeight: 30.0,
                                    buttonText: 'Ir a Google Maps',
                                    height: 50.0,
                                    padding: 0.0,
                                    onTapFunction: () {
                                      MapsLauncher.launchQuery('query');
                                    },
                                  ),

                                  /// Phone number
                                  // make sure there is a phone number to show
                                  business.phoneNumber != ''
                                      ? RedRoundedButton(
                                          padding: 0.0,
                                          height: 50.0,
                                          iconData: Icons.phone_in_talk,
                                          buttonText: business.phoneNumber,
                                          onTapFunction: () async {
                                            await launch(
                                                'tel://${business.phoneNumber}');
                                          },
                                        )
                                      : SizedBox(),

                                  /// Uber Eats
                                  RedRoundedButton(
                                    padding: 0.0,
                                    height: 50.0,
                                    imageAsset: 'images/uber_eats_logo.jpg',
                                    imageHeight: 30,
                                    buttonText: 'Uber Eats',
                                    onTapFunction: () async {
                                      await launch(
                                          'ubereats://store/browse?client_id=eats&storeUUID=UW6ihZEHRvCLtTC-aRed1Q');
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom list view, it includes a title on the top right side, followed
/// by the list of widgets, each contains a text with a leading icon
/// padding between each new list item is custom
class CustomListView extends StatelessWidget {
  CustomListView({
    @required this.list,
    @required this.title,
    this.padding = EdgeInsets.zero,
  });

  final list;
  final title;
  final padding;
  final listItemPadding = EdgeInsets.only(top: 8, right: 16, left: 16);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // custom padding for the entire widget
      padding: padding,
      // We want to make sure the list is not empty
      child: list.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title Text -> top right alignment
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                /// List of texts with leading icon
                ListView.builder(
                  // so that it works within a column
                  shrinkWrap: true,
                  // we dont want the user to be able to scroll because its length will always be shown
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: listItemPadding,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: k_iconPadding),
                            child:
                                Icon(GPFIcons.lengua, color: k_redColorLight),
                          ),
                          Flexible(
                            child: Text(
                              list[index],
                              style: TextStyle(fontSize: k_textFontSize),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          : SizedBox(),
    );
  }
}

class IconReviewRow extends StatelessWidget {
  const IconReviewRow({
    Key key,
    @required this.business,
  }) : super(key: key);

  final Business business;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: business.grabHappyIcons(
              size: 20,
              color: k_redColor,
            ),
          ),
          Row(
            children: business.grabHouseIcons(
              size: 20,
              color: k_redColor,
            ),
          ),
          Row(
            children: business.grabMoneyIcons(
              size: 20,
              color: k_redColor,
            ),
          ),
        ],
      ),
    );
  }
}
