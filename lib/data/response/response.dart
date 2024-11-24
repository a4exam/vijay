import 'package:mcq/data/response/status.dart';

class Response<T> {
  Status status;
  T? data;
  String? message;

  Response(this.status, this.message, this.data);

  Response.loading() : status = Status.loading;

  Response.success() : status = Status.success;

  Response.error() : status = Status.error;

  @override
  String toString() {
    return "Status: $status\nSuccess: $status\nData: $data";
  }
}
