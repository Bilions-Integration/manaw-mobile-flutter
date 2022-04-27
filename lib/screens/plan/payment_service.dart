import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';

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
    String? webUrl = await getPaymentURL(plan: plan, period: period);
  }
}
