import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';

class DropDownItemsGetter {
  /// Deals with adding all the available categories to a dropdown list
  static void getCategories(
      {FirebaseFirestore firebaseFirestore,
      Function(List<DropdownMenuItem> dropDownItems) finalThenFunction}) {
    List<DropdownMenuItem> dropDownItems = List<DropdownMenuItem>();

    firebaseFirestore.collection(fk_categoryCollection).get().then(
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
        finalThenFunction(dropDownItems);
      },
    );
  }

  /// Deals with grabbing all the businesses
  static void getBusinesses(
      {FirebaseFirestore firebaseFirestore,
      Function(
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
