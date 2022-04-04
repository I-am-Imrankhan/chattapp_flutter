/* import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService extends StatelessWidget {
  final String fullName = "Imran Khan";
  final String company = "Actic";
  final int age = 36;

  //FirestoreService(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = Firestore.instance.collection('users');
    // Create a CollectionReference called user
    //s that references the firestore collection
    //CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user

      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
            
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}
 */