class Role {
  Role({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Role.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  num? id;
  String? name;
  String? guardName;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  Role copyWith({
    num? id,
    String? name,
    String? guardName,
    dynamic createdAt,
    dynamic updatedAt,
    Pivot? pivot,
  }) =>
      Role(
        id: id ?? this.id,
        name: name ?? this.name,
        guardName: guardName ?? this.guardName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['guard_name'] = guardName;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }
}

class Pivot {
  Pivot({
    this.modelType,
    this.modelId,
    this.roleId,
  });

  Pivot.fromJson(dynamic json) {
    modelType = json['model_type'];
    modelId = json['model_id'];
    roleId = json['role_id'];
  }

  String? modelType;
  num? modelId;
  num? roleId;

  Pivot copyWith({
    String? modelType,
    num? modelId,
    num? roleId,
  }) =>
      Pivot(
        modelType: modelType ?? this.modelType,
        modelId: modelId ?? this.modelId,
        roleId: roleId ?? this.roleId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model_type'] = modelType;
    map['model_id'] = modelId;
    map['role_id'] = roleId;
    return map;
  }
}
