import 'package:get/get.dart';

import '../data/service/box_service.dart';
import '../modules/common/common.dart' as common;
import '../modules/company/company.dart' as company;
import '../modules/employee/employee.dart' as employee;

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final BoxService box = BoxService();

  static final initial = box.userType == 'employee'
      ? Routes.EMPHOME
      : box.userType == 'event_manager'
          ? Routes.COMHOME
          : Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const common.HomeView(),
      binding: common.HomeBinding(),
    ),
    GetPage(
      name: _Paths.POST,
      page: () => const common.PostView(),
      binding: common.PostBinding(),
    ),
    GetPage(
      name: _Paths.EMPLOGIN,
      page: () => const employee.LoginView(),
      binding: employee.LoginBinding(),
    ),
    GetPage(
      name: _Paths.EMPREGISTER,
      page: () => const employee.RegisterView(),
      binding: employee.RegisterBinding(),
    ),
    GetPage(
      name: _Paths.EMPHOME,
      page: () => const employee.HomeView(),
      binding: employee.HomeBinding(),
    ),
    GetPage(
      name: _Paths.COMLOGIN,
      page: () => const company.LoginView(),
      binding: company.LoginBinding(),
    ),
    GetPage(
      name: _Paths.COMREGISTER,
      page: () => const company.RegisterView(),
      binding: company.RegisterBinding(),
    ),
    GetPage(
      name: _Paths.COMHOME,
      page: () => const company.HomeView(),
      binding: company.HomeBinding(),
    ),
  ];
}
