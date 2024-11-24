import 'package:get/get.dart';

class questionResponse {
  List<QuestionListData>? data;
  int? responseCode;
  String? responseMessage;

  questionResponse({this.data, this.responseCode, this.responseMessage});

  questionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <QuestionListData>[];
      json['data'].forEach((v) {
        data!.add(new QuestionListData.fromJson(v));
      });
    }
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class QuestionListData {
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
  List<ShiftName>? shiftName;
  String? remarks;
  String? tags;
  int? status;
  int? totalQuestionAnsForPoll;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? optionE;


  QuestionListData(

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
      });

  QuestionListData.fromJson(Map<String, dynamic> json, ) {
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
    if (json['shift_name'] != null) {
      shiftName = <ShiftName>[];
      json['shift_name'].forEach((v) {
        shiftName!.add(new ShiftName.fromJson(v));
      });
    }
    remarks = json['remarks'];
    tags = json['tags'];
    status = json['status'];
    totalQuestionAnsForPoll = json['total_question_ans_for_poll'];
    optionA = json['optionA'];
    optionB = json['optionB'];
    optionC = json['optionC'];
    optionD = json['optionD'];
    optionE = json['optionE'];

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
    if (this.shiftName != null) {
      data['shift_name'] = this.shiftName!.map((v) => v.toJson()).toList();
    }
    data['remarks'] = this.remarks;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['total_question_ans_for_poll'] = this.totalQuestionAnsForPoll;
    data['optionA'] = this.optionA;
    data['optionB'] = this.optionB;
    data['optionC'] = this.optionC;
    data['optionD'] = this.optionD;
    data['optionE'] = this.optionE;

    return data;
  }
}

class ShiftName {
  int? id;
  int? examCategoryId;
  String? examBoard;
  String? examName;
  String? additionalName;
  String? optradio;
  String? examDate;
  String? examShift;
  String? previewShiftName;
  int? examSectionsId;
  int? shiftSettingId;
  String? tags;
  int? order;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? deletedBy;
  String? deletedAt;

  ShiftName(
      {this.id,
        this.examCategoryId,
        this.examBoard,
        this.examName,
        this.additionalName,
        this.optradio,
        this.examDate,
        this.examShift,
        this.previewShiftName,
        this.examSectionsId,
        this.shiftSettingId,
        this.tags,
        this.order,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.deletedBy,
        this.deletedAt});

  ShiftName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examCategoryId = json['exam_category_id'];
    examBoard = json['exam_board'];
    examName = json['exam_name'];
    additionalName = json['additional_name'];
    optradio = json['optradio'];
    examDate = json['exam_date'];
    examShift = json['exam_shift'];
    previewShiftName = json['preview_shift_name'];
    examSectionsId = json['exam_sections_id'];
    shiftSettingId = json['shift_setting_id'];
    tags = json['tags'];
    order = json['order'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_category_id'] = this.examCategoryId;
    data['exam_board'] = this.examBoard;
    data['exam_name'] = this.examName;
    data['additional_name'] = this.additionalName;
    data['optradio'] = this.optradio;
    data['exam_date'] = this.examDate;
    data['exam_shift'] = this.examShift;
    data['preview_shift_name'] = this.previewShiftName;
    data['exam_sections_id'] = this.examSectionsId;
    data['shift_setting_id'] = this.shiftSettingId;
    data['tags'] = this.tags;
    data['order'] = this.order;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
