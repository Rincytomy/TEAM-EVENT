import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar({String title = 'Error', String message = 'Something went wrong'}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  ));
}

showSuccessSnackBar({String title = 'Success', String message = 'Success'}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
    
  ));
}

showLoadingDialog() {
  Get.dialog(
    const Center(child: CircularProgressIndicator()),
    barrierDismissible: false,
  );
}

hideDialog() {
  if (Get.isDialogOpen!) Get.back();
}
