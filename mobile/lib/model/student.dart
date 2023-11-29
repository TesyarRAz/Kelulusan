import 'package:kelulusan/model/angkatan.dart';
import 'package:kelulusan/model/kelas.dart';

class Student {
  Student({
    this.id,
    this.userId,
    this.kelasId,
    this.angkatanId,
    this.noInduk,
    this.createdAt,
    this.updatedAt,
    this.kelas,
    this.angkatan,
  });

  Student.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    kelasId = json['kelas_id'];
    angkatanId = json['angkatan_id'];
    noInduk = json['no_induk'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kelas = json['kelas'] != null ? Kelas.fromJson(json['kelas']) : null;
    angkatan =
        json['angkatan'] != null ? Angkatan.fromJson(json['angkatan']) : null;
  }

  num? id;
  num? userId;
  num? kelasId;
  num? angkatanId;
  String? noInduk;
  String? createdAt;
  String? updatedAt;
  Kelas? kelas;
  Angkatan? angkatan;

  Student copyWith({
    num? id,
    num? userId,
    num? kelasId,
    num? angkatanId,
    String? noInduk,
    String? createdAt,
    String? updatedAt,
    Kelas? kelas,
    Angkatan? angkatan,
  }) =>
      Student(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        kelasId: kelasId ?? this.kelasId,
        angkatanId: angkatanId ?? this.angkatanId,
        noInduk: noInduk ?? this.noInduk,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        kelas: kelas ?? this.kelas,
        angkatan: angkatan ?? this.angkatan,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['kelas_id'] = kelasId;
    map['angkatan_id'] = angkatanId;
    map['no_induk'] = noInduk;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (kelas != null) {
      map['kelas'] = kelas?.toJson();
    }
    if (angkatan != null) {
      map['angkatan'] = angkatan?.toJson();
    }
    return map;
  }
}
