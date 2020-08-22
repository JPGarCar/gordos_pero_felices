import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/card/category_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

import '../constants.dart';

/// This screen holds all the available categories!
class CategoriesScreen extends StatefulWidget {
  static final String screenId = 'categoriesScreen';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
                rightIcon: Icons.account_circle,
                onPressedRightIcon: () =>
                    Navigator.pushNamed(context, UserScreen.screenId),
                mainText: 'Categorías',
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream:
                      firebaseFirestore.collection('categories').snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error);
                    }
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<DocumentChange> changedDocs = querySnapshot.docChanges;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = changedDocs[index].doc;
                        return doc.get('isActive')
                            ? CategoryCard(
                                category: Category.getCategoryFromDocument(doc))
                            : null;
                      },
                      itemCount: changedDocs.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
