import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/helpers/helper.dart';

class DioWrapper {
  DioWrapper();

  static init() {
    final box = GetStorage();
    final token = box.read('@bearerToken');
    BaseOptions options = BaseOptions(
        baseUrl: dotenv.env['APP_URL'].toString(),
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

  static Future<dynamic> get(
    String url, {
    Map<String, dynamic>? data,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) {
        loading();
      }
      console.log('GET => $url =>', payload: data);
      Dio dio = DioWrapper.init();
      var response = await dio.get(url, queryParameters: data);
      console.log('GET RESPONSE => $url =>', payload: response.data);
      if (showLoading) {
        hideLoading();
      }
      console.log(response.data);
      return response.data;
    } catch (e) {
      console.log("API =>  GET => ERROR ${e.toString()}");
      hideLoading();
      rethrow;
    }
  }

  // post method
  static Future<dynamic> post(
    String url, {
    // Map<String, dynamic>? data,
    dynamic data,
    bool formData = false,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) {
        loading();
      }
      console.log('POST => $url =>', payload: data);
      Dio dio = DioWrapper.init();
      if (formData) {
        data = _convertFormData(data);
      }
      // return;
      var response = await dio.post(url, data: data);
      if (showLoading) {
        hideLoading();
      }
      console.log('POST RESPONSE => $url =>', payload: response.data);
      return response.data;
    } catch (e) {
      console.log("API =>  POST => ERROR $e");
      hideLoading();
      rethrow;
    }
  }

  // put method
  static Future<dynamic> put(
    String url, {
    Map<String, dynamic>? data,
    bool formData = false,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) {
        loading();
      }
      console.log('PUT => $url =>', payload: data);
      Dio dio = DioWrapper.init();
      if (formData) {
        data = _convertFormData(data);
      }
      var response = await dio.post(url, data: data);
      if (showLoading) {
        hideLoading();
      }
      console.log('PUT RESPONSE => $url =>', payload: response.data);
      return response;
    } catch (e) {
      console.log("API =>  PUT => ERROR $e");
      hideLoading();
      rethrow;
    }
  }

  // delete method
  static Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? data,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) {
        loading();
      }
      console.log('DELETE => $url =>', payload: data);
      Dio dio = DioWrapper.init();
      var response = await dio.delete(url, queryParameters: data);
      if (showLoading) {
        hideLoading();
      }
      console.log('DELETE RESPONSE => $url =>', payload: response.data);
      return response.data;
    } catch (e) {
      console.log("API =>  DELETE => ERROR $e");
      hideLoading();
      rethrow;
    }
  }

  
}
