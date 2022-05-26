import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/invoice_model/invoice_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceServices {
  static Future create(Map params) async {
    await Api.post('/invoices/sale', data: params);
  }

  static Future<Map<String, dynamic>> get(Map<String, dynamic> params) async {
    var res = await Api.get('/invoices', data: params, showLoading: false);
    var data = InvoiceDataModel.fromJson(res["data"]).toJson();
    return data;
  }

  static Future print(int? id) async {
    var res = await Api.get('/invoice/$id/print_request');
    String url = res["data"]["redirect_url"];
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }
}
