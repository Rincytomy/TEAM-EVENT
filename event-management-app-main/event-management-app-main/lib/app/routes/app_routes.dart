part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const POST = _Paths.POST;
  static const EMPLOGIN = _Paths.EMPLOGIN;
  static const EMPREGISTER = _Paths.EMPREGISTER;
  static const EMPHOME = _Paths.EMPHOME;
  static const COMLOGIN = _Paths.COMLOGIN;
  static const COMREGISTER = _Paths.COMREGISTER;
  static const COMHOME = _Paths.COMHOME;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const POST = '/post';
  static const EMPLOGIN = '/emplogin';
  static const EMPREGISTER = '/empregister';
  static const EMPHOME = '/emphome';
  static const COMLOGIN = '/comlogin';
  static const COMREGISTER = '/comregister';
  static const COMHOME = '/comhome';
}
