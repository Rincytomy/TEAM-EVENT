import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../../service/api_service.dart';

class CEventsRepo {
  final ApiInterfaces api = ApiInterfaces();
  Future<Response> events() async {
    try {
      final response = await api.get(AppUrl.posts);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> posts(dynamic data) async {
    try {
      final response = await api.post(AppUrl.posts, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> uploadImage(dynamic data) async {
    try {
      final response = await api.post(AppUrl.galleries, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
