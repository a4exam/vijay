class QuestionResportResponse {
  QuestionReportData? data;
  int? statusCode;
  String? responseMessage;

  QuestionResportResponse({this.data, this.statusCode, this.responseMessage});

  QuestionResportResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new QuestionReportData.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class QuestionReportData {
  int? id;
  int? userId;
  String? questionId;
  String? questionLanguage;
  String? reportQuestion;
  String? reportOptionA;
  String? reportOptionB;
  String? reportOptionC;
  String? reportOptionD;
  String? reportDescription;
  String? reportCorrectAnswer;
  String? reportExamShift;
  String? userNotes;
  String? userImageVideo;
  String? status;
  int? view;
  String? createdAt;
  Null? updatedBy;
  String? updatedAt;
  Null? deletedBy;
  String? deletedAt;

  QuestionReportData(
      {this.id,
        this.userId,
        this.questionId,
        this.questionLanguage,
        this.reportQuestion,
        this.reportOptionA,
        this.reportOptionB,
        this.reportOptionC,
        this.reportOptionD,
        this.reportDescription,
        this.reportCorrectAnswer,
        this.reportExamShift,
        this.userNotes,
        this.userImageVideo,
        this.status,
        this.view,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.deletedBy,
        this.deletedAt});

  QuestionReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    questionId = json['question_id'];
    questionLanguage = json['question_language'];
    reportQuestion = json['report_question'];
    reportOptionA = json['report_option_a'];
    reportOptionB = json['report_option_b'];
    reportOptionC = json['report_option_c'];
    reportOptionD = json['report_option_d'];
    reportDescription = json['report_description'];
    reportCorrectAnswer = json['report_correct_answer'];
    reportExamShift = json['report_exam_shift'];
    userNotes = json['user_notes'];
    userImageVideo = json['user_ image/video'];
    status = json['status'];
    view = json['view'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['question_id'] = this.questionId;
    data['question_language'] = this.questionLanguage;
    data['report_question'] = this.reportQuestion;
    data['report_option_a'] = this.reportOptionA;
    data['report_option_b'] = this.reportOptionB;
    data['report_option_c'] = this.reportOptionC;
    data['report_option_d'] = this.reportOptionD;
    data['report_description'] = this.reportDescription;
    data['report_correct_answer'] = this.reportCorrectAnswer;
    data['report_exam_shift'] = this.reportExamShift;
    data['user_notes'] = this.userNotes;
    data['user_ image/video'] = this.userImageVideo;
    data['status'] = this.status;
    data['view'] = this.view;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
