import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/invoice_model/invoice_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceServices {
  static Future<Map<String, dynamic>> get(Map<String, dynamic> params) async {
    var res = await Api.get('/invoices', data: params, showLoading : false);
    console.log('testingbejay $res');
    var data = InvoiceDataModel.fromJson(res["data"]).toJson();
    return data;
  }

  static Future print(int? id) async {
    var res = await Api.get('/invoice/$id/print_request');
    String url = res["data"]["redirect_url"];
    await launch(url);
  }

  static Future create(Map params) async {
    var res = await Api.post('/invoices/sale', data : params);
  }

  // static Future create(Map params) async {
  //   await Api.post('/categories', data : params, formData: true);
  //   return 'success';
  // }

  // static Future<Map<String, dynamic>> fetch(int? id) async {
  //   var res = await Api.get('/categories/$id', showLoading : false);
  //   Map<String, dynamic> category =  CategoryModel.fromJson(res["data"]).toJson();
  //   return category;
  // }

  // static Future delete(int? id) async {
  //   await Api.delete('/categories/$id');
  //   return 'success';
  // }

  // static Future update(int? id, Map params) async {
  //   await Api.post('/categories/$id?_method=PUT', data : params, formData: true);
  //   return 'success';
  // }
}
