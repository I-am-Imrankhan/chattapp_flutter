// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chattapp_flutter/screens/homePage.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final phone;
  final fisrtName;
  final lastName;
  final userName;
  // ignore: use_key_in_widget_constructors
  const OTPScreen(this.phone, this.fisrtName, this.lastName, this.userName);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode = "";
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +46-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              /* fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0, */
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              /* submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration, */
              pinAnimationType: PinAnimationType.fade,
              onCompleted: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      try {
                        print('Phone numbrer is : ${widget.fisrtName}');
                      } catch (e) {
                        print("Exeption occured while saving user: $e");
                      }

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  // _scaffoldkey.currentState
                  //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator(), Text("data")],
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+46${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              CollectionReference users =
                  FirebaseFirestore.instance.collection("users");
              //print("Users collection: $users");
              try {
                FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: value.user?.uid)
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  if (querySnapshot.docs.isNotEmpty) {
                    for (var doc in querySnapshot.docs) {
                      if (doc["uid"] == value.user?.uid) return;

                      users.add({
                        'full_name': widget.fisrtName + " " + widget.lastName,
                        'first_name': widget.fisrtName,
                        'last_name': widget.lastName,
                        'uid': value.user?.uid,
                        'user_name': widget.userName,
                        'user_phone': widget.phone,
                      });
                    }
                  } else {
                    users.add({
                      'full_name': widget.fisrtName + " " + widget.lastName,
                      'first_name': widget.fisrtName,
                      'last_name': widget.lastName,
                      'uid': value.user?.uid,
                      'user_name': widget.userName,
                      'user_phone': widget.phone,
                    });
                  }
                }).catchError((e) {
                  print("Error while getting users");
                  users.add({
                    'full_name': widget.fisrtName + " " + widget.lastName,
                    'first_name': widget.fisrtName,
                    'last_name': widget.lastName,
                    'uid': value.user?.uid,
                    'user_name': widget.userName,
                    'user_phone': widget.phone,
                  });
                });
              } catch (e) {
                print(e);
              }
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (verficationID, resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
