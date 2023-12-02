import 'package:flutter/material.dart';
import 'package:kelulusan/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier {
  UserLogin? _user;

  set user(UserLogin value) {
    var temp = value;
    _user = value;
    if (_user != temp) {
      notifyListeners();
    }

    SharedPreferences.getInstance().then((prefs) {
      if (_user != null) {
        prefs.setString("token", value.token);
      } else {
        prefs.remove("token");
      }
    });
  }

  UserLogin get user => _user!;
}