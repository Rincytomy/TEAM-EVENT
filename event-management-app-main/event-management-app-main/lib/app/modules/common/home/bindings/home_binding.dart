import 'package:get/get.dart';

import '../controllers/common_home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommonHomeController>(
      () => CommonHomeController(),
    );
  }
}
