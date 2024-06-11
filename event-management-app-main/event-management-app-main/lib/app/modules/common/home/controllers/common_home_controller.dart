import 'dart:convert';

import 'package:get/get.dart';

import '../../../../data/repo/employeeRepo/event_repo.dart';
import '../../../../model/events.dart';

class CommonHomeController extends GetxController with StateMixin<List<Post>> {
  final EventsRepo eventsRepo = EventsRepo();
  Future<void> getEvents() async {
    try {
      final response = await eventsRepo.events();
      if (response.statusCode == 200) {
        final List<Post> post = postFromJson(jsonEncode(response.data));
        change(post, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  @override
  void onInit() {
    getEvents();
    super.onInit();
  }
}
