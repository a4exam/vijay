import 'package:get/get.dart';

class QuizReelResponse {
  QuizReelData? data; // Assuming a single object for data
  int? statusCode;
  String? responseMessage;

  QuizReelResponse({this.data, this.statusCode, this.responseMessage});

  factory QuizReelResponse.fromJson(Map<String, dynamic> json) {
    return QuizReelResponse(
      data: json['data'] != null ? QuizReelData.fromJson(json['data']) : null,
      statusCode: json['statusCode'] as int?,
      responseMessage: json['responseMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class QuizReelData {
  int elapsedSeconds = 0;
  RxBool isSelectByUser = false.obs;
  String? selectedOptionByUser;
  RxBool hasEnableOption1 = true.obs;
  RxBool hasEnableOption2 = true.obs;
  RxBool hasEnableOption3 = true.obs;
  RxBool hasEnableOption4 = true.obs;
  int? id;
  String? examBorad;
  String? examname;
  int? categId;
  int? subject;
  int? book;
  int? chapter;
  int? questiontype;
  String? series;
  String? questionno;
  String? title;
  String? question;
  String? questionHi;
  String? options1;
  String? options2;
  String? options3;
  String? options4;
  String? options5;
  String? options1Hi;
  String? options2Hi;
  String? options3Hi;
  String? options4Hi;
  String? options5Hi;
  String? correctoption;
  String? solution;
  String? solutionHi;
  String? img;
  String? video;
  String? ename;
  int? shiftId;
  String? remarks;
  String? tags;
  int? qsDifficultyLevel;
  int? status;
  String? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  int? deletedBy;
  String? deletedAt;
  String? accptedid;
  String? bookmark;
  String? shiftName;
  String? quizRalAns;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? optionE;
  int? totalQuestionAnsForPoll;

  QuizReelData({
    this.id,
    this.examBorad,
    this.examname,
    this.categId,
    this.subject,
    this.book,
    this.chapter,
    this.questiontype,
    this.series,
    this.questionno,
    this.title,
    this.question,
    this.questionHi,
    this.options1,
    this.options2,
    this.options3,
    this.options4,
    this.options5,
    this.options1Hi,
    this.options2Hi,
    this.options3Hi,
    this.options4Hi,
    this.options5Hi,
    this.correctoption,
    this.solution,
    this.solutionHi,
    this.img,
    this.video,
    this.ename,
    this.shiftId,
    this.remarks,
    this.tags,
    this.qsDifficultyLevel,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.deletedBy,
    this.deletedAt,
    this.accptedid,
    this.bookmark,
    this.shiftName,
    this.quizRalAns,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.optionE,
    this.totalQuestionAnsForPoll
  });

  factory QuizReelData.fromJson(Map<String, dynamic> json) {
    return QuizReelData(
      id: json['id'] as int?,
      examBorad: json['exam_borad'] as String?,
      examname: json['examname'] as String?,
      categId: json['categ_id'] as int?,
      subject: json['subject'] as int?,
      book: json['book'] as int?,
      chapter: json['chapter'] as int?,
      questiontype: json['questiontype'] as int?,
      series: json['series'] as String?,
      questionno: json['questionno'] as String?,
      title: json['title'] as String?,
      question: json['question'] as String?,
      questionHi: json['question_hi'] as String?,
      options1: json['options1'] as String?,
      options2: json['options2'] as String?,
      options3: json['options3'] as String?,
      options4: json['options4'] as String?,
      options5: json['options5'] as String?,
      options1Hi: json['options1_hi'] as String?,
      options2Hi: json['options2_hi'] as String?,
      options3Hi: json['options3_hi'] as String?,
      options4Hi: json['options4_hi'] as String?,
      options5Hi: json['options5_hi'] as String?,
      correctoption: json['correctoption'] as String?,
      solution: json['solution'] as String?,
      solutionHi: json['solution_hi'] as String?,
      img: json['img'] as String?,
      video: json['video'] as String?,
      ename: json['ename'] as String?,
      shiftId: json['shift_id'] as int?,
      remarks: json['remarks'] as String?,
      tags: json['tags'] as String?,
      qsDifficultyLevel: json['qs_difficulty_level'] as int?,
      status: json['status'] as int?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
      deletedBy: json['deleted_by'] as int?,
      deletedAt: json['deleted_at'] as String?,
      accptedid: json['accptedid'] as String?,
      bookmark: json['bookmark'] as String?,
      shiftName: json['shift_name'] as String?,
      quizRalAns: json['quiz_ral_ans'] as String?,
      optionA: json['optionA'] as String?,
      optionB: json['optionB'] as String?,
      optionC: json['optionC'] as String?,
      optionD: json['optionD'] as String?,
      optionE: json['optionE'] as String?,
      totalQuestionAnsForPoll: json['total_question_ans_for_poll'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['exam_borad'] = this.examBorad;
    data['examname'] = this.examname;
    data['categ_id'] = this.categId;
    data['subject'] = this.subject;
    data['book'] = this.book;
    data['chapter'] = this.chapter;
    data['questiontype'] = this.questiontype;
    data['series'] = this.series;
    data['questionno'] = this.questionno;
    data['title'] = this.title;
    data['question'] = this.question;
    data['question_hi'] = this.questionHi;
    data['options1'] = this.options1;
    data['options2'] = this.options2;
    data['options3'] = this.options3;
    data['options4'] = this.options4;
    data['options5'] = this.options5;
    data['options1_hi'] = this.options1Hi;
    data['options2_hi'] = this.options2Hi;
    data['options3_hi'] = this.options3Hi;
    data['options4_hi'] = this.options4Hi;
    data['options5_hi'] = this.options5Hi;
    data['correctoption'] = this.correctoption;
    data['solution'] = this.solution;
    data['solution_hi'] = this.solutionHi;
    data['img'] = this.img;
    data['video'] = this.video;
    data['ename'] = this.ename;
    data['shift_id'] = this.shiftId;
    data['remarks'] = this.remarks;
    data['tags'] = this.tags;
    data['qs_difficulty_level'] = this.qsDifficultyLevel;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    data['accptedid'] = this.accptedid;
    data['bookmark'] = this.bookmark;
    data['shift_name'] = this.shiftName;
    data['quiz_ral_ans'] = this.quizRalAns;
    data['optionA'] = this.optionA;
    data['optionB'] = this.optionB;
    data['optionC'] = this.optionC;
    data['optionD'] = this.optionD;
    data['optionE'] = this.optionE;
    data['total_question_ans_for_poll'] = this.totalQuestionAnsForPoll;
    return data;
  }
}

