import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/menu_screen.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/card/category_card.dart';
import 'package:gordos_pero_felizes/widgets/custom/custom_bottom_sheet.dart'
    as cbs;
import 'package:gordos_pero_felizes/widgets/loading_gif.dart';
import 'package:gordos_pero_felizes/widgets/parent_widget.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class HomeScreen extends StatefulWidget {
  static final String screenId = 'homeScreen';
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  /// class variables
  var firebase = FirebaseFirestore.instance;

  /// will show the custom modal bottom sheet
  dynamic showCustomModalBottomSheet(BuildContext context) {
    return cbs.showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(k_circularBorderRadius),
            topRight: Radius.circular(k_circularBorderRadius),
          ),
        ),
        context: context,
        builder: (context) {
          return MenuScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      bodyChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleWidget(
            isAppPadding: true,
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
            ),
            isSearchBar: true,
            mainText: 'Restaurante para cualquiér ocasión',
            rightIcon: Icons.account_circle,
            onPressedRightIcon: () =>
                Navigator.pushNamed(context, UserScreen.screenId),
            leftIcon: Icons.list,
            onPressedLeftIcon: () => showCustomModalBottomSheet(context),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  firebase.collection(fk_specialCategoryCollection).snapshots(),
              builder: (context, snapshot) {
                // check to make sure there is data
                if (!snapshot.hasData) {
                  return LoadingGif();
                } else if (snapshot.hasError) {
                  return Icon(Icons.error);
                }

                // Everything is good, we can continue!
                // We grab the snapshot and set all the docs in documents
                // we also make sure we only proceed with active documents
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                documents.removeWhere((element) => !element.get('isActive'));

                // Will return a list view with cards for each category
                return ListView.builder(
                  padding: k_appPadding,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = documents[index];
                    return CategoryCard(
                        category: Category.getCategoryFromDocument(doc));
                  },
                  itemCount: documents.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
