import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart' show HomeController;
import 'event_view.dart';
import 'explore_view.dart';
import 'profile_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var body = [
      const ExploreView(),
      const EventView(),
      const ProfileView(),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
                selectedIcon: Icon(Icons.home_outlined),
              ),
              NavigationDestination(
                icon: Icon(Icons.event),
                label: 'Events',
                selectedIcon: Icon(Icons.event_outlined),
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
                selectedIcon: Icon(Icons.person_outline),
              ),
            ],
            onDestinationSelected: (index) => controller.currentIndex = index,
            selectedIndex: controller.currentIndex,
          )),
      body: Obx(() => body[controller.currentIndex]),
    );
  }
}
