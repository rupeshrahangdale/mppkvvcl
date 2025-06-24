import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constent/app_constant.dart';

Widget AppBarSection() {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.primaryBlue,
      // borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.appName,
              style: AppTextStyles.subtitle.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "MPPKVVCL",
              style: AppTextStyles.subtitle.copyWith(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            // Handle notification button press
          },
        ),
      ],
    ),
  );
}
