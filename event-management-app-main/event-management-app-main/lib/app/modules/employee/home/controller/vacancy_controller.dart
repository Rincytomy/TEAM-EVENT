import 'dart:convert';

import 'package:get/get.dart';

import '../../../../data/repo/employeeRepo/vacancy_repo.dart';
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

  @override
  void onInit() {
    eventVacancy();
    super.onInit();
  }
}
