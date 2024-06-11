import 'package:dio/dio.dart';
import 'package:event_management_admin/app/data/service/api_service.dart';

import '../../constants/app_url.dart';

class HomeRepo {
  final ApiInterfaces _apiInterfaces = ApiInterfaces();

  Future<Response> getUsers() async {
    try {
      final response = await _apiInterfaces.get(AppUrl.users);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUser(dynamic data, int id) async {
    try {
      final response = await _apiInterfaces.put('${AppUrl.users}/$id', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(int id) async {
    try {
      final response = await _apiInterfaces.delete('${AppUrl.users}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUnverifiedUsers() async {
    try {
      final response = await _apiInterfaces.get(AppUrl.unveriFiedUsers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getEvents() async {
    try {
      final response = await _apiInterfaces.get(AppUrl.getPost);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getJobs() async {
    try {
      final response = await _apiInterfaces.get(AppUrl.getAllJobs);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> events() async {
    try {
      final response = await _apiInterfaces.get(AppUrl.getPost);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> vacancy() async {
    try {
      final response = await _apiInterfaces.get(AppUrl.getAllJobs);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> jobVacancy(dynamic data) async {
    try {
      final response = await _apiInterfaces.post(AppUrl.jobs, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deletedata(int id) async {
    try {
      final response = await _apiInterfaces.delete('${AppUrl.jobs}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
