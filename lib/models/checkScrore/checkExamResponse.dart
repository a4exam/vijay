class AllExamResponse {
  int? status;
  String? responseMessage;
  List<ExamsData>? exams;

  AllExamResponse({this.status, this.responseMessage, this.exams});

  AllExamResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseMessage = json['responseMessage'];
    if (json['exams'] != null) {
      exams = <ExamsData>[];
      json['exams'].forEach((v) {
        exams!.add(new ExamsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseMessage'] = this.responseMessage;
    if (this.exams != null) {
      data['exams'] = this.exams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamsData {
  int? id;
  int? examBoardId;
  int? examCategoryId;
  int? examNameId;
  int? examShiftId;
  String? showResult;
  String? name;
  String? image;
  String? tags;
  int? totalQuestions;
  String? perQuestionMark;
  String? totalMarks;
  int? isNegativeMark;
  String? negativeMarks;
  int? isNegativeMarkIfUnattempted;
  String? unattemptedNegativeMarks;
  String? normalizationMethod;
  String? stateForPost;
  int? finalCutoff;
  int? physicalCutoff;
  int? examMode;
  int? examModeUi;
  int? answerKeyUrlUi;
  int? setNoUi;
  int? dobUi;
  int? genderUi;
  int? categoryUi;
  int? horizontalReservationUi;
  int? stateUi;
  int? districtUi;
  int? examPostUi;
  int? genderCutoff;
  String? examPostCutoff;
  int? stateCutoff;
  int? shiftCutoff;
  String? startDatetime;
  String? endDatetime;
  int? status;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  int? deletedBy;
  dynamic deletedAt; // Use dynamic to allow null

  List<AllExamSectionDetails>? allExamSectionDetails;

  ExamsData({
    this.id,
    this.examBoardId,
    this.examCategoryId,
    this.examNameId,
    this.examShiftId,
    this.showResult,
    this.name,
    this.image,
    this.tags,
    this.totalQuestions,
    this.perQuestionMark,
    this.totalMarks,
    this.isNegativeMark,
    this.negativeMarks,
    this.isNegativeMarkIfUnattempted,
    this.unattemptedNegativeMarks,
    this.normalizationMethod,
    this.stateForPost,
    this.finalCutoff,
    this.physicalCutoff,
    this.examMode,
    this.examModeUi,
    this.answerKeyUrlUi,
    this.setNoUi,
    this.dobUi,
    this.genderUi,
    this.categoryUi,
    this.horizontalReservationUi,
    this.stateUi,
    this.districtUi,
    this.examPostUi,
    this.genderCutoff,
    this.examPostCutoff,
    this.stateCutoff,
    this.shiftCutoff,
    this.startDatetime,
    this.endDatetime,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.deletedBy,
    this.deletedAt,
    this.allExamSectionDetails,
  });

  ExamsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examBoardId = json['exam_board_id'];
    examCategoryId = json['exam_category_id'];
    examNameId = json['exam_name_id'];
    examShiftId = json['exam_shift_id'];
    showResult = json['show_result'];
    name = json['name'];
    image = json['image'];
    tags = json['tags'];
    totalQuestions = json['total_questions'];
    perQuestionMark = json['per_question_mark'];
    totalMarks = json['total_marks'];
    isNegativeMark = json['is_negative_mark'];
    negativeMarks = json['negative_marks'];
    isNegativeMarkIfUnattempted = json['is_negative_mark_if_unattempted'];
    unattemptedNegativeMarks = json['unattempted_negative_marks'];
    normalizationMethod = json['normalization_method'];
    stateForPost = json['state_for_post'];
    finalCutoff = json['final_cutoff'];
    physicalCutoff = json['physical_cutoff'];
    examMode = json['exam_mode'];
    examModeUi = json['exam_mode_ui'];
    answerKeyUrlUi = json['answer_key_url_ui'];
    setNoUi = json['set_no_ui'];
    dobUi = json['dob_ui'];
    genderUi = json['gender_ui'];
    categoryUi = json['category_ui'];
    horizontalReservationUi = json['horizontal_reservation_ui'];
    stateUi = json['state_ui'];
    districtUi = json['district_ui'];
    examPostUi = json['exam_post_ui'];
    genderCutoff = json['gender_cutoff'];
    examPostCutoff = json['exam_post_cutoff'];
    stateCutoff = json['state_cutoff'];
    shiftCutoff = json['shift_cutoff'];
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
    if (json['section_details'] != null) {
      allExamSectionDetails = <AllExamSectionDetails>[];
      json['section_details'].forEach((v) {
        allExamSectionDetails!.add(AllExamSectionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exam_board_id'] = examBoardId;
    data['exam_category_id'] = examCategoryId;
    data['exam_name_id'] = examNameId;
    data['exam_shift_id'] = examShiftId;
    data['show_result'] = showResult;
    data['name'] = name;
    data['image'] = image;
    data['tags'] = tags;
    data['total_questions'] = totalQuestions;
    data['per_question_mark'] = perQuestionMark;
    data['total_marks'] = totalMarks;
    data['is_negative_mark'] = isNegativeMark;
    data['negative_marks'] = negativeMarks;
    data['is_negative_mark_if_unattempted'] = isNegativeMarkIfUnattempted;
    data['unattempted_negative_marks'] = unattemptedNegativeMarks;
    data['normalization_method'] = normalizationMethod;
    data['state_for_post'] = stateForPost;
    data['final_cutoff'] = finalCutoff;
    data['physical_cutoff'] = physicalCutoff;
    data['exam_mode'] = examMode;
    data['exam_mode_ui'] = examModeUi;
    data['answer_key_url_ui'] = answerKeyUrlUi;
    data['set_no_ui'] = setNoUi;
    data['dob_ui'] = dobUi;
    data['gender_ui'] = genderUi;
    data['category_ui'] = categoryUi;
    data['horizontal_reservation_ui'] = horizontalReservationUi;
    data['state_ui'] = stateUi;
    data['district_ui'] = districtUi;
    data['exam_post_ui'] = examPostUi;
    data['gender_cutoff'] = genderCutoff;
    data['exam_post_cutoff'] = examPostCutoff;
    data['state_cutoff'] = stateCutoff;
    data['shift_cutoff'] = shiftCutoff;
    data['start_datetime'] = startDatetime;
    data['end_datetime'] = endDatetime;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted_by'] = deletedBy;
    data['deleted_at'] = deletedAt;
    if (allExamSectionDetails != null) {
      data['section_details'] =
          allExamSectionDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class AllExamSectionDetails {
  int? id;
  int? examId;
  int? shiftSettingId;
  String? name;
  String? questionSeries;
  int? questionNo;
  int? status;
  Null? order;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  int? deletedBy;
  Null? deletedAt;

  AllExamSectionDetails(
      {this.id,
        this.examId,
        this.shiftSettingId,
        this.name,
        this.questionSeries,
        this.questionNo,
        this.status,
        this.order,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.deletedBy,
        this.deletedAt});

  AllExamSectionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    shiftSettingId = json['shift_setting_id'];
    name = json['name'];
    questionSeries = json['question_series'];
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
    data['question_series'] = this.questionSeries;
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
