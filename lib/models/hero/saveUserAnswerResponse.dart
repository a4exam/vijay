class saveUserAnswerResponse {
  int? statusCode;
  String? responseMessage;

  saveUserAnswerResponse({this.statusCode, this.responseMessage});

  saveUserAnswerResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}
