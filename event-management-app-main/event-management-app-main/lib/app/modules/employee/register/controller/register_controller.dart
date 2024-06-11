import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../constants/utils.dart';
import '../../../../data/repo/employeeRepo/login_repo.dart';
import '../../../../routes/app_pages.dart';
import '../../../../data/service/exceptions.dart';

class RegisterController extends GetxController {
  final LoginRepo loginRepo = LoginRepo();

  Future<void> register({required Map<String, dynamic> data}) async {
    try {
      showLoadingDialog();
      final response = await loginRepo.register(data);
      if (response.statusCode == 201) {
        hideDialog();
        Get.offNamed(Routes.EMPLOGIN);
        showSuccessSnackBar(message: 'Registration Successful');
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
