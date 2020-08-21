import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/sex_enum.dart';

/// This is the User class, it represents a real human using the app.
class AppUser {
  static Future<AppUser> getUserFromDB(
      FirebaseFirestore firestore, String uid) async {
    DocumentSnapshot dbUser =
        await firestore.collection('users').doc(uid).get();
    Map<String, dynamic> dbUserData = dbUser.data();

    return AppUser(
      name: dbUserData['name'],
      lastName: dbUserData['lastName'],
      email: dbUserData['email'],
      city: dbUserData['city'],
      day: dbUserData['day'],
      month: dbUserData['month'],
      year: dbUserData['year'],
      age: dbUserData['age'],
      sex: getSexEnum(dbUserData['sex']),
      uid: dbUser.id,
      favoriteBusinessList: dbUserData['favorites'],
      isAdmin: dbUserData['isAdmin'],
    );
  }

  static void setUserFromDB(
      FirebaseFirestore firestore, String uid, AppUser user) async {
    DocumentSnapshot dbUser =
        await firestore.collection('users').doc(uid).get();
    Map<String, dynamic> dbUserData = dbUser.data();

    user.setValues(
      name: dbUserData['name'],
      lastName: dbUserData['lastName'],
      email: dbUserData['email'],
      city: dbUserData['city'],
      day: dbUserData['day'],
      month: dbUserData['month'],
      year: dbUserData['year'],
      age: dbUserData['age'],
      sex: getSexEnum(dbUserData['sex']),
      uid: dbUser.id,
      favoriteBusinessList: dbUserData['favorites'].cast<String>(),
      isAdmin: dbUserData['isAdmin'],
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
    firestore.collection('users').doc(uid).set({
      'name': name,
      'lastName': lastName,
      'email': email,
      'city': city,
      'day': day,
      'month': month,
      'year': year,
      'age': age,
      'sex': getSexValue(sex),
      'favorites': favoriteBusinessList,
      'isAdmin': isAdmin,
    });
  }
}
