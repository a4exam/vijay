class DeleteCommentResponse {
  int? statusCode;
  String? responseMessage;

  DeleteCommentResponse({this.statusCode, this.responseMessage});

  DeleteCommentResponse.fromJson(Map<String, dynamic> json) {
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
