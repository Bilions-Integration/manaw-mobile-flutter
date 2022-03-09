import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/helpers/helper.dart';

class DioWrapper {
  DioWrapper();

  static init() {
    final box = GetStorage();
    final token = box.read('@bearerToken');
    BaseOptions options = BaseOptions(
        baseUrl: 'https://api.manawstore.com/api',
        headers: {
          "authorization": "Bearer $token",
          "Accept": "application/json"
        });
    return Dio(options);
  }
}

class Api {
  static _convertFormData(data) {
    return FormData.fromMap(data);
  }

  // get method
  static Future<dynamic> get(String url, {Map<String, dynamic>? data}) async {
    try {
      Dio dio = DioWrapper.init();
      var response = await dio.get(url, queryParameters: data);
      return response.data;
    } catch (e) {
      console.log("API =>  GET => ERROR ${e.toString()}");
      rethrow;
    }
  }

  // post method
  static Future<dynamic> post(String url,
      {Map<String, dynamic>? data, bool formData = false}) async {
    try {
      Dio dio = DioWrapper.init();
      if (formData) {
        data = _convertFormData(data);
      }
      var response = await dio.post(url, data: data);
      return response.data;
    } catch (e) {
      console.log("API =>  POST => ERROR $e");
      rethrow;
    }
  }

  // put method
  static Future<dynamic> put(String url,
      {Map<String, dynamic>? data, bool formData = false}) async {
    try {
      Dio dio = DioWrapper.init();
      if (formData) {
        data = _convertFormData(data);
      }
      var response = await dio.post(url, data: data);
      return response;
    } catch (e) {
      console.log("API =>  PUT => ERROR $e");
      rethrow;
    }
  }

  // delete method
  static Future<dynamic> delete(String url,
      {Map<String, dynamic>? data}) async {
    try {
      Dio dio = DioWrapper.init();
      var response = await dio.delete(url, queryParameters: data);
      return response.data;
    } catch (e) {
      console.log("API =>  DELETE => ERROR $e");
      rethrow;
    }
  }
}
