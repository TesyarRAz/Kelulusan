import 'package:flutter/material.dart';

class User {
  User({this.nis, this.nama, this.kompetensi, this.password, this.keterangan, this.pdf});

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
  UserModel({Key key, Widget child}) : super(
    key: key, 
    child: child
  );

  User user;
  // User user = User(
  //   keterangan: "LULUS",
  //   kompetensi: "Otomatisasi dan Keuangan Lembaga",
  //   nama: "Dewi Rubianti",
  //   nis: "11707290",
  //   password: "11707290"
  // );

  @override
  bool updateShouldNotify(UserModel oldWidget) {
    return false;
  }

  static UserModel of(BuildContext context) => context.inheritFromWidgetOfExactType(UserModel);
}