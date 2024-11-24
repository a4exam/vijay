class ScoreHistoryResponse {
  int? status;
  List<ScoreHistoryData>? history;

  ScoreHistoryResponse({this.status, this.history});

  ScoreHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['history'] != null) {
      history = <ScoreHistoryData>[];
      json['history'].forEach((v) {
        history!.add(new ScoreHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScoreHistoryData {
  int? id;
  int? userId;
  int? examId;
  int? shiftId;
  String? setNo;
  String? examMode;
  int? rollNo;
  int? registrationNo;
  String? userName;
  String? examDate;
  String? examStartTime;
  String? examEndTime;
  String? dob;
  String? gender;
  String? casteCategory;
  int? horizontalReservation;
  String? state;
  int? district;
  String? vacancyPost;
  int? marksObtain;
  String? normalizedMarks;
  int? status;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? deletedAt;
  String? deletedBy;
  String? examName;
  RankDetails? rankDetails;

  ScoreHistoryData(
      {this.id,
        this.userId,
        this.examId,
        this.shiftId,
        this.setNo,
        this.examMode,
        this.rollNo,
        this.registrationNo,
        this.userName,
        this.examDate,
        this.examStartTime,
        this.examEndTime,
        this.dob,
        this.gender,
        this.casteCategory,
        this.horizontalReservation,
        this.state,
        this.district,
        this.vacancyPost,
        this.marksObtain,
        this.normalizedMarks,
        this.status,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.deletedAt,
        this.deletedBy,
        this.examName,
        this.rankDetails});

  ScoreHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    examId = json['exam_id'];
    shiftId = json['shift_id'];
    setNo = json['set_no'];
    examMode = json['exam_mode'];
    rollNo = json['roll_no'];
    registrationNo = json['registration_no'];
    userName = json['user_name'];
    examDate = json['exam_date'];
    examStartTime = json['exam_start_time'];
    examEndTime = json['exam_end_time'];
    dob = json['dob'];
    gender = json['gender'];
    casteCategory = json['caste_category'];
    horizontalReservation = json['horizontal_reservation'];
    state = json['state'];
    district = json['district'];
    vacancyPost = json['vacancy_post'];
    marksObtain = json['marks_obtain'];
    normalizedMarks = json['normalized_marks'];
    status = json['status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    deletedBy = json['deleted_by'];
    examName = json['examName'];
    rankDetails = json['rankDetails'] != null
        ? new RankDetails.fromJson(json['rankDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['exam_id'] = this.examId;
    data['shift_id'] = this.shiftId;
    data['set_no'] = this.setNo;
    data['exam_mode'] = this.examMode;
    data['roll_no'] = this.rollNo;
    data['registration_no'] = this.registrationNo;
    data['user_name'] = this.userName;
    data['exam_date'] = this.examDate;
    data['exam_start_time'] = this.examStartTime;
    data['exam_end_time'] = this.examEndTime;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['caste_category'] = this.casteCategory;
    data['horizontal_reservation'] = this.horizontalReservation;
    data['state'] = this.state;
    data['district'] = this.district;
    data['vacancy_post'] = this.vacancyPost;
    data['marks_obtain'] = this.marksObtain;
    data['normalized_marks'] = this.normalizedMarks;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['deleted_by'] = this.deletedBy;
    data['examName'] = this.examName;
    if (this.rankDetails != null) {
      data['rankDetails'] = this.rankDetails!.toJson();
    }
    return data;
  }
}

class RankDetails {
  int? rank;
  double? percentile;
  int? totalCondidate;

  RankDetails({this.rank, this.percentile, this.totalCondidate});

  RankDetails.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    percentile = json['percentile'] is int
        ? (json['percentile'] as int).toDouble()
        : (json['percentile'] as double?);
    totalCondidate = json['totalCondidate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rank'] = this.rank;
    data['percentile'] = this.percentile;
    data['totalCondidate'] = this.totalCondidate;
    return data;
  }
}
