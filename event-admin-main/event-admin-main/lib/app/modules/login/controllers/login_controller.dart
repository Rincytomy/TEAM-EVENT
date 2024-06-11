import 'package:dio/dio.dart';
import 'package:event_management_admin/app/data/repo/login_repo.dart';
import 'package:event_management_admin/app/data/service/box_service.dart';
import 'package:event_management_admin/app/data/service/exceptions.dart';
import 'package:event_management_admin/app/routes/app_pages.dart';
import 'package:event_management_admin/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final LoginRepo _loginRepo = LoginRepo();
  final BoxService _boxService = BoxService();

  Future<void> login() async {
    try {
      showLoadingDialog();
      final response = await _loginRepo.login(emailController.text, passwordController.text);
      if (response.statusCode == 200) {
        _boxService.token = response.data['token'];
        Get.offAllNamed(Routes.home);
        hideDialog();
      }
    } on DioError catch (e) {
      hideDialog();
      final error = ApiExceptions.fromDioError(e).toString();
      showErrorSnackBar(message: error);
    } catch (e) {
      hideDialog();
      showErrorSnackBar(message: e.toString());
    }
  }
}
