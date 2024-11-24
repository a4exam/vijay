class SaveUserDescriptionResponse {
  SaveDescriptionData? data;
  int? statusCode;
  String? responseMessage;

  SaveUserDescriptionResponse(
      {this.data, this.statusCode, this.responseMessage});

  SaveUserDescriptionResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SaveDescriptionData.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class SaveDescriptionData {
  Null image;
  String? description;
  String? createdAt;

  SaveDescriptionData({this.image, this.description, this.createdAt});

  SaveDescriptionData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    return data;
  }
}
