import 'package:my_app/helpers/api.dart';

class ProductServices {
  static clone(int? id, bool cloneUnit) async {
    await Api.post('products/$id/clone', data: {
      "clone_units" : cloneUnit
    });
  }
}