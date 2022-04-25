import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/account_model/account_data_model.dart';
import 'package:my_app/model/account_model/account_model.dart';

class AccountService {
  static Future<Map<String, dynamic>> get(Map<String, dynamic> params) async {
    var res = await Api.get('/accounts', data: params, showLoading: false);
    var data = AccountDataModel.fromJson(res).toJson();
    return data;
  }

    static Future create(Map<String, dynamic> params) async {
    var res = await Api.post('/accounts', data: params);
    return res;
  }

  static Future<Map<String, dynamic>> fetch(int? id) async {
    var res = await Api.get('/accounts/$id', showLoading : false);
    Map<String, dynamic> data =  AccountModel.fromJson(res["data"]).toJson();
    return data;
  }

  static Future delete(int? id) async {
    var res = await Api.delete('/accounts/$id');
    return res;
  }

  static Future update(int? id, Map<String, dynamic> params) async {
    var res = await Api.post('/accounts/$id', data : params);
    return res;
  }
}
