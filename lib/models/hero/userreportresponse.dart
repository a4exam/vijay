class UserReposrtResponse {
  int? statusCode;
  UserReportData? data;
  String? responseMessage;

  UserReposrtResponse({this.statusCode, this.data, this.responseMessage});

  UserReposrtResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new UserReportData.fromJson(json['data']) : null;
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class UserReportData {
  String? title;
  String? userProblem;
  String? questionId;
  String? descriptionId;
  String? commentId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserReportData(
      {this.title,
        this.userProblem,
        this.questionId,
        this.descriptionId,
        this.commentId,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  UserReportData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    userProblem = json['user_problem'];
    questionId = json['question_id'];
    descriptionId = json['description_id'];
    commentId = json['comment_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['user_problem'] = this.userProblem;
    data['question_id'] = this.questionId;
    data['description_id'] = this.descriptionId;
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
