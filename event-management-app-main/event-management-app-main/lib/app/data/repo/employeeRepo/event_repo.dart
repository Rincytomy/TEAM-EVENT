import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../../service/api_service.dart';
import '../../service/logging.interceptor.dart';

class EventsRepo {
  final Dio _dio = Dio(ApiInterfaces.options)
    ..interceptors.add(LoggingInterceptor());
  Future<Response> events() async {
    try {
      final response = await _dio.get(AppUrl.getPost);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
