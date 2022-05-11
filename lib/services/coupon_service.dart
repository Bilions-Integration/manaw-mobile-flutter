import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/coupon_model/coupon_data_model.dart';
import 'package:my_app/model/coupon_model/coupon_model.dart';

class CouponService {
  static Future create(Map<String, dynamic> params) async {
    var res = await Api.post('/discounts', data: params);
    return res;
  }

  static Future delete(Map<String, List> params) async {
    var res = await Api.post('/discounts/delete', data: params);
    return res;
  }

  static Future<Map<String, dynamic>> fetch(int? id) async {
    var res = await Api.get('/discounts/$id', showLoading: false);
    Map<String, dynamic> data = CouponModel.fromJson(res["data"]).toJson();
    return data;
  }

  static Future<Map> get(Map<String, dynamic> params) async {
    var res = await Api.get('/discounts', data: params, showLoading: false);
    var data = CouponDataModel.fromJson(res["data"]).toJson();
    return data;
  }

  static Future update(int? id, Map<String, dynamic> params) async {
    var res = await Api.post('/discounts/$id?_method=PUT', data: params);
    return res;
  }
}
