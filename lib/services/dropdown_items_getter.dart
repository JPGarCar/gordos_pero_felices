import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';

class DropDownItemsGetter {
  /// Firebase instance
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// Will return a future with a list of drop down menu items,
  /// each item will have the category name as value and its text as child
  static Future<List<DropdownMenuItem>> getCategories() async {
    List<DropdownMenuItem> dropDownItems = List<DropdownMenuItem>();

    await firebaseFirestore.collection(fk_categoryCollection).get().then(
      (value) {
        List<QueryDocumentSnapshot> listOfDocs = value.docs;
        for (QueryDocumentSnapshot queryDocumentSnapshot in listOfDocs) {
          dropDownItems.add(
            DropdownMenuItem(
              child: Text(
                queryDocumentSnapshot.get(fk_categoryName),
              ),
              value: queryDocumentSnapshot.id,
            ),
          );
        }
      },
    );
    return dropDownItems;
  }

  /// Deals with grabbing all the businesses
  static void getBusinesses(
      {Function(
              List<DropdownMenuItem> dropDownItems, QuerySnapshot querySnapshot)
          thenFinalFunction}) {
    List<DropdownMenuItem> dropDownItems = List<DropdownMenuItem>();

    firebaseFirestore
        .collection(fk_businessCollection)
        .get()
        .then((QuerySnapshot value) {
      value.docs.forEach((QueryDocumentSnapshot element) {
        dropDownItems.add(
          DropdownMenuItem(
            value: element.id,
            child: Text(element.id),
          ),
        );
      });
      thenFinalFunction(
        dropDownItems,
        value,
      );
    });
  }
}
