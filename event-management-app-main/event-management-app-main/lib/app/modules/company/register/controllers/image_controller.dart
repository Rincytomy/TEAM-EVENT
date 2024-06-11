import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  File? logo;
  File? cover;

  final RxList<String> _postImages = <String>[].obs;
  List<String> get postImages => _postImages;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage({bool isLogo = true}) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isLogo) {
        logo = File(pickedFile.path);
      } else {
        cover = File(pickedFile.path);
      }
      update();
    }
  }

  Future<void> pickPostImages() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _postImages.add(pickedFile.path);
    }
  }
}
