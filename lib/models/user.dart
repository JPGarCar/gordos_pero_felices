import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gordos_pero_felizes/models/sex_enum.dart';

/// This is the User class, it represents a real human using the app.
class User {
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

  User(
      {this.name,
      this.lastName,
      this.email,
      this.city,
      this.day,
      this.month,
      this.year,
      this.sex,
      @required this.uid}) {
    /// set age using year if year is not null
    if (year != null) {
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

  /// Sets the users age by time difference to user's birth year
  void setAge() {
    var now = new DateTime.now();
    age = now.year - year;
  }

  /// add this user to db
  /// requires: a firestore instance to add to db
  /// assumes collection is named 'users'
  void addUserToDB(Firestore firestore) {
    firestore.collection('users').add({
      'name': name,
      'lastName': lastName,
      'email': email,
      'city': city,
      'uid': uid,
      'day': day,
      'month': month,
      'year': year,
      'age': age,
      'sex': getSexValue(sex),
    });
  }
}
