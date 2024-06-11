import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/home/views/job_card.dart';
import '../../../company/home/controllers/vacancy_controller.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

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
              return JobCard(vacancy: vacancy);
            },
          ),
        ),
      ),
    );
  }
}
