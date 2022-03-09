// ignore_for_file: camel_case_types

import 'package:fimber/fimber.dart';

class console {
  static log(text, {dynamic payload}) {
    final fimber = FimberLog('LOG');
    fimber.d(text, ex: payload);
  }
}
