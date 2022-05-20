import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/payment_method_model.dart';
import 'package:my_app/screens/plan/payment_webview.dart';

class PaymentController extends GetxController {
  var plan = ''.obs;
  var period = ''.obs;
  var total = 0.obs;
  var channel = <String>['ALL'].obs;

  Future<String?> _getPaymentURL() async {
    Map<String, dynamic> params = {
      'plan': plan.value.toLowerCase(),
      'period': period.value,
      'payment_channel[]': channel.value,
    };
    try {
      var res = await Api.get('payment_url', data: params, showLoading: true);
      if (res['success']) {
        return res['data'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future doPayment() async {
    String? webUrl = await _getPaymentURL();
    if (webUrl != null) {
      Get.to(() => PaymentWebView(webUrl: webUrl));
    }
  }

  Future<List<PaymentMethod>> getMethods() async {
    var res = await Api.get('payment_methods');
    return (res as List).map((e) => PaymentMethod.fromJson(e as Map)).toList();
  }
}
