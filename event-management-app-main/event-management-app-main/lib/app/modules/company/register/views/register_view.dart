import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../company.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: 'First Name',
                  hintText: 'Enter your first name',
                  controller: _firstNameController,
                  prefixIcon: FeatherIcons.user,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your first name' : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Last Name',
                  hintText: 'Enter your last name',
                  controller: _lastNameController,
                  prefixIcon: FeatherIcons.user,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your last name' : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  prefixIcon: FeatherIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (GetUtils.isEmail(value) == false) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  controller: _mobileNumberController,
                  prefixIcon: FeatherIcons.phone,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (GetUtils.isPhoneNumber(value) == false) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Date of Birth',
                  hintText: 'Enter your date of birth',
                  controller: _dobController,
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
                      _dobController.text = DateFormat('dd-MM-yyyy').format(date);
                    }
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your date of birth' : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Address',
                  hintText: 'Enter your address',
                  controller: _addressController,
                  prefixIcon: FeatherIcons.mapPin,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  prefixIcon: FeatherIcons.lock,
                  isObscureText: true,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final data = <String, dynamic>{
                  "first_name": _firstNameController.text,
                  "last_name": _lastNameController.text,
                  "email": _emailController.text,
                  "phone": _mobileNumberController.text,
                  "password": _passwordController.text,
                  "dob": _dobController.text,
                  "address": _addressController.text,
                  "type": "manager"
                };
                await controller.register(data: data);
              }
            },
            child: const Text('Register'),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.isReadOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.validator,
    required this.controller,
    this.maxLines = 1,
    this.maxLength,
    this.isObscureText = false,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final bool isReadOnly;
  final TextInputType? keyboardType;
  final String label;
  final VoidCallback? onTap;
  final IconData? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        isDense: true,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        counter: const SizedBox.shrink(),
      ),
      readOnly: isReadOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: isObscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
