import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../../service/api_service.dart';

class CompanyRepo {
  final ApiInterfaces _api = ApiInterfaces();

  Future<Response> addCompanyDetails({required FormData formData}) async {
    try {
      final response = await _api.post(AppUrl.companies, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
