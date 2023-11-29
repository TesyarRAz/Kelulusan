
class Angkatan {
  Angkatan({
    this.id,
    this.tahun,
    this.createdAt,
    this.updatedAt,
    this.galeriesCount,
    this.studentsCount,
  });

  Angkatan.fromJson(dynamic json) {
    id = json['id'];
    tahun = json['tahun'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    galeriesCount = json['galeries_count'];
    studentsCount = json['students_count'];
  }

  num? id;
  num? tahun;
  String? createdAt;
  String? updatedAt;
  num? galeriesCount;
  num? studentsCount;

  Angkatan copyWith({
    num? id,
    num? tahun,
    String? createdAt,
    String? updatedAt,
    num? galeriesCount,
    num? studentsCount,
  }) =>
      Angkatan(
        id: id ?? this.id,
        tahun: tahun ?? this.tahun,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        galeriesCount: galeriesCount ?? this.galeriesCount,
        studentsCount: studentsCount ?? this.studentsCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['tahun'] = tahun;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['galeries_count'] = galeriesCount;
    map['students_count'] = studentsCount;
    return map;
  }
}