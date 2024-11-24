class ScoreCardDetailsResponse {
  int? status;
  UserDetails? userDetails;
  int? totalQuestions;
  int? attemptedQuestions;
  int? unattemptedQuestions;
  int? correctAnswers;
  int? incorrectAnswers;
  int? totalPositiveMarks;
  int? totalNegativeMarks;
  int? totalMarks;
  int? accuracy;
  Ranking? ranking;
  SectionWiseMarks? sectionWiseMarks;

  ScoreCardDetailsResponse(
      {this.status,
        this.userDetails,
        this.totalQuestions,
        this.attemptedQuestions,
        this.unattemptedQuestions,
        this.correctAnswers,
        this.incorrectAnswers,
        this.totalPositiveMarks,
        this.totalNegativeMarks,
        this.totalMarks,
        this.accuracy,
        this.ranking,
        this.sectionWiseMarks});

  ScoreCardDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    totalQuestions = json['totalQuestions'];
    attemptedQuestions = json['attemptedQuestions'];
    unattemptedQuestions = json['unattemptedQuestions'];
    correctAnswers = json['correctAnswers'];
    incorrectAnswers = json['incorrectAnswers'];
    totalPositiveMarks = json['totalPositiveMarks'];
    totalNegativeMarks = json['totalNegativeMarks'];
    totalMarks = json['totalMarks'];
    accuracy = json['accuracy'];
    ranking =
    json['ranking'] != null ? new Ranking.fromJson(json['ranking']) : null;
    sectionWiseMarks = json['sectionWiseMarks'] != null
        ? new SectionWiseMarks.fromJson(json['sectionWiseMarks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    data['totalQuestions'] = this.totalQuestions;
    data['attemptedQuestions'] = this.attemptedQuestions;
    data['unattemptedQuestions'] = this.unattemptedQuestions;
    data['correctAnswers'] = this.correctAnswers;
    data['incorrectAnswers'] = this.incorrectAnswers;
    data['totalPositiveMarks'] = this.totalPositiveMarks;
    data['totalNegativeMarks'] = this.totalNegativeMarks;
    data['totalMarks'] = this.totalMarks;
    data['accuracy'] = this.accuracy;
    if (this.ranking != null) {
      data['ranking'] = this.ranking!.toJson();
    }
    if (this.sectionWiseMarks != null) {
      data['sectionWiseMarks'] = this.sectionWiseMarks!.toJson();
    }
    return data;
  }
}

class UserDetails {
  int? candidateId;
  int? userId;
  int? examId;
  int? shiftId;
  String? shiftName;
  String? state;
  String? examMode;
  String? setNo;
  int? rollNo;
  int? registrationNo;
  String? candidateName;
  String? gender;
  String? casteCategory;

  UserDetails(
      {this.candidateId,
        this.userId,
        this.examId,
        this.shiftId,
        this.shiftName,
        this.state,
        this.examMode,
        this.setNo,
        this.rollNo,
        this.registrationNo,
        this.candidateName,
        this.gender,
        this.casteCategory});

  UserDetails.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'];
    userId = json['user_id'];
    examId = json['exam_id'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    state = json['state'];
    examMode = json['exam_mode'];
    setNo = json['set_no'];
    rollNo = json['roll_no'];
    registrationNo = json['registration_no'];
    candidateName = json['candidate_name'];
    gender = json['gender'];
    casteCategory = json['caste_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['user_id'] = this.userId;
    data['exam_id'] = this.examId;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['state'] = this.state;
    data['exam_mode'] = this.examMode;
    data['set_no'] = this.setNo;
    data['roll_no'] = this.rollNo;
    data['registration_no'] = this.registrationNo;
    data['candidate_name'] = this.candidateName;
    data['gender'] = this.gender;
    data['caste_category'] = this.casteCategory;
    return data;
  }
}

class Ranking {
  All? all;
  All? candidateGender;

  Ranking({this.all, this.candidateGender});

  Ranking.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    candidateGender = json['candidateGender'] != null
        ? new All.fromJson(json['candidateGender'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    if (this.candidateGender != null) {
      data['candidateGender'] = this.candidateGender!.toJson();
    }
    return data;
  }
}

class All {
  int? totalusers;
  int? rank;
  int? rankAfterNormalisation;
  int? categoryTotalusers;
  int? categoryRank;
  int? percentile;
  int? categoryRankAfterNormalisation;

  All(
      {this.totalusers,
        this.rank,
        this.rankAfterNormalisation,
        this.categoryTotalusers,
        this.categoryRank,
        this.percentile,
        this.categoryRankAfterNormalisation});

  All.fromJson(Map<String, dynamic> json) {
    totalusers = json['totalusers'];
    rank = json['rank'];
    rankAfterNormalisation = json['rankAfterNormalisation'];
    categoryTotalusers = json['category_totalusers'];
    categoryRank = json['category_rank'];
    percentile = json['percentile'];
    categoryRankAfterNormalisation = json['category_rankAfterNormalisation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalusers'] = this.totalusers;
    data['rank'] = this.rank;
    data['rankAfterNormalisation'] = this.rankAfterNormalisation;
    data['category_totalusers'] = this.categoryTotalusers;
    data['category_rank'] = this.categoryRank;
    data['percentile'] = this.percentile;
    data['category_rankAfterNormalisation'] =
        this.categoryRankAfterNormalisation;
    return data;
  }
}

class SectionWiseMarks {
  GK? gK;
  GK? math;
  GK? hindi;
  GK? english;

  SectionWiseMarks({this.gK, this.math, this.hindi, this.english});

  SectionWiseMarks.fromJson(Map<String, dynamic> json) {
    gK = json['GK'] != null ? new GK.fromJson(json['GK']) : null;
    math = json['Math'] != null ? new GK.fromJson(json['Math']) : null;
    hindi = json['Hindi'] != null ? new GK.fromJson(json['Hindi']) : null;
    english = json['English'] != null ? new GK.fromJson(json['English']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gK != null) {
      data['GK'] = this.gK!.toJson();
    }
    if (this.math != null) {
      data['Math'] = this.math!.toJson();
    }
    if (this.hindi != null) {
      data['Hindi'] = this.hindi!.toJson();
    }
    if (this.english != null) {
      data['English'] = this.english!.toJson();
    }
    return data;
  }
}

class GK {
  int? totalquestion;
  int? attempted;
  int? notAttempted;
  int? correct;
  int? incorrect;
  int? positiveMarks;
  int? negativeMarks;
  int? total;

  GK(
      {this.totalquestion,
        this.attempted,
        this.notAttempted,
        this.correct,
        this.incorrect,
        this.positiveMarks,
        this.negativeMarks,
        this.total});

  GK.fromJson(Map<String, dynamic> json) {
    totalquestion = json['totalquestion'];
    attempted = json['attempted'];
    notAttempted = json['notAttempted'];
    correct = json['correct'];
    incorrect = json['incorrect'];
    positiveMarks = json['positiveMarks'];
    negativeMarks = json['negativeMarks'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalquestion'] = this.totalquestion;
    data['attempted'] = this.attempted;
    data['notAttempted'] = this.notAttempted;
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['positiveMarks'] = this.positiveMarks;
    data['negativeMarks'] = this.negativeMarks;
    data['total'] = this.total;
    return data;
  }
}
