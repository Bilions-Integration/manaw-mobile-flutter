import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/account_model.dart';

class AccountService {
  static Future<List<Account>> get() async {
    var res = await Api.get('/accounts',
        data: {"page": 1, "limit": 100, "select": true});
    List<Account> accounts =
        (res["data"] as List).map((e) => Account.fromJson(e)).toList();
    return accounts;
  }
}
