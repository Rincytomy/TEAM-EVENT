import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/others/custom_text_fields.dart';
import '../../../employee/home/controller/profile_controller.dart';
import '../../register/controllers/image_controller.dart';
import '../controllers/home_controller.dart';

class postView extends StatefulWidget {
  const postView({super.key});

  @override
  State<postView> createState() => _postViewState();
}

class _postViewState extends State<postView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _linkController = TextEditingController();

  final HomeController homeController = Get.put(HomeController());
  final ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Posts'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Title',
                  hintText: 'Enter your Title',
                  controller: _titleController,
                  prefixIcon: FeatherIcons.user,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your first name'
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Description',
                  hintText: ' Description ',
                  controller: _descriptionController,
                  prefixIcon: FeatherIcons.user,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your last name'
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Link',
                  hintText: 'Link',
                  controller: _linkController,
                  prefixIcon: FeatherIcons.mail,
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Location',
                  hintText: 'Location',
                  controller: _locationController,
                  prefixIcon: FeatherIcons.mapPin,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Date ',
                  hintText: 'Date',
                  controller: _dateController,
                  prefixIcon: FeatherIcons.calendar,
                  isReadOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(date);
                    }
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your date of birth'
                      : null,
                ),
                const SizedBox(height: 10),
                Obx(() => Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (var images in imageController.postImages)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(images),
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        GestureDetector(
                          onTap: () => imageController.pickPostImages(),
                          child: Container(
                            width: 120,
                            height: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade700,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(FeatherIcons.image),
                                const SizedBox(height: 10),
                                Text(
                                  'Add Images',
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 35),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final ProfileController profileController = Get.find();
                        final data = <String, dynamic>{
                          "company_id": profileController.state?.company!.id,
                          'user_id': profileController.state?.id,
                          "title": _titleController.text,
                          "link": _linkController.text,
                          "description": _descriptionController.text,
                          "date": _dateController.text,
                          "location": _locationController.text,
                        };
                        await homeController.createPost(data);
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 450,
                        child: const Text('Save')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
