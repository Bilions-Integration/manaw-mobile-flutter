import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioWrapper {
  DioWrapper();

  static init() {
    final box = GetStorage();
    final token = box.read('@bearerToken');
    print('BEARER TOKEN => $token');
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
  // get method
  static Future<dynamic> get(String url, {Map<String, dynamic>? data}) async {
    try {
      Dio dio = DioWrapper.init();
      var response = await dio.get(url, queryParameters: data);
      return response.data;
    } catch (e) {
      print("API =>  GET => ERROR ${e.toString()}");
      rethrow;
    }
  }

  // post method
  static Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    try {
      Dio dio = DioWrapper.init();
      var response = await dio.post(url, data: data);
      return response.data;
    } catch (e) {
      print("API =>  POST => ERROR $e");
      rethrow;
    }
  }

  // put method
  static Future<dynamic> put(String url, {Map<String, dynamic>? data}) async {
    try {
      Dio dio = DioWrapper.init();
      var response = await dio.post(url, data: data);
      return response;
    } catch (e) {
      print("API =>  PUT => ERROR $e");
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
      print("API =>  DELETE => ERROR $e");
      rethrow;
    }
  }
}
