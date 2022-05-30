import 'package:get/get.dart';
import 'package:my_app/controllers/route_controller.dart';
import 'package:my_app/helpers/helper.dart';

cancelPageRefresh() {
  final controller = Get.find<RouteController>();
  controller.forceRefreshListener.value?.cancel();
}

onPageRefresh(callback) {
  final controller = Get.find<RouteController>();
  controller.forceRefreshListener.value?.cancel();
  controller.forceRefreshListener.value = controller.forceRefresh.listen((p0) {
    console.log('mounted $p0');
    if (p0 == true) {
      callback();
    }
  });
}

setForceRefresh() {
  final controller = Get.find<RouteController>();
  controller.forceRefresh.value = false;
  setTimeout(() {
    controller.forceRefresh.value = true;
  }, duration: 5);
}

class PageRefreshRouter {
  static back() {
    Get.back();
    setForceRefresh();
  }

  static push(dynamic page) {
    Get.to(page);
    setForceRefresh();
  }
}
