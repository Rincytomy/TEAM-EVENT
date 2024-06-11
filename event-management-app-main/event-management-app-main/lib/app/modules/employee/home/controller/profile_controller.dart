import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../constants/utils.dart';
import '../../../../data/repo/employeeRepo/profile_repo.dart';
import '../../../../data/service/exceptions.dart';
import '../../../../model/user.dart';

class ProfileController extends GetxController with StateMixin<User> {
  final ProfileRepo profileRepo = ProfileRepo();
  final UserRepo userRepo = UserRepo();

  Future<void> editProfile(
      {required int id, required Map<String, dynamic> data}) async {
    try {
      showLoadingDialog();
      final response = await profileRepo.profile(id: id, data: data);
      if (response.statusCode == 200) {
        getUser();
        hideDialog();
        Get.back();
        showSuccessSnackBar(message: 'Successfully Profile Edited');
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

  Future<void> getUser() async {
    try {
      final response = await userRepo.user();
      if (response.statusCode == 200) {
        final User user = User.fromJson(response.data);
        change(user, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> editCompany(
      {required int id, required Map<String, dynamic> data}) async {
    try {
      showLoadingDialog();
      final response = await profileRepo.editCompany(id: id, data: data);
      if (response.statusCode == 200) {
        getUser();
        hideDialog();
        Get.back();
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
