import 'package:get_storage/get_storage.dart';

class BoxService {
  static final GetStorage _box = GetStorage();

  String get token => _box.read('token') ?? '';
  set token(String value) => _box.write('token', value);

  String get userType => _box.read('userType') ?? 'guest';
  set userType(String value) => _box.write('userType', value);

  String get userId => _box.read('userId') ?? '';
  set userId(String value) => _box.write('userId', value);
}
