import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../others/views/join_with_us_view.dart';
import '../../post/views/post_view.dart';
import '../controllers/common_home_controller.dart';

class HomeView extends GetView<CommonHomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String hello = 'Good Morning';
    if (now.hour >= 12 && now.hour < 18) {
      hello = 'Good Afternoon';
    } else if (now.hour >= 18 && now.hour < 22) {
      hello = 'Good Evening';
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              centerTitle: false,
              pinned: false,
              title: Text('Hello,$hello !'),
              titleSpacing: 0,
              actions: [
                TextButton(
                  onPressed: () => Get.to(() => const JoinWithUsView()),
                  child: const Text('Join with us'),
                ),
                const SizedBox(width: 6),
              ],
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            const SliverToBoxAdapter(child: PostView())
          ],
        ),
      ),
    );
  }
}
