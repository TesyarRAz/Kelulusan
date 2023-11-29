import 'package:kelulusan/model/role.dart';
import 'package:kelulusan/model/student.dart';

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.roles,
    this.student,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['roles'] != null) {
      roles = [];
      json['roles'].forEach((v) {
        roles?.add(Role.fromJson(v));
      });
    }
    student =
        json['student'] != null ? Student.fromJson(json['student']) : null;
  }

  num? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  List<Role>? roles;
  Student? student;

  User copyWith({
    num? id,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    List<Role>? roles,
    Student? student,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        roles: roles ?? this.roles,
        student: student ?? this.student,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (roles != null) {
      map['roles'] = roles?.map((v) => v.toJson()).toList();
    }
    if (student != null) {
      map['student'] = student?.toJson();
    }
    return map;
  }
}
