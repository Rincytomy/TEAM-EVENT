import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_url.dart';
import '../../../../model/events.dart';
import '../../../../utils/utils.dart';

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({super.key});

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  final Post post = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: post.galleries!.length,
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      // width: 530,22222222
                      // height: 250,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                          image: NetworkImage(
                            AppUrl.imageUrl + post.galleries![itemIndex].image.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 230,
                  aspectRatio: 9.0,
                  viewportFraction: 0.8,
                  initialPage: 0,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    post.title ?? '',
                    style: const TextStyle(color: Colors.pinkAccent, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text('Posted on ${formatDate(post.date.toString())}'),
                ],
              ),
              ListTile(
                title: Text(
                  post.companies?.name ?? '',
                  style: TextStyle(color: Colors.pinkAccent.shade700, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(post.companies?.address ?? ''),
                      ],
                    ),
                    Row(
                      children: [
                        Text(post.companies?.phone.toString() ?? ''),
                      ],
                    ),
                  ],
                ),
                trailing: CircleAvatar(
                  child: Image.network(
                    AppUrl.imageUrl + post.companies!.logo.toString(),
                    width: 95,
                    height: 75,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  SizedBox(width: 15),
                  Text('Description'),
                ],
              ),
              SizedBox(
                width: 365,
                child: Text(
                  post.description ?? '',
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      post.location ?? '',
                      style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              Row(
                children: [
                  const SizedBox(width: 15),
                  const Text(
                    'Website Link :',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        post.link ?? '',
                        style: const TextStyle(fontSize: 14),
                      )),
                  SizedBox(
                    width: 8,
                    child: IconButton(icon: const Icon(Icons.interests_rounded), onPressed: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
