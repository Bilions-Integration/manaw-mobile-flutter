import 'package:flutter/material.dart';

class CurrentContext {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final BuildContext context = CurrentContext.navigatorKey.currentContext!;

  CurrentContext();
}
