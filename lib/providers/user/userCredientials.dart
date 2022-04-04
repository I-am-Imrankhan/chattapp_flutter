import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserCredientials {
  String _user_firstname = "";
  String _user_lastname = "";
  String _username = "";
  String _user_phone = "";
  String get user_first_name => _user_firstname;
  String get user_lastname => _user_lastname;
  String get username => _username;
  String get user_phone => _user_phone;
  String _user_fullName = "";
  String get user_fullName => _user_fullName;

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  UserCredientials(this.firebaseFirestore, this.firebaseAuth);

  meth(value) {
    //DocumentSnapshot documentSnapshot = value;
    print("Check with userID: ${value}");
  }

  Future<void> getUSerData() async {
    var currentUser = firebaseAuth.currentUser;

    //CollectionReference users = FirebaseFirestore.instance.collection("users");
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        _user_firstname = doc["first_name"];
        _user_lastname = doc["last_name"];
        //_user_phone = doc["phone"];
        _user_fullName = doc["full_name"];
        _username = doc["user_name"];
        _user_phone = doc["user_phone"];
      }
    });
    /* users
        .where('uid',
            isEqualTo: firebaseAuth
                .currentUser?.uid /* 'vgzCpN4xzmUcY3TuuDZKjMS4TCh2' */)
        .get()
        .then((v) => v.docs.map((e) => print(e)))
        .catchError((error) => print("Failed to update user: $error")); */
    /* .where('uid', isEqualTo: 'vgzCpN4xzmUcY3TuuDZKjMS4TCh2')
        .get()
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error")); */
    //QuerySnapshot user;
    //print(users);

    /* FirebaseFirestore.instance
        .collection('users')
        //.doc('ry5zPUSJr1O2VXICzlSL')
        .doc(users.id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    }); */

    //users.get();
    //QuerySnapshot user = await users.get();

    /* final data = user.docs.map((m) => {
          print("Collection data for all users: ÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆ ${m}")
        }); */

    // Get docs from collection reference
    /*  QuerySnapshot querySnapshot = await users.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList(); */
  }
}
