import 'package:dio/dio.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;

import '../../../../data/service/box_service.dart';
import '../../company.dart';
import '../controllers/image_controller.dart';

class AddCompanyView extends StatefulWidget {
  const AddCompanyView({super.key});

  @override
  State<AddCompanyView> createState() => _AddCompanyViewState();
}

class _AddCompanyViewState extends State<AddCompanyView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your company details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Company Name',
                controller: _nameController,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your company name' : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Company Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your company email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Company Website',
                controller: _websiteController,
                keyboardType: TextInputType.url,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your company website' : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Company Address',
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your company address' : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Company Phone',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your company phone';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Company Location',
                controller: _locationController,
                keyboardType: TextInputType.streetAddress,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your company location' : null,
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(child: AddImage()),
                  SizedBox(width: 20),
                  Expanded(child: AddImage(isLogo: false)),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final ImageController imageController = Get.put(ImageController());
                    if (imageController.logo == null || imageController.cover == null) {
                      Get.snackbar('Error', 'Please add logo and cover image');
                      return;
                    }
                    final userId = BoxService().userId;
                    var data = FormData.fromMap({
                      'user_id': userId,
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'website': _websiteController.text,
                      'address': _addressController.text,
                      'phone': _phoneController.text,
                      'location': _locationController.text,
                      'logo': await MultipartFile.fromFile(imageController.logo!.path),
                      'cover_photo': await MultipartFile.fromFile(imageController.cover!.path),
                    });

                    await controller.addCompanyDetails(formData: data);
                  }
                },
                child: const Text('Add Company'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddImage extends StatelessWidget {
  const AddImage({super.key, this.isLogo = true});

  final bool isLogo;

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.put(ImageController());
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: isLogo
          ? GetBuilder<ImageController>(
              builder: (controller) => controller.logo == null
                  ? Column(
                      children: [
                        Center(
                          child: IconButton(
                            onPressed: () => imageController.pickImage(),
                            icon: const Icon(FeatherIcons.image),
                          ),
                        ),
                        const Text('Add Logo'),
                      ],
                    )
                  : Image.file(controller.logo!),
            )
          : GetBuilder<ImageController>(
              builder: (controller) => controller.cover == null
                  ? Column(
                      children: [
                        Center(
                          child: IconButton(
                            onPressed: () => imageController.pickImage(isLogo: false),
                            icon: const Icon(FeatherIcons.image),
                          ),
                        ),
                        const Text('Add Cover'),
                      ],
                    )
                  : Image.file(controller.cover!),
            ),
    );
  }
}
