import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../constants/utils.dart';
import '../../../../data/repo/employeeRepo/login_repo.dart';
import '../../../../data/service/box_service.dart';
import '../../../../data/service/exceptions.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginRepo loginRepo = LoginRepo();

  BoxService boxService = BoxService();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      showLoadingDialog();
      final response = await loginRepo.login(
        email: email,
        password: password,
      );
      if (response.statusCode == 200) {
        boxService.token = response.data['token'];
        boxService.userType = 'employee';
        hideDialog();
        Get.offAllNamed(Routes.EMPHOME);
        showSuccessSnackBar(message: 'Login Successfully');
      } else {
        hideDialog();
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      showErrorSnackBar(message: error);
      hideDialog();
    } catch (e) {
      hideDialog();
    }
  }
}
