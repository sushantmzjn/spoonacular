import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextInputType? keyboardType;
  String? initialValue;
  String labelText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  void Function(String)? onChanged;
  CustomTextFormField({
    this.keyboardType,
    required this.labelText,
    this.controller,
    required this.validator,
    this.initialValue,
    this.suffixIcon,
    this.onChanged
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}
