import 'package:my_app/helpers/api.dart';

class ProductServices {
  static clone(int? id) async {
    await Api.post('products/$id/clone', data: {
      "clone_units" : true
    });
  }
}