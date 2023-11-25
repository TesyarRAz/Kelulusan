import 'package:flutter/material.dart';

class User {
  User({required this.nis, required this.nama, required this.kompetensi, required this.password, required this.keterangan, required this.pdf});

  String nis;
  String nama;
  String kompetensi;
  String password;
  String keterangan;
  String pdf;

  factory User.parseFromJson(Map<String, dynamic> map) => User(
    nis: map['nis'],
    nama: map['nm_siswa'],
    kompetensi: map['kompetensi_keahlian'],
    password: map['password'],
    keterangan: map['keterangan'],
    pdf: map['pdf']
  );
}

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