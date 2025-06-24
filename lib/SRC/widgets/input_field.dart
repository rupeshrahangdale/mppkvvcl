import 'package:flutter/material.dart';
import '../constent/app_constant.dart';

class CostomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool enabled;

  const CostomInputField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelStyle: const TextStyle(color: AppColors.greyText),
            hintStyle: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryBlue),
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyText),
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: enabled ? AppColors.white : AppColors.secondaryBlue,
          ),
        ),
      ],
    );
  }
}

//====================================

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    // this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
    this.maxlines = 1,
    this.obscureText = false,
  });
  final TextEditingController myController;
  String fieldName;
  // final IconData myIcon;
  int maxlines;
  Color prefixIconColor;

  var obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      obscureText: obscureText,
      maxLines: maxlines,
      decoration: InputDecoration(
        labelText: fieldName,

        // prefixIcon: Icon(myIcon, color: prefixIconColor),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlue),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        labelStyle: const TextStyle(color: AppColors.greyText),
        focusColor: AppColors.primaryBlue,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyText),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0, // adjust as needed
          horizontal: 12.0,
        ),
      ),
    );
  }
}
