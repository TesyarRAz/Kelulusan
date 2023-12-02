import 'package:kelulusan/model/angkatan.dart';
import 'package:kelulusan/model/kelas.dart';
import 'package:kelulusan/model/photo.dart';

class Galery {
  Galery({
    this.id,
    this.name,
    this.kelasId,
    this.angkatanId,
    this.isVisible,
    this.createdAt,
    this.updatedAt,
    this.kelas,
    this.angkatan,
    this.photos,
    this.likesCount,
    this.likeByYou,
  });

  Galery.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    kelasId = json['kelas_id'];
    angkatanId = json['angkatan_id'];
    isVisible = json['is_visible'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kelas = json['kelas'] != null ? Kelas.fromJson(json['kelas']) : null;
    angkatan =
        json['angkatan'] != null ? Angkatan.fromJson(json['angkatan']) : null;
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(Photo.fromJson(v));
      });
    }
    likesCount = json['likes_count'];
    likeByYou = json['like_by_you'];
  }

  num? id;
  String? name;
  num? kelasId;
  num? angkatanId;
  num? isVisible;
  String? createdAt;
  String? updatedAt;
  Kelas? kelas;
  Angkatan? angkatan;
  List<Photo>? photos;
  num? likesCount;
  bool? likeByYou;

  Galery copyWith({
    num? id,
    String? name,
    num? kelasId,
    num? angkatanId,
    num? isVisible,
    String? createdAt,
    String? updatedAt,
    Kelas? kelas,
    Angkatan? angkatan,
    List<Photo>? photos,
    num? likesCount,
    bool? likeByYou,
  }) =>
      Galery(
        id: id ?? this.id,
        name: name ?? this.name,
        kelasId: kelasId ?? this.kelasId,
        angkatanId: angkatanId ?? this.angkatanId,
        isVisible: isVisible ?? this.isVisible,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        kelas: kelas ?? this.kelas,
        angkatan: angkatan ?? this.angkatan,
        photos: photos ?? this.photos,
        likesCount: likesCount ?? this.likesCount,
        likeByYou: likeByYou ?? this.likeByYou,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['kelas_id'] = kelasId;
    map['angkatan_id'] = angkatanId;
    map['is_visible'] = isVisible;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (kelas != null) {
      map['kelas'] = kelas?.toJson();
    }
    if (angkatan != null) {
      map['angkatan'] = angkatan?.toJson();
    }
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['likes_count'] = likesCount;
    map['like_by_you'] = likeByYou;
    return map;
  }
}