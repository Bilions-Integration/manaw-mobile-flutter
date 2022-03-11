import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/customer_model.dart';

class CustomerService {
  static Future<List<CustomerModel>> get({dynamic keyword}) async {
    var res = await Api.get('/customers',
        data: {
          "page": 1,
          "limit": 50,
          "keyword": keyword,
        },
        showLoading: false);
    List<CustomerModel> categories = (res["data"]["customers"] as List).map((e) => CustomerModel.fromJson(e)).toList();

    final result = [CustomerModel(name: 'Deselect Customer', id: null, image: null)];
    return [...result, ...categories];
  }
}
