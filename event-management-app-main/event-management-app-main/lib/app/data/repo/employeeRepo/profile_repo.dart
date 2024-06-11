import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../../service/api_service.dart';

class ProfileRepo {
  final ApiInterfaces interfaces = ApiInterfaces();

  Future<Response> profile(
      {required int id, required Map<String, dynamic> data}) async {
    try {
      final response = await interfaces.put('${AppUrl.users}/$id', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editCompany(
      {required int id, required Map<String, dynamic> data}) async {
    try {
      final response =
          await interfaces.put('${AppUrl.companies}/$id', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class UserRepo {
  final ApiInterfaces interfaces = ApiInterfaces();
  Future<Response> user() async {
    try {
      final response = await interfaces.get(AppUrl.user);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
