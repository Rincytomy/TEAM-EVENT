import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../../../../constants/utils.dart';
import '../../../../data/repo/compnayRepo/event_repo.dart';
import '../../../../data/service/exceptions.dart';
import '../../../../model/events.dart';
import '../../../employee/home/controller/profile_controller.dart';
import '../../register/controllers/image_controller.dart';

class HomeController extends GetxController with StateMixin<List<Post>> {
  final CEventsRepo cEventsRepo = CEventsRepo();
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int value) => _currentIndex.value = value;

  Future<void> getEvents() async {
    try {
      final response = await cEventsRepo.events();
      if (response.statusCode == 200) {
        final List<Post> post = postFromJson(jsonEncode(response.data));
        change(post, status: RxStatus.success());
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      change(null, status: RxStatus.error(error));
      Get.log(e.toString());
    } catch (e) {
      Get.log(e.toString());
      change(null, status: RxStatus.error(e.toString()));
      rethrow;
    }
  }

  Future<void> createPost(
    Map<String, dynamic> data,
  ) async {
    try {
      showLoadingDialog();
      final response = await cEventsRepo.posts(data);
      if (response.statusCode == 200) {
        var id = response.data["id"];
        final ImageController imageController = Get.find();
        for (var image in imageController.postImages) {
          await uploadImage(id, image);
        }
        await getEvents();
        hideDialog();
        Get.back();
        showSuccessSnackBar(message: 'Image Uploaded Successfully');
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      showErrorSnackBar(message: error);
      hideDialog();
      Get.log(e.toString());
    } catch (e) {
      hideDialog();
      Get.log(e.toString());
    }
  }

  @override
  void onInit() {
    getEvents();
    Get.put(ProfileController()).getUser();
    super.onInit();
  }

  Future<void> uploadImage(int postId, String image) async {
    try {
      final FormData formData = FormData.fromMap({
        'post_id': postId,
        'image': await MultipartFile.fromFile(image),
      });
      final response = await cEventsRepo.uploadImage(formData);
      if (response.statusCode == 200) {
        Get.log(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
}
