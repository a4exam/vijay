import 'package:get/get.dart';

class AllDescriptionResponse {
  List<AllDescriptionData>? data;
  int? statusCode;
  String? responseMessage;

  AllDescriptionResponse({this.data, this.statusCode, this.responseMessage});

  AllDescriptionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllDescriptionData>[];
      json['data'].forEach((v) {
        data!.add(AllDescriptionData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = statusCode;
    data['responseMessage'] = responseMessage;
    return data;
  }
}

class AllDescriptionData {
  int? id;
  int? userId;
  String? userName;
  String? userImage;
  String? updatedAt;
  int? questionId;
  String? image;
  String? description;
  String? time;
  int? favourite;
  String? favouriteUser;
  int? likes;
  String? likeUser;
  int? share;
  List<ShareUser>? shareUser;
  int? comment;
  List<CommentUser>? commentUser;
  bool? isFavourite;
  bool? isLike;

  AllDescriptionData({
    this.id,
    this.userId,
    this.userName,
    this.userImage,
    this.updatedAt,
    this.questionId,
    this.image,
    this.description,
    this.time,
    this.favourite,
    this.favouriteUser,
    this.likes,
    this.likeUser,
    this.share,
    this.shareUser,
    this.comment,
    this.commentUser,
    this.isFavourite = false,
    this.isLike = false,
  });

  AllDescriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
    updatedAt = json['updated_at'];
    questionId = json['question_id'];
    image = json['image'];
    description = json['description'];
    time = json['time'];
    favourite = json['favourite'];
    favouriteUser = json['favourite_user']?.toString();
    likes = json['likes'];
    likeUser = json['like_user']?.toString();
    share = json['share'];

    isFavourite = json['is_favourite'] ?? false;
    isLike = json['is_like'] ?? false;
    if (json['share_user'] != null) {
      shareUser = (json['share_user'] as List).map((v) => ShareUser.fromJson(v as Map<String, dynamic>)).toList();
    }
    comment = json['comment'];
    if (json['comment_user'] != null) {
      commentUser = (json['comment_user'] as List).map((v) => CommentUser.fromJson(v as Map<String, dynamic>)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_image'] = userImage;
    data['updated_at'] = updatedAt;
    data['question_id'] = questionId;
    data['image'] = image;
    data['description'] = description;
    data['time'] = time;
    data['favourite'] = favourite;
    data['favourite_user'] = favouriteUser;
    data['likes'] = likes;
    data['like_user'] = likeUser;
    data['is_favourite'] = isFavourite;
    data['is_like'] = isLike;
    data['share'] = share;

    if (shareUser != null) {
      data['share_user'] = shareUser!.map((v) => v.toJson()).toList();
    }
    data['comment'] = comment;
    if (commentUser != null) {
      data['comment_user'] = commentUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ShareUser {
  int? id;
  int? userId;
  int? questionId;
  int? descriptionId;
  String? type;
  int? likes;
  String? comment;
  int? share;
  String? createdAt;
  String? updatedAt;

  ShareUser({
    this.id,
    this.userId,
    this.questionId,
    this.descriptionId,
    this.type,
    this.likes,
    this.comment,
    this.share,
    this.createdAt,
    this.updatedAt,
  });

  ShareUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    questionId = json['question_id'];
    descriptionId = json['description_id'];
    type = json['type'];
    likes = json['likes'];
    comment = json['comment'];
    share = json['share'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['question_id'] = questionId;
    data['description_id'] = descriptionId;
    data['type'] = type;
    data['likes'] = likes;
    data['comment'] = comment;
    data['share'] = share;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CommentUser {
  int? id;
  int? userId;
  int? questionId;
  int? descriptionId;
  String? type;
  int? likes;
  String? comment;
  int? share;
  String? createdAt;
  String? updatedAt;
  UserData? userData;

  CommentUser({
    this.id,
    this.userId,
    this.questionId,
    this.descriptionId,
    this.type,
    this.likes,
    this.comment,
    this.share,
    this.createdAt,
    this.updatedAt,
    this.userData,
  });

  CommentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    questionId = json['question_id'];
    descriptionId = json['description_id'];
    type = json['type'];
    likes = json['likes'];
    comment = json['comment'];
    share = json['share'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userData = json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['question_id'] = questionId;
    data['description_id'] = descriptionId;
    data['type'] = type;
    data['likes'] = likes;
    data['comment'] = comment;
    data['share'] = share;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? images;

  UserData({this.id, this.name, this.images});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['images'] = images;
    return data;
  }
}
