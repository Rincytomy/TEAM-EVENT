import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/app_pages.dart';
import '../../../employee/home/controller/profile_controller.dart';
import '../../company.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: profileController.obx(
          (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  child: Text('A'),
                ),
                title: Text(state?.firstName ?? ''),
                subtitle: Text(state?.email ?? ''),
                trailing: TextButton(
                    onPressed: () => Get.to(() => const EditProfile()),
                    child: const Icon(Icons.edit)),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              Text('Company Details', style: theme.textTheme.titleSmall),
              const SizedBox(height: 10),
              ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  child: Text('A'),
                ),
                title: Text(state?.company?.name ?? ''),
                subtitle: const Text('Company Name'),
                trailing: TextButton(
                  onPressed: () => Get.to(
                    () => const companyEdit(),
                  ),
                  child: const Icon(Icons.edit),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              //logout button
              const Divider(),
              ListTile(
                title: const Text('Logout'),
                subtitle: const Text('Logout from the app'),
                leading: CircleAvatar(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  child: const Icon(Icons.logout, size: 20),
                ),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  GetStorage().erase();
                  Get.offAllNamed(Routes.HOME);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController comapnyemailController = TextEditingController();
  final ProfileController controller = Get.find();

  @override
  void initState() {
    nameController.text = controller.state?.firstName ?? '';
    emailController.text = controller.state?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            children: [
              CustomTextField(
                keyboardType: TextInputType.name,
                controller: nameController,
                label: ' Name',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                keyboardType: TextInputType.name,
                controller: emailController,
                label: 'Email',
              ),
              const SizedBox(height: 60),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Save'),
                      onPressed: () async {
                        var data = {
                          "name": nameController.text,
                          "email": emailController.text,
                        };
                        await controller.editProfile(
                          id: controller.state!.id!,
                          data: data,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Back'),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class companyEdit extends StatefulWidget {
  const companyEdit({super.key});

  @override
  State<companyEdit> createState() => _companyEditState();
}

class _companyEditState extends State<companyEdit> {
  final TextEditingController firstanmeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController comapnyemailController = TextEditingController();
  final ProfileController controller = Get.find();

  @override
  void initState() {
    firstanmeController.text = controller.state?.company?.name ?? '';
    phoneController.text = controller.state?.company?.phone ?? '';
    addressController.text = controller.state?.company?.address ?? '';
    websiteController.text = controller.state?.company?.website ?? '';
    comapnyemailController.text = controller.state?.company?.email ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comapny Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              children: [
                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: firstanmeController,
                  label: ' Name',
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: comapnyemailController,
                  label: 'Email',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: websiteController,
                  label: ' Website',
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: phoneController,
                  label: ' Phone Number',
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: addressController,
                  label: 'Address',
                ),
                const SizedBox(height: 60),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Save'),
                        onPressed: () async {
                          var data = {
                            "name": firstanmeController.text,
                            "email": comapnyemailController.text,
                            "phone": phoneController.text,
                            "website": websiteController.text,
                            "address": addressController.text,
                          };
                          await controller.editCompany(
                            id: controller.state!.company!.id!,
                            data: data,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Back'),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
