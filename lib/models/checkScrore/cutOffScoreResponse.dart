class CutOffScoreResponse {
  int? status;
  String? responseMessage;
  CutoffScoreData? cutoffScore;

  CutOffScoreResponse({this.status, this.responseMessage, this.cutoffScore});

  CutOffScoreResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseMessage = json['responseMessage'];
    cutoffScore = json['cutoffScore'] != null
        ? CutoffScoreData.fromJson(json['cutoffScore'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['responseMessage'] = responseMessage;
    if (cutoffScore != null) {
      data['cutoffScore'] = cutoffScore!.toJson();
    }
    return data;
  }
}

class CutoffScoreData {
  String? examMode;
  int? examId;
  int? examShift;
  Gender? gender;

  CutoffScoreData({this.examMode, this.examId, this.examShift, this.gender});

  CutoffScoreData.fromJson(Map<String, dynamic> json) {
    examMode = json['exam_mode'];
    examId = _parseNullableInt(json['exam_id']);
    examShift = _parseNullableInt(json['exam_shift']);
    gender = json['gender'] != null ? Gender.fromJson(json['gender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_mode'] = examMode;
    data['exam_id'] = examId;
    data['exam_shift'] = examShift;
    if (gender != null) {
      data['gender'] = gender!.toJson();
    }
    return data;
  }

  // Helper method to safely parse integers
  int? _parseNullableInt(dynamic value) {
    if (value is int) return value;
    if (value is String && value.isNotEmpty) return int.tryParse(value);
    return null;
  }
}

class Gender {
  Female? female;
  Female? male;
  Female? all;

  Gender({this.female, this.male, this.all});

  Gender.fromJson(Map<String, dynamic> json) {
    female = json['female'] != null ? Female.fromJson(json['female']) : null;
    male = json['male'] != null ? Female.fromJson(json['male']) : null;
    all = json['all'] != null ? Female.fromJson(json['all']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (female != null) {
      data['female'] = female!.toJson();
    }
    if (male != null) {
      data['male'] = male!.toJson();
    }
    if (all != null) {
      data['all'] = all!.toJson();
    }
    return data;
  }
}

class Female {
  Ews? ews;
  Ews? general;
  Ews? obc;
  Ews? sc;
  Ews? st;

  Female({this.ews, this.general, this.obc, this.sc, this.st});

  Female.fromJson(Map<String, dynamic> json) {
    ews = json['ews'] != null ? Ews.fromJson(json['ews']) : null;
    general = json['general'] != null ? Ews.fromJson(json['general']) : null;
    obc = json['obc'] != null ? Ews.fromJson(json['obc']) : null;
    sc = json['sc'] != null ? Ews.fromJson(json['sc']) : null;
    st = json['st'] != null ? Ews.fromJson(json['st']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ews != null) {
      data['ews'] = ews!.toJson();
    }
    if (general != null) {
      data['general'] = general!.toJson();
    }
    if (obc != null) {
      data['obc'] = obc!.toJson();
    }
    if (sc != null) {
      data['sc'] = sc!.toJson();
    }
    if (st != null) {
      data['st'] = st!.toJson();
    }
    return data;
  }
}

class Ews {
  int? cutoff;
  int? totalUser;
  int? qualifyUser;

  Ews({this.cutoff, this.totalUser, this.qualifyUser});

  Ews.fromJson(Map<String, dynamic> json) {
    cutoff = _parseNullableInt(json['cutoff']);
    totalUser = _parseNullableInt(json['total_user']);
    qualifyUser = _parseNullableInt(json['qualify_user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cutoff'] = cutoff;
    data['total_user'] = totalUser;
    data['qualify_user'] = qualifyUser;
    return data;
  }

  // Helper method to safely parse integers
  int? _parseNullableInt(dynamic value) {
    if (value is int) return value;
    if (value is String && value.isNotEmpty) return int.tryParse(value);
    return null;
  }
}
