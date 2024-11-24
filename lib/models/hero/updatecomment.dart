class UpdateCommentResponse {
  int? statusCode;
  String? responseMessage;

  UpdateCommentResponse({this.statusCode, this.responseMessage});

  UpdateCommentResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['responseMessage'] = responseMessage;
    return data;
  }
}
