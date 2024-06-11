import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/app_pages.dart';
import '../../../common/others/custom_text_fields.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          controller.obx(
            (state) => Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    maxRadius: 45,
                    child: Text(
                      'S',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(state?.firstName ?? ''),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(state?.email ?? ''),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextButton(
            onPressed: () => Get.to(() => const EditProfile()),
            child: const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.edit, size: 19),
              ),
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_outlined, size: 20),
            ),
          ),
          const SizedBox(
            height: 245,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                // backgroundColor: theme.primaryColor,
                // foregroundColor: theme.colorScheme.onSecondary,
              ),
              child: const Text('Logout'),
              onPressed: () {
                GetStorage().erase();
                Get.toNamed(Routes.HOME);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ProfileController controller = Get.find();
  @override
  void initState() {
    firstNameController.text = controller.state?.firstName ?? "";
    lastNameController.text = controller.state?.lastName ?? "";
    emailController.text = controller.state?.email ?? "";
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
                controller: firstNameController,
                label: 'First Name',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                keyboardType: TextInputType.name,
                controller: lastNameController,
                label: 'Last Name',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                label: 'email ',
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
                          "first_name": firstNameController.text,
                          "last_name": lastNameController.text,
                          "email": emailController.text,
                        };
                        await controller.editProfile(id: 1, data: data);
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
