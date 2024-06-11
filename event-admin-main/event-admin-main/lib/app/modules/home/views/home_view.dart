import 'package:event_management_admin/app/data/model/user.dart';
import 'package:event_management_admin/app/modules/home/views/event_view.dart';
import 'package:event_management_admin/app/modules/home/views/jobs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final body = [
      const UserList(),
      const EventView(),
      const JobView(),
    ];
    return Scaffold(
      body: Obx(() => body[controller.currentIndex]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: (index) => controller.currentIndex = index,
            items: const [
              BottomNavigationBarItem(
                label: 'Users',
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                activeIcon: Icon(Icons.calendar_today),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work_outline),
                activeIcon: Icon(Icons.work),
                label: 'Jobs',
              ),
            ],
          )),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const Tab(text: 'All Users'),
      const Tab(text: 'Unverified Users'),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
            bottom: TabBar(
              tabs: tabs,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: TabBarView(
              children: [
                AllUsers(),
                UnverifiedUsers(),
              ],
            ),
          )),
    );
  }
}

class AllUsers extends GetView<AllUserController> {
  const AllUsers({super.key});

  @override
  AllUserController get controller => Get.put(AllUserController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.getUsers(),
      child: controller.obx((state) => ListView.separated(
            itemCount: state?.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return UserCard(user: state![index], isVerified: true);
            },
          )),
    );
  }
}

class UnverifiedUsers extends GetView<UnverifiedUserController> {
  const UnverifiedUsers({super.key});

  @override
  UnverifiedUserController get controller => Get.put(UnverifiedUserController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.getUnverifiedUsers(),
      child: controller.obx((state) => ListView.separated(
            itemCount: state?.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return UserCard(user: state![index]);
            },
          )),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user, this.isVerified = false});

  final User user;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email ?? ''),
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        // trailing: Visibility(
        //   visible: !isVerified,
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       TextButton(
        //         style: TextButton.styleFrom(
        //           foregroundColor: Colors.red,
        //         ),
        //         onPressed: () {},
        //         child: const Text('Remove'),
        //       ),
        //       const SizedBox(width: 10),
        //       TextButton(
        //         style: TextButton.styleFrom(
        //           foregroundColor: Colors.green,
        //         ),
        //         onPressed: () {},
        //         child: const Text('Verify'),
        //       ),
        //     ],
        //   ),
        // ),
        onTap: () => Get.to(() => UserDetails(user: user, isVerified: isVerified)),
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.user,
    this.isVerified = false,
  });

  final User user;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 17)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsTile(
              heading: 'First Name',
              title: user.firstName ?? '',
            ),
            DetailsTile(
              heading: 'Last Name',
              title: user.lastName ?? '',
            ),
            DetailsTile(
              heading: 'Email',
              title: user.email ?? '',
            ),
            DetailsTile(
              heading: 'Phone',
              title: user.phone ?? '',
            ),
            DetailsTile(
              heading: 'Address',
              title: user.address ?? '',
            ),
            Visibility(
              visible: user.type == 'manager' || user.company != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Company Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DetailsTile(
                    heading: 'Company Name',
                    title: user.company?.name ?? '',
                  ),
                  DetailsTile(
                    heading: 'Email',
                    title: user.company?.email ?? '',
                  ),
                  DetailsTile(
                    heading: 'Phone',
                    title: user.company?.phone ?? '',
                  ),
                  DetailsTile(
                    heading: 'Address',
                    title: user.company?.address ?? '',
                  ),
                  DetailsTile(
                    heading: 'Website',
                    title: user.company?.website ?? '',
                  ),
                  DetailsTile(
                    heading: 'Location',
                    title: user.company?.location ?? '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text('Remove'),
              ),
            ),
            Visibility(
              visible: !isVerified,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Get.put(UnverifiedUserController()).updateUser(user.id!, true);
                    },
                    child: const Text('Verify'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsTile extends StatelessWidget {
  const DetailsTile({super.key, required this.heading, required this.title});

  final String heading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              heading,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
