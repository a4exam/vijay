class DescriptionLikeResponse {
  DescriptionLikeData? data;
  int? comment;
  int? likes;
  int? share;
  int? favourite;
  int? statusCode;
  String? responseMessage;

  DescriptionLikeResponse(
      {this.data,
        this.comment,
        this.likes,
        this.share,
        this.favourite,
        this.statusCode,
        this.responseMessage});

  DescriptionLikeResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DescriptionLikeData.fromJson(json['data']) : null;
    comment = json['comment'];
    likes = json['likes'];
    share = json['share'];
    favourite = json['favourite'];
    statusCode = json['statusCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['comment'] = this.comment;
    data['likes'] = this.likes;
    data['share'] = this.share;
    data['favourite'] = this.favourite;
    data['statusCode'] = this.statusCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class DescriptionLikeData {
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

  DescriptionLikeData(
      {this.id,
        this.userId,
        this.questionId,
        this.descriptionId,
        this.type,
        this.likes,
        this.comment,
        this.share,
        this.createdAt,
        this.updatedAt,
        this.userData});

  DescriptionLikeData.fromJson(Map<String, dynamic> json) {
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
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['question_id'] = this.questionId;
    data['description_id'] = this.descriptionId;
    data['type'] = this.type;
    data['likes'] = this.likes;
    data['comment'] = this.comment;
    data['share'] = this.share;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  Null? examBoardId;
  Null? examNameId;
  Null? roleId;
  String? images;
  String? name;
  String? mobileNo;
  String? email;
  Null? emailVerifiedAt;
  Null? tempPassword;
  Null? descr;
  Null? permissions;
  String? dateOfBirth;
  String? gander;
  String? category;
  String? education;
  String? country;
  String? state;
  String? district;
  String? town;
  String? pincode;
  Null? otp;
  String? tag;
  Null? status;
  int? userStatus;
  int? blokestatus;
  int? accptedid;
  int? lastuse;
  String? avaragetime;
  Null? createdBy;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
        this.examBoardId,
        this.examNameId,
        this.roleId,
        this.images,
        this.name,
        this.mobileNo,
        this.email,
        this.emailVerifiedAt,
        this.tempPassword,
        this.descr,
        this.permissions,
        this.dateOfBirth,
        this.gander,
        this.category,
        this.education,
        this.country,
        this.state,
        this.district,
        this.town,
        this.pincode,
        this.otp,
        this.tag,
        this.status,
        this.userStatus,
        this.blokestatus,
        this.accptedid,
        this.lastuse,
        this.avaragetime,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examBoardId = json['exam_board_id'];
    examNameId = json['exam_name_id'];
    roleId = json['role_id'];
    images = json['images'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    tempPassword = json['temp_password'];
    descr = json['descr'];
    permissions = json['permissions'];
    dateOfBirth = json['dateOfBirth'];
    gander = json['gander'];
    category = json['category'];
    education = json['education'];
    country = json['country'];
    state = json['state'];
    district = json['district'];
    town = json['town'];
    pincode = json['pincode'];
    otp = json['otp'];
    tag = json['tag'];
    status = json['status'];
    userStatus = json['user_status'];
    blokestatus = json['blokestatus'];
    accptedid = json['accptedid'];
    lastuse = json['lastuse'];
    avaragetime = json['avaragetime'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_board_id'] = this.examBoardId;
    data['exam_name_id'] = this.examNameId;
    data['role_id'] = this.roleId;
    data['images'] = this.images;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['temp_password'] = this.tempPassword;
    data['descr'] = this.descr;
    data['permissions'] = this.permissions;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gander'] = this.gander;
    data['category'] = this.category;
    data['education'] = this.education;
    data['country'] = this.country;
    data['state'] = this.state;
    data['district'] = this.district;
    data['town'] = this.town;
    data['pincode'] = this.pincode;
    data['otp'] = this.otp;
    data['tag'] = this.tag;
    data['status'] = this.status;
    data['user_status'] = this.userStatus;
    data['blokestatus'] = this.blokestatus;
    data['accptedid'] = this.accptedid;
    data['lastuse'] = this.lastuse;
    data['avaragetime'] = this.avaragetime;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
