import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../../../../constants/utils.dart';
import '../../../../data/repo/employeeRepo/company_repo.dart';
import '../../../../data/repo/employeeRepo/login_repo.dart';
import '../../../../data/service/box_service.dart';
import '../../../../data/service/exceptions.dart';
import '../../../../routes/app_pages.dart';
import '../views/add_company_view.dart';

class RegisterController extends GetxController {
  final LoginRepo loginRepo = LoginRepo();

  final CompanyRepo companyRepo = CompanyRepo();

  final BoxService boxService = BoxService();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> register({required Map<String, dynamic> data}) async {
    try {
      showLoadingDialog();
      final response = await loginRepo.register(data);
      if (response.statusCode == 201) {
        boxService.token = response.data['token'];
        boxService.userId = response.data['id'].toString();
        hideDialog();
        showSuccessSnackBar(message: 'Registration Successful');
        Get.off(() => const AddCompanyView());
      } else {
        hideDialog();
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      showErrorSnackBar(message: error);
      hideDialog();
      Get.log(e.toString());
    } catch (e) {
      hideDialog();
      Get.log(e.toString());
    }
  }

  Future<void> addCompanyDetails({required FormData formData}) async {
    try {
      showLoadingDialog();
      final response = await companyRepo.addCompanyDetails(formData: formData);
      if (response.statusCode == 200) {
        hideDialog();
        Get.offNamed(Routes.COMLOGIN);
        showSuccessSnackBar(
            message:
                'Company Details Added Successfully\nPlease Login to Continue');
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
