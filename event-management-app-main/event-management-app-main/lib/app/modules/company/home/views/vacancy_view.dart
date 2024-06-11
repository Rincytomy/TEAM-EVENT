import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/home/views/job_card.dart';
import '../../../employee/home/controller/profile_controller.dart';
import '../../register/views/register_view.dart';
import '../controllers/vacancy_controller.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    final VacancyController vacancyController = Get.put(VacancyController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(FeatherIcons.plus),
            onPressed: () => Get.to(() => const JobPost()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: vacancyController.obx(
          (state) => ListView.separated(
            itemCount: state?.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              var vacancy = state?[index];
              return JobCard(
                vacancy: vacancy!,
                isCompany: true,
              );
            },
          ),
        ),
      ),
    );
  }
}

class JobPost extends StatefulWidget {
  const JobPost({super.key});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _vacancyController = TextEditingController();
  final _salaryController = TextEditingController();

  final VacancyController vacancyController = Get.put(VacancyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Jobs'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Title',
                        hintText: 'Title',
                        controller: _titleController,
                        prefixIcon: FeatherIcons.user,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your   Title'
                            : null,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: 'Description',
                        hintText: ' Description ',
                        controller: _descriptionController,
                        prefixIcon: FeatherIcons.user,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your Description'
                            : null,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: 'Vacancy',
                        hintText: 'Vacancy',
                        controller: _vacancyController,
                        prefixIcon: FeatherIcons.mail,
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
                        label: 'Salary ',
                        hintText: 'Salary',
                        controller: _salaryController,
                        prefixIcon: FeatherIcons.calendar,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 35),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final ProfileController profileController =
                                  Get.put(ProfileController());
                              final data = <String, dynamic>{
                                "company_id":
                                    profileController.state?.company?.id,
                                'user_id': profileController.state?.id,
                                "title": _titleController.text,
                                "vacancy": _vacancyController.text,
                                "description": _descriptionController.text,
                                "salary": _salaryController.text,
                                "location": _locationController.text,
                              };
                              await vacancyController.createPost(data);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
