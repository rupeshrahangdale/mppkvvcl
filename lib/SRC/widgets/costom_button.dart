import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import '../constent/app_constant.dart';

class CostomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  // add background color
  final Color backgroundColor;

  const CostomPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor = AppColors.primaryBlue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          elevation: 2,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.subtitle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CostomPrimaryButtonBorder extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color backgroundColor;
  final Color? borderColor;

  const CostomPrimaryButtonBorder({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor.withOpacity(0), // Transparent
          side: BorderSide(
            color: borderColor ?? AppColors.primaryBlue,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          elevation: 0, // Remove shadow
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: borderColor ?? AppColors.primaryBlue),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.subtitle.copyWith(
                      color: borderColor ?? AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ==================================================
class CustomDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final String hintText;
  final String lableText;
  final ValueChanged<String?> onChanged; // <-- updated here

  const CustomDropdownWidget({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.onChanged,
    required this.lableText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lableText, style: AppTextStyles.caption),
        SizedBox(height: 8),
        CustomDropdown<String>(
          items: items,
          initialItem: selectedItem,
          hintText: hintText,
          decoration: CustomDropdownDecoration(
            closedFillColor: Colors.white,
            expandedFillColor: Colors.white,
            closedBorder: Border.all(color: Colors.grey),
            expandedBorder: Border.all(color: Colors.grey),
            closedBorderRadius: BorderRadius.circular(12),
            expandedBorderRadius: BorderRadius.circular(12),
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          onChanged: onChanged, // safe now
        ),
      ],
    );
  }
}
