class Photo {
  Photo({
    this.id,
    this.galeryId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.likesCount,
    this.tagsCount,
    this.likeByYou,
  });

  Photo.fromJson(dynamic json) {
    id = json['id'];
    galeryId = json['galery_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    tagsCount = json['tags_count'];
    likeByYou = json['like_by_you'];
  }

  num? id;
  num? galeryId;
  String? image;
  String? createdAt;
  String? updatedAt;
  num? likesCount;
  num? tagsCount;
  bool? likeByYou;

  Photo copyWith({
    num? id,
    num? galeryId,
    String? image,
    String? createdAt,
    String? updatedAt,
    num? likesCount,
    num? tagsCount,
    bool? likeByYou,
  }) =>
      Photo(
        id: id ?? this.id,
        galeryId: galeryId ?? this.galeryId,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        likesCount: likesCount ?? this.likesCount,
        tagsCount: tagsCount ?? this.tagsCount,
        likeByYou: likeByYou ?? this.likeByYou,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['galery_id'] = galeryId;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['likes_count'] = likesCount;
    map['tags_count'] = tagsCount;
    map['like_by_you'] = likeByYou;
    return map;
  }
}
