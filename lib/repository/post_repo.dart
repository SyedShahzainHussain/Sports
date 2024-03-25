import 'dart:io';

import 'package:sports/data/network/base_api_services.dart';
import 'package:sports/data/network/network_api_services.dart';

class PostRepository {
  BaseApiServices baseApiServices = NetworkApiServices();

  Future<dynamic> postRepository(dynamic body, String url) async {
    try {
      dynamic response = await baseApiServices.getPostApiResponse(url, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postFormData({
    required String url,
    required Map<String, dynamic> fields,
    File? file,
    bool? isSingleFile,
    List<File>? files,
  }) async {
    try {
      dynamic response = await baseApiServices.getPostFormApiResponse(
        url: url,
        fields: fields,
        file: file,
        isSingleFile: isSingleFile!,
        files: files,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
