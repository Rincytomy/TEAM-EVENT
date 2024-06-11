import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/home/controllers/common_home_controller.dart';
import '../../../common/home/views/event_card.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final CommonHomeController controller = Get.put(CommonHomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: controller.obx(
        (state) => ListView.separated(
          itemCount: state!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            var post = state[index];
            return EventCard(post: post);
          },
        ),
      ),
    );
  }
}
