import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/card/category_card.dart';
import 'package:gordos_pero_felizes/widgets/loading_gif.dart';
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
              /// Title Widget
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
                /// Stream builder gets collection snapshot and creates a
                /// Gridview with each new collection
                child: StreamBuilder(
                  stream: firebaseFirestore
                      .collection(fk_categoryCollection)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    /// Checks if there is data or an error, deal with both
                    if (!snapshot.hasData) {
                      return LoadingGif();
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error);
                    }

                    /// Everything is good, we can continue!
                    /// We grab the snapshot and set all the docs in documents
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),

                      /// Builder will return a Category card with the
                      /// document category
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = documents[index];
                        return doc.get('isActive')
                            ? CategoryCard(
                                category: Category.getCategoryFromDocument(doc))
                            : null;
                      },
                      itemCount: documents.length,
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
