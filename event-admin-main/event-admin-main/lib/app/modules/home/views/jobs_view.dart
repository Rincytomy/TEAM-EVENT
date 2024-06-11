import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/job_card.dart';
import '../controllers/vaccency_controller.dart';

class JobView extends StatelessWidget {
  const JobView({super.key});

  @override
  Widget build(BuildContext context) {
    final VacancyController vacancyController = Get.put(VacancyController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: vacancyController.obx(
          (state) => ListView.separated(
            itemCount: state!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              var vacancy = state[index];
              return JobCard(vacancy: vacancy, isCompany: true);
            },
          ),
        ),
      ),
    );
  }
}
