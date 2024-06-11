import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/common_home_controller.dart';
import '../../home/views/event_card.dart';

class PostView extends GetView<CommonHomeController> {
  const PostView({Key? key}) : super(key: key);

  @override
  CommonHomeController get controller => Get.put(CommonHomeController());
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => ListView.separated(
          itemCount: state!.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemBuilder: (BuildContext context, int index) {
            final post = state[index];
            return EventCard(post: post);
          },
        ));
  }
}
