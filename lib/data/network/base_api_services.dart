import 'dart:io';

abstract class BaseApiServices {
  //static BaseApiServices getInst() => Get.put(NetworkApiServices());

  Future getPostApiResponse({
    required String url,
    String? token,
    dynamic body,
  });

  Future getGetApiResponse({
    required String url,
    String? token,
    dynamic body,
  });

  Future<dynamic> getPostMultipartApiResponse({
    required String url,
    String? token,
    dynamic body,
    required File file,
    String? fileName,
    required String fileFieldName,
  });
}
