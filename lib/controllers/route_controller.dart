import 'dart:async';

import 'package:get/get.dart';

class RouteController extends GetxController {
  // for mounted
  final forceRefresh = Rx<bool?>(null);
  final forceRefreshListener = Rx<StreamSubscription?>(null);
}
