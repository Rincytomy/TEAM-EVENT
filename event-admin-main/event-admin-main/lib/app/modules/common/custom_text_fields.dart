
import 'package:flutter/material.dart';

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
