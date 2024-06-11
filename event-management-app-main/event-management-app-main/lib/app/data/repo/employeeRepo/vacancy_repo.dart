import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../../service/api_service.dart';

class VacancyRepo {
  final ApiInterfaces interfaces = ApiInterfaces();
  Future<Response> vacancy() async {
    try {
      final response = await interfaces.get(AppUrl.getAllJobs);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
