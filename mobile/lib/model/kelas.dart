class Kelas {
  Kelas({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.galeriesCount,
    this.studentsCount,
  });

  Kelas.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    galeriesCount = json['galeries_count'];
    studentsCount = json['students_count'];
  }

  num? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  num? galeriesCount;
  num? studentsCount;

  Kelas copyWith({
    num? id,
    String? name,
    String? createdAt,
    String? updatedAt,
    num? galeriesCount,
    num? studentsCount,
  }) =>
      Kelas(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        galeriesCount: galeriesCount ?? this.galeriesCount,
        studentsCount: studentsCount ?? this.studentsCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['galeries_count'] = galeriesCount;
    map['students_count'] = studentsCount;
    return map;
  }
}
