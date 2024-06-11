import 'package:event_management_admin/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/event_card.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});
  @override
  EventController get controller => Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: controller.obx((state) => ListView.separated(
            itemCount: state?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (BuildContext context, int index) {
              return EventCard(post: state![index]);
            },
          )),
    );
  }
}
