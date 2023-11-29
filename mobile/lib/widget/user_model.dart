import 'package:flutter/material.dart';
import 'package:kelulusan/model/user.dart';

class UserModel extends InheritedWidget {
  UserModel({Key? key, required Widget child}) : super(
      key: key,
      child: child
  );

  User? user;

  @override
  bool updateShouldNotify(UserModel oldWidget) {
    return false;
  }

  static UserModel? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<UserModel>();

  static UserModel of(BuildContext context) {
    var result = maybeOf(context);
    assert(result != null, 'No UserModel found in context');
    return result!;
  }
}