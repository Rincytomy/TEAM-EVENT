import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../home/controllers/common_home_controller.dart';

class JoinWithUsView extends GetView<CommonHomeController> {
  const JoinWithUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Join with us', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.colorScheme.onSecondary,
                  ),
                  child: const Text('Join as  Event Manager'),
                  onPressed: () => Get.toNamed(Routes.COMLOGIN),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(color: theme.primaryColor),
                  ),
                  child: const Text('Join as  Employee'),
                  onPressed: () => Get.toNamed(Routes.EMPLOGIN),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
