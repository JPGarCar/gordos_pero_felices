import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/card/custom_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
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
        body: Container(
          child: Column(
            children: [
              // padding for the title widget ONLY
              Padding(
                padding: EdgeInsets.only(
                    top: k_appPaddingVertical,
                    left: k_appPaddingHorizontal,
                    right: k_appPaddingHorizontal),
                child: TitleWidget(
                  leftIcon: Icons.arrow_back,
                  onPressedLeftIcon: () => Navigator.pop(context),
                  rightIcon: Icons.account_circle,
                  onPressedRightIcon: () =>
                      Navigator.pushNamed(context, UserScreen.screenId),
                  mainText: business.businessName,
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
                                  style: TextStyle(fontSize: 16),
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

                              /// Google maps
                              GoogleMapsButton(),

                              /// Menu TODO

                              /// Contact and links
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: LimitedBox(
                                  maxHeight: 80,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                'Disponible en:',
                                                style: k_16wStyle,
                                              ),
                                            ),
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CircleImageButton(
                                                    image:
                                                        'images/rappi_logo.png',
                                                  ),
                                                  CircleImageButton(
                                                    image:
                                                        'images/uber_eats_logo.jpg',
                                                    onTapLink:
                                                        'ubereats://store/browse?client_id=eats&storeUUID=UW6ihZEHRvCLtTC-aRed1Q',
                                                  ),
                                                  CircleImageButton(
                                                    image:
                                                        'images/rappi_logo.png',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: business.phoneNumber != ''
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10.0),
                                                    child: Text(
                                                      'Contacto:',
                                                      style: k_16wStyle,
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                        text: business
                                                            .phoneNumber,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap =
                                                                  () async {
                                                                await launch(
                                                                    'tel://${business.phoneNumber}');
                                                              }),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  const CustomListView({
    @required this.list,
    @required this.title,
    this.padding = EdgeInsets.zero,
  });

  final list;
  final title;
  final padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: list.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8, right: 16, left: 16),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.check, color: k_redColorLight),
                          ),
                          Flexible(
                            child: Text(
                              list[index],
                              style: TextStyle(fontSize: 16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

class GoogleMapsButton extends StatelessWidget {
  const GoogleMapsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      width: 220,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: k_redColorLight,
        onPressed: () {
          MapsLauncher.launchQuery('query');
        },
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                'images/Google_Maps_logo_icon.png',
                height: 30,
              ),
            ),
            Text('Ir a Google Maps'),
          ],
        ),
      ),
    );
  }
}

class CircleImageButton extends StatelessWidget {
  final String image;
  final String onTapLink;

  CircleImageButton({this.image, this.onTapLink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Make sure there is a onTap link if not null
      onTap: onTapLink != null
          ? () async {
              await launch(onTapLink);
            }
          : null,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
