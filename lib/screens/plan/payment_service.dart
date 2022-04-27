import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/payment_webview.dart';

class PaymentService {
  Future<String?> getPaymentURL({
    required String plan,
    required String period,
  }) async {
    Map<String, dynamic> params = {
      'plan': plan,
      'period': period,
      'payment_channel[]': ['ALL']
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

  Future doPayment({required String plan, required String period}) async {
    String? webUrl =
        await getPaymentURL(plan: plan.toLowerCase(), period: period);
    if (webUrl != null) {
      Get.to(() => PaymentWebView(webUrl: webUrl));
    }
  }
}
