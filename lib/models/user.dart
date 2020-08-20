import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/sex_enum.dart';

/// This is the User class, it represents a real human using the app.
class User {
  static Future<User> getUserFromDB(Firestore firestore, String uid) async {
    var dbUser = await firestore.collection('users').document(uid).get();
    var dbUserData = dbUser.data;

    return User(
      name: dbUserData['name'],
      lastName: dbUserData['lastName'],
      email: dbUserData['email'],
      city: dbUserData['city'],
      day: dbUserData['day'],
      month: dbUserData['month'],
      year: dbUserData['year'],
      age: dbUserData['age'],
      sex: getSexEnum(dbUserData['sex']),
      uid: dbUser.documentID,
    );
  }

  static void setUserFromDB(Firestore firestore, String uid, User user) async {
    var dbUser = await firestore.collection('users').document(uid).get();
    var dbUserData = dbUser.data;

    return user.setValues(
      name: dbUserData['name'],
      lastName: dbUserData['lastName'],
      email: dbUserData['email'],
      city: dbUserData['city'],
      day: dbUserData['day'],
      month: dbUserData['month'],
      year: dbUserData['year'],
      age: dbUserData['age'],
      sex: getSexEnum(dbUserData['sex']),
      uid: dbUser.documentID,
      favoriteBusinessList: dbUserData['favorites'],
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

  /// Will use this var to connect the Auth user to db user
  String uid;

  /// will use business name's to id them from db
  List<String> favoriteBusinessList;

  User.empty();

  User(
      {this.name,
      this.lastName,
      this.email,
      this.city,
      this.day,
      this.month,
      this.year,
      this.sex,
      this.age,
      @required this.uid}) {
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
    favoriteBusinessList = [];
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
  }) {
    this.name = name;
    this.lastName = lastName;
    this.email = email;
    this.city = city;
    this.day = day;
    this.month = month;
    this.year = year;
    this.age = age;
    this.sex = sex;
    this.uid = uid;
    this.favoriteBusinessList = favoriteBusinessList;
  }

  /// Sets the users age by time difference to user's birth year
  void setAge() {
    var now = new DateTime.now();
    age = now.year - year;
  }

  /// add this user to db
  /// requires: a firestore instance to add to db
  /// assumes collection is named 'users'
  void addUserToDB(Firestore firestore) {
    firestore.collection('users').document(uid).setData({
      'name': name,
      'lastName': lastName,
      'email': email,
      'city': city,
      'day': day,
      'month': month,
      'year': year,
      'age': age,
      'sex': getSexValue(sex),
    });
  }
}
