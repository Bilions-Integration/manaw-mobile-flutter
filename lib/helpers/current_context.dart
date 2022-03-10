import 'package:flutter/cupertino.dart';

class CurrentContext {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  CurrentContext();

  final BuildContext context = CurrentContext.navigatorKey.currentContext!;
}
