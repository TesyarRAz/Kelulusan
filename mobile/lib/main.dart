import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelulusan/model/user.dart';
import 'package:kelulusan/screen/home.dart';
import 'package:kelulusan/screen/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return UserModel(
      child: MaterialApp(
        title: "Kelulusan",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        routes: {
          "/" : (_) => LoginPage(),
          "/home": (_) => HomePage()
        },
      ),
    );
  }
}

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.grey,
    systemNavigationBarIconBrightness: Brightness.dark
  ));

  runApp(MyApp());
}