class ExamSiftSettingResponse {
  int? status;
  ShiftSettingDetails? shiftSettingDetails;

  ExamSiftSettingResponse({this.status, this.shiftSettingDetails});

  ExamSiftSettingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    shiftSettingDetails = json['ShiftSettingDetails'] != null
        ? new ShiftSettingDetails.fromJson(json['ShiftSettingDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.shiftSettingDetails != null) {
      data['ShiftSettingDetails'] = this.shiftSettingDetails!.toJson();
    }
    return data;
  }
}

class ShiftSettingDetails {
  int? id;
  int? examId;
  int? examBoardId;
  int? examCategoryId;
  int? examNameId;
  int? examShiftId;
  String? examSectionId;
  int? numberOfQuesInSection;
  int? noOfOptions;
  String? optionalSection;
  String? testName;
  String? testTags;
  String? testInstrutions;
  String? duration;
  int? totalQuestion;
  int? perQuestionMarks;
  int? isNegativeMark;
  int? isNegativeMarkIfUnattempted;
  int? negativeMarks;
  int? unattemptedNegativeMarks;
  int? allowSectionSwitching;
  int? normalizationMethod;
  String? showResult;
  int? noOfAttemts;
  String? questionOrder;
  String? startDatetime;
  String? endDatetime;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  int? deletedBy;
  String? deletedAt;
  List<Sectiondetails>? sectiondetails;

  ShiftSettingDetails(
      {this.id,
        this.examId,
        this.examBoardId,
        this.examCategoryId,
        this.examNameId,
        this.examShiftId,
        this.examSectionId,
        this.numberOfQuesInSection,
        this.noOfOptions,
        this.optionalSection,
        this.testName,
        this.testTags,
        this.testInstrutions,
        this.duration,
        this.totalQuestion,
        this.perQuestionMarks,
        this.isNegativeMark,
        this.isNegativeMarkIfUnattempted,
        this.negativeMarks,
        this.unattemptedNegativeMarks,
        this.allowSectionSwitching,
        this.normalizationMethod,
        this.showResult,
        this.noOfAttemts,
        this.questionOrder,
        this.startDatetime,
        this.endDatetime,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.deletedBy,
        this.deletedAt,
        this.sectiondetails});

  ShiftSettingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    examBoardId = json['exam_board_id'];
    examCategoryId = json['exam_category_id'];
    examNameId = json['exam_name_id'];
    examShiftId = json['exam_shift_id'];
    examSectionId = json['exam_section_id'];
    numberOfQuesInSection = json['number_of_ques_in_section'];
    noOfOptions = json['no_of_options'];
    optionalSection = json['optional_section'];
    testName = json['test_name'];
    testTags = json['test_tags'];
    testInstrutions = json['test_instrutions'];
    duration = json['duration'];
    totalQuestion = json['total_question'];
    perQuestionMarks = json['per_question_marks'];
    isNegativeMark = json['is_negative_mark'];
    isNegativeMarkIfUnattempted = json['is_negative_mark_if_unattempted'];
    negativeMarks = json['negative_marks'];
    unattemptedNegativeMarks = json['unattempted_negative_marks'];
    allowSectionSwitching = json['allow_section_switching'];
    normalizationMethod = json['normalization_method'];
    showResult = json['show_result'];
    noOfAttemts = json['no_of_attemts'];
    questionOrder = json['question_order'];
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
    if (json['sectiondetails'] != null) {
      sectiondetails = <Sectiondetails>[];
      json['sectiondetails'].forEach((v) {
        sectiondetails!.add(new Sectiondetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_id'] = this.examId;
    data['exam_board_id'] = this.examBoardId;
    data['exam_category_id'] = this.examCategoryId;
    data['exam_name_id'] = this.examNameId;
    data['exam_shift_id'] = this.examShiftId;
    data['exam_section_id'] = this.examSectionId;
    data['number_of_ques_in_section'] = this.numberOfQuesInSection;
    data['no_of_options'] = this.noOfOptions;
    data['optional_section'] = this.optionalSection;
    data['test_name'] = this.testName;
    data['test_tags'] = this.testTags;
    data['test_instrutions'] = this.testInstrutions;
    data['duration'] = this.duration;
    data['total_question'] = this.totalQuestion;
    data['per_question_marks'] = this.perQuestionMarks;
    data['is_negative_mark'] = this.isNegativeMark;
    data['is_negative_mark_if_unattempted'] = this.isNegativeMarkIfUnattempted;
    data['negative_marks'] = this.negativeMarks;
    data['unattempted_negative_marks'] = this.unattemptedNegativeMarks;
    data['allow_section_switching'] = this.allowSectionSwitching;
    data['normalization_method'] = this.normalizationMethod;
    data['show_result'] = this.showResult;
    data['no_of_attemts'] = this.noOfAttemts;
    data['question_order'] = this.questionOrder;
    data['start_datetime'] = this.startDatetime;
    data['end_datetime'] = this.endDatetime;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    if (this.sectiondetails != null) {
      data['sectiondetails'] =
          this.sectiondetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sectiondetails {
  int? id;
  int? examId;
  int? shiftSettingId;
  String? name;
  String? hintName;
  int? questionNo;
  int? status;
  String? order;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  int? deletedBy;
  String? deletedAt;

  Sectiondetails(
      {this.id,
        this.examId,
        this.shiftSettingId,
        this.name,
        this.hintName,
        this.questionNo,
        this.status,
        this.order,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.deletedBy,
        this.deletedAt});

  Sectiondetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    shiftSettingId = json['shift_setting_id'];
    name = json['name'];
    hintName = json['hint_name'];
    questionNo = json['question_no'];
    status = json['status'];
    order = json['order'];
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
    data['exam_id'] = this.examId;
    data['shift_setting_id'] = this.shiftSettingId;
    data['name'] = this.name;
    data['hint_name'] = this.hintName;
    data['question_no'] = this.questionNo;
    data['status'] = this.status;
    data['order'] = this.order;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
