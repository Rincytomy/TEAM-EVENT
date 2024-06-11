import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/home/views/event_card.dart';
import '../controllers/home_controller.dart';
import 'postscreens_view.dart';
import 'profile_view.dart';
import 'vacancy_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final body = [
      const Events(),
      const EventView(),
      const ProfileView(),
    ];
    return Scaffold(
      body: Obx(() => body[controller.currentIndex]),
      bottomNavigationBar: Obx(() => NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(FeatherIcons.calendar),
                label: 'Events',
              ),
              NavigationDestination(
                label: 'Jobs',
                icon: Icon(FeatherIcons.briefcase),
              ),
              NavigationDestination(
                icon: Icon(FeatherIcons.user),
                label: 'Profile',
              ),
            ],
            onDestinationSelected: (index) => controller.currentIndex = index,
            selectedIndex: controller.currentIndex,
          )),
    );
  }
}

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(FeatherIcons.plus),
            onPressed: () => Get.to(() => const postView()),
          ),
        ],
      ),
      body: homeController.obx(
        (state) => ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: state!.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            var post = state[index];
            return EventCard(post: post);
          },
        ),
      ),
    );
  }
}
