import 'package:get/get.dart';

import '../../../../data/repo/employeeRepo/event_repo.dart';
import 'profile_controller.dart';

class HomeController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int value) => _currentIndex.value = value;

  @override
  void onInit() {
    Get.put(ProfileController()).getUser();
    super.onInit();
  }
}
