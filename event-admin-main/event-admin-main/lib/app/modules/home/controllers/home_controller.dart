import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_management_admin/app/data/model/events.dart';
import 'package:event_management_admin/app/data/repo/home_repo.dart';
import 'package:event_management_admin/app/data/service/exceptions.dart';
import 'package:event_management_admin/app/utils/utils.dart';
import 'package:get/get.dart';

import '../../../data/model/user.dart';

class HomeController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int value) => _currentIndex.value = value;
}

class UnverifiedUserController extends GetxController with StateMixin<List<User>> {
  final HomeRepo _homeRepo = HomeRepo();

  Future<void> getUnverifiedUsers() async {
    try {
      final response = await _homeRepo.getUnverifiedUsers();
      if (response.statusCode == 200) {
        final List<User> users = response.data.map<User>((e) => User.fromJson(e)).toList();
        change(users, status: RxStatus.success());
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      change(null, status: RxStatus.error(error));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() {
    getUnverifiedUsers();
    super.onInit();
  }
  Future<void> updateUser(int id, bool isVerified, {bool isInside = false}) async {
    try {
      showLoadingDialog();
      var data = {"is_verified": isVerified};
      final response = await _homeRepo.updateUser(data, id);
      if (response.statusCode == 200) {
        getUnverifiedUsers();
        hideDialog();
        if (isVerified) Get.back();
      }
    } on DioError catch (e) {
      hideDialog();
      final error = ApiExceptions.fromDioError(e).toString();
      showErrorSnackBar(message: error);
    } catch (e) {
      hideDialog();
      showErrorSnackBar(message: e.toString());
    }
  }

  Future<void> deleteUser(int id, {bool isVerified = false}) async {
    try {
      showSuccessSnackBar();
      final response = await _homeRepo.delete(id);
      if (response.statusCode == 200) {
        getUnverifiedUsers();
        hideDialog();
        if (isVerified) Get.back();
      }
    } on DioError catch (e) {
      hideDialog();
      final error = ApiExceptions.fromDioError(e).toString();
      showErrorSnackBar(message: error);
    } catch (e) {
      hideDialog();
      showErrorSnackBar(message: e.toString());
    }
  }
}

class AllUserController extends GetxController with StateMixin<List<User>> {
  final HomeRepo _homeRepo = HomeRepo();

  Future<void> getUsers() async {
    try {
      final response = await _homeRepo.getUsers();
      if (response.statusCode == 200) {
        final List<User> users = response.data.map<User>((e) => User.fromJson(e)).toList();
        change(users, status: RxStatus.success());
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      change(null, status: RxStatus.error(error));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }
}

class EventController extends GetxController with StateMixin<List<Post>> {
  final HomeRepo _homeRepo = HomeRepo();

  Future<void> getEvents() async {
    try {
      final response = await _homeRepo.getEvents();
      if (response.statusCode == 200) {
        final List<Post> events = postFromJson(jsonEncode(response.data));
        change(events, status: RxStatus.success());
      }
    } on DioError catch (e) {
      final error = ApiExceptions.fromDioError(e).toString();
      change(null, status: RxStatus.error(error));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() {
    getEvents();
    super.onInit();
  }

  
}
