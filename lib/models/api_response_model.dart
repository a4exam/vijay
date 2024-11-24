class ApiResponseModel<T> {
  T? data;
  int? type;
  String? msgtype;
  String? msg;

  ApiResponseModel({this.data, this.type, this.msgtype, this.msg});

  factory ApiResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponseModel(
      data: json['msgtype']=="fail" ? null:fromJsonT(json['data']),
      type: json['type'],
      msgtype: json['msgtype'],
      msg: json['msg'],
    );
  }

  factory ApiResponseModel.fromJsonWithDynamic(Map<String, dynamic> json) {
    return ApiResponseModel(
      data: json['data'],
      type: json['type'],
      msgtype: json['msgtype'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = {
      'data': toJsonT(this.data as T),
      'type': type,
      'msgtype': msgtype,
      'msg': msg,
    };
    return data;
  }
}
