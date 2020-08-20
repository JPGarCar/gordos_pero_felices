import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/custom_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class BusinessScreen extends StatefulWidget {
  static final String screenId = 'businessScreen';
  @override
  State<StatefulWidget> createState() {
    return _BusinessScreenState();
  }
}

List<Widget> listOf(List<String> list, TextStyle textStyle) {
  List<Text> texts;
  texts = list
      .map((e) => Text(
            e,
            style: textStyle,
          ))
      .toList();
  return texts;
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  Widget build(BuildContext context) {
    final Business business = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: k_whiteColor,
        body: Container(
          child: Column(
            children: [
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
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 400,
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          CustomCard(
                            imageAssetPath: 'images/ryoshi_img1.jpg',
                            height: 400,
                            isColorFilter: false,
                          ),
                          CustomCard(
                            imageAssetPath: 'images/ryoshi_img2.jpg',
                            height: 400,
                            isColorFilter: false,
                          ),
                          CustomCard(
                            imageAssetPath: 'images/ryoshi_img3.jpg',
                            height: 400,
                            isColorFilter: false,
                          ),
                          CustomCard(
                            imageAssetPath: 'images/ryoshi_img4.jpg',
                            height: 400,
                            isColorFilter: false,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: k_appPaddingHorizontal),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                business.textReview,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            business.bestPlateList.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Lo que pedimos:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Column(
                                          children: listOf(
                                            business.bestPlateList,
                                            TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            business.tipList.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Nuestros Gordo Tips:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Column(
                                          children: listOf(
                                            business.tipList,
                                            TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
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
