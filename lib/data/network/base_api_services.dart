import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic body);
  Future<dynamic> getPostFormApiResponse({
    required String url,
    required Map<String, dynamic> fields,
     File? file,
    bool isSingleFile = true,
    List<File>? files,
  });
}
