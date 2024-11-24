class DescriptionUpdateResponse {
  int? statusCode;
  String? responseMessage;

  DescriptionUpdateResponse({this.statusCode, this.responseMessage});

  DescriptionUpdateResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = this.statusCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}
