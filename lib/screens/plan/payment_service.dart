import 'package:my_app/helpers/api.dart';

class PaymentService {
  Future getPaymentURL({
    required String plan,
    required String period,
  }) async {
    await Api.get('/payment_url');
  }
}
