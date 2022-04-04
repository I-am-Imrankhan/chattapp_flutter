import 'package:flutter/material.dart';

class LoginControllers extends ChangeNotifier {
  late bool phoneNumberisfilled;
  bool _filledPhoneNum() {
    return phoneNumberisfilled;
  }

  var _firstName = "";
  String get firstName => _firstName;

  var _lastName = "";
  String get lastName => _lastName;

  var _userName = "";
  String get userName => _userName;

  int _phoneNumber = 0;
  int get phone => _phoneNumber;

  void setFirstName(fName) {
    _firstName = fName;
  }

  void setLastName(lName) {
    _lastName = lName;
  }

  void setUserName(uName) {
    _userName = uName;
  }

  void setPhone(phone) {
    _phoneNumber = phone;
  }
}
