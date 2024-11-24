import 'package:get/get.dart';

class SeriesQuestion {
  String? seriesName;
  List<Question>? questions;

  SeriesQuestion({required this.seriesName, required this.questions});

  int? responseCode;
  String? responseMessage;



  SeriesQuestion.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      questions = <Question>[];
      json['data'].forEach((v) {
        questions!.add(new Question.fromJson(v));
      });
    }
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['data'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class Question {

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
  String? bookmark;
  String? shiftName;
  String? remarks;
  String? tags;
  int? status;
  int? totalQuestionAnsForPoll;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? optionE;
  Data? data;

  Question(
      {this.id,
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
        this.bookmark,
        this.shiftName,
        this.remarks,
        this.tags,
        this.status,
        this.totalQuestionAnsForPoll,
        this.optionA,
        this.optionB,
        this.optionC,
        this.optionD,
        this.optionE,
        this.data});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examBorad = json['exam_borad'];
    examname = json['examname'];
    categId = json['categ_id'];
    subject = json['subject'];
    book = json['book'];
    chapter = json['chapter'];
    questiontype = json['questiontype'];
    series = json['series'];
    questionno = json['questionno'];
    title = json['title'];
    question = json['question'];
    questionHi = json['question_hi'];
    options1 = json['options1'];
    options2 = json['options2'];
    options3 = json['options3'];
    options4 = json['options4'];
    options5 = json['options5'];
    options1Hi = json['options1_hi'];
    options2Hi = json['options2_hi'];
    options3Hi = json['options3_hi'];
    options4Hi = json['options4_hi'];
    options5Hi = json['options5_hi'];
    correctoption = json['correctoption'];
    solution = json['solution'];
    solutionHi = json['solution_hi'];
    img = json['img'];
    video = json['video'];
    ename = json['ename'];
    bookmark = json['bookmark'];
    shiftName = json['shift_name'];
    remarks = json['remarks'];
    tags = json['tags'];
    status = json['status'];
    totalQuestionAnsForPoll = json['total_question_ans_for_poll'];
    optionA = json['optionA'];
    optionB = json['optionB'];
    optionC = json['optionC'];
    optionD = json['optionD'];
    optionE = json['optionE'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['bookmark'] = this.bookmark;
    data['shift_name'] = this.shiftName;
    data['remarks'] = this.remarks;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['total_question_ans_for_poll'] = this.totalQuestionAnsForPoll;
    data['optionA'] = this.optionA;
    data['optionB'] = this.optionB;
    data['optionC'] = this.optionC;
    data['optionD'] = this.optionD;
    data['optionE'] = this.optionE;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? catId;
  int? questionTypeId;
  int? questionId;
  int? chapterId;
  int? userId;
  String? time;
  int? userAns;
  int? correctAns;
  int? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.catId,
        this.questionTypeId,
        this.questionId,
        this.chapterId,
        this.userId,
        this.time,
        this.userAns,
        this.correctAns,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    questionTypeId = json['question_type_id'];
    questionId = json['question_id'];
    chapterId = json['chapter_id'];
    userId = json['user_id'];
    time = json['time'];
    userAns = json['user_ans'];
    correctAns = json['correct_ans'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['question_type_id'] = this.questionTypeId;
    data['question_id'] = this.questionId;
    data['chapter_id'] = this.chapterId;
    data['user_id'] = this.userId;
    data['time'] = this.time;
    data['user_ans'] = this.userAns;
    data['correct_ans'] = this.correctAns;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
