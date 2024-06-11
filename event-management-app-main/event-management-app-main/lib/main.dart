import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

enum UserType { eventManager, employee, guest }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
        title: "Event Management App",
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
