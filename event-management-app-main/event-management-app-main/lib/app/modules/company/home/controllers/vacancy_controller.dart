import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../../constants/utils.dart';
import '../../../../data/repo/compnayRepo/vacancy_repo.dart';
import '../../../../data/service/exceptions.dart';
import '../../../../model/vacancy.dart';

class VacancyController extends GetxController with StateMixin<List<Job>> {
  final VacancyRepo vacancyRepo = VacancyRepo();

  Future<void> eventVacancy() async {
    try {
      final response = await vacancyRepo.vacancy();
      if (response.statusCode == 200) {
        final List<Job> job = jobFromJson(jsonEncode(response.data));
        change(job, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> createPost(Map<String, dynamic> data) async {
    try {
      showLoadingDialog();
      final response = await vacancyRepo.jobVacancy(data);
      if (response.statusCode == 200) {
        await eventVacancy();
        hideDialog();
        Get.back();
        showSuccessSnackBar(message: 'Data successfuly Uploaded');
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

  Future<void> deleteJob(int id) async {
    try {
      final response = await vacancyRepo.deletedata(id);
      if (response.statusCode == 200) {
        await eventVacancy();
        showSuccessSnackBar(message: 'Data Removed Successfully');
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      showErrorSnackBar(message: error);

      Get.log(e.toString());
    } catch (e) {
      Get.log(e.toString());
    }
  }

  @override
  void onInit() {
    eventVacancy();
    super.onInit();
  }
}
