import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/models/sex_enum.dart';

/// This is the User class, it represents a real human using the app.
class AppUser {
  static Future<AppUser> getUserFromDB(
      FirebaseFirestore firestore, String uid) async {
    DocumentSnapshot dbUser =
        await firestore.collection(fk_usersCollection).doc(uid).get();
    Map<String, dynamic> dbUserData = dbUser.data();

    return AppUser(
      name: dbUserData[fk_userName],
      lastName: dbUserData[fk_lastName],
      email: dbUserData[fk_email],
      city: dbUserData[fk_city],
      day: dbUserData[fk_day],
      month: dbUserData[fk_month],
      year: dbUserData[fk_year],
      age: dbUserData[fk_age],
      sex: getSexEnum(dbUserData[fk_sex]),
      uid: dbUser.id,
      favoriteBusinessList: dbUserData[fk_userFavorites].cast<String>(),
      isAdmin: dbUserData[fk_isAdmin],
    );
  }

  /// Will set the given User object values to the firebase user given uid
  static void setValuesFromDBUser(
      FirebaseFirestore firestore, String uid, AppUser user) async {
    DocumentSnapshot dbUser =
        await firestore.collection(fk_usersCollection).doc(uid).get();
    Map<String, dynamic> dbUserData = dbUser.data();

    user.setValues(
      name: dbUserData[fk_userName],
      lastName: dbUserData[fk_lastName],
      email: dbUserData[fk_email],
      city: dbUserData[fk_city],
      day: dbUserData[fk_day],
      month: dbUserData[fk_month],
      year: dbUserData[fk_year],
      age: dbUserData[fk_age],
      sex: getSexEnum(dbUserData[fk_sex]),
      uid: dbUser.id,
      favoriteBusinessList: dbUserData[fk_userFavorites].cast<String>(),
      isAdmin: dbUserData[fk_isAdmin],
    );
  }

  String name;
  String lastName;
  String email;
  String city;
  int day;
  int month;
  int year;
  int age;
  Sex sex;
  bool isAdmin;

  /// Will use this var to connect the Auth user to db user
  String uid;

  /// will use business name's to id them from db
  List<String> favoriteBusinessList;

  AppUser.empty() {
    favoriteBusinessList = List<String>();
  }

  AppUser(
      {this.name,
      this.lastName,
      this.email,
      this.city,
      this.day,
      this.month,
      this.year,
      this.sex,
      this.age,
      @required this.uid,
      this.favoriteBusinessList,
      this.isAdmin = false}) {
    /// set age using year if year is not null
    if (age == null && year != null) {
      setAge();
    } else {
      age = 0;
    }

    /// Set sex to other if null
    if (sex == null) {
      sex = Sex.other;
    }
    if (favoriteBusinessList == null) {
      favoriteBusinessList = List<String>();
    }
  }

  void setValues({
    String name,
    String lastName,
    String email,
    String city,
    int day,
    int month,
    int year,
    int age,
    Sex sex,
    String uid,
    List<String> favoriteBusinessList,
    bool isAdmin,
  }) {
    this.isAdmin = isAdmin ?? this.isAdmin;
    this.name = name ?? this.name;
    this.lastName = lastName ?? this.lastName;
    this.email = email ?? this.email;
    this.city = city ?? this.city;
    this.day = day ?? this.day;
    this.month = month ?? this.month;
    this.year = year ?? this.year;
    this.age = age ?? this.age;
    this.sex = sex ?? this.sex;
    this.uid = uid ?? this.uid;
    this.favoriteBusinessList =
        favoriteBusinessList ?? this.favoriteBusinessList;
    if (age == null) {
      setAge();
    }
  }

  /// Sets the users age by time difference to user's birth year
  void setAge() {
    var now = new DateTime.now();
    age = now.year - year;
  }

  /// add this user to db
  /// requires: a firestore instance to add to db
  /// assumes collection is named 'users'
  void addUserToDB(FirebaseFirestore firestore) {
    firestore.collection(fk_usersCollection).doc(uid).set({
      fk_userName: name,
      fk_lastName: lastName,
      fk_email: email,
      fk_city: city,
      fk_day: day,
      fk_month: month,
      fk_year: year,
      fk_age: age,
      fk_sex: getSexValue(sex),
      fk_userFavorites: favoriteBusinessList,
      fk_isAdmin: isAdmin,
    });
  }
}
