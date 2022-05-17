import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/screens/plan/payment_webview.dart';

class PaymentController extends GetxController {
  var plan = ''.obs;
  var period = ''.obs;
  var channel = <String>['ALL'].obs;

  Future<String?> getPaymentURL() async {
    Map<String, dynamic> params = {
      'plan': plan.value,
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
    String? webUrl = await getPaymentURL();
    if (webUrl != null) {
      Get.to(() => PaymentWebView(webUrl: webUrl));
    }
  }
}
