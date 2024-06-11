import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_url.dart';
import '../../../../model/events.dart';
import '../../../../utils/utils.dart';
import 'event_details_view.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(AppUrl.imageUrl + post.companies!.logo.toString()),
            ),
            title: Text(post.title ?? ''),
            subtitle: Text('Posted on ${formatDate(post.date.toString())}'),
          ),
          const SizedBox(height: 10),
          TextButton(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(
                  AppUrl.imageUrl + post.galleries!.first.image.toString(),
                ),
              ),
            ),
            onPressed: () {
              Get.to(() => const EventDetailsView(), arguments: post);
            },
          ),
        ],
      ),
    );
  }
}
