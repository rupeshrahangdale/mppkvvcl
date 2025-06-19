import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constent/app_constant.dart';

Widget AppBarSection() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal:AppDimensions.defaultPadding),
    decoration: BoxDecoration(
      color: AppColors.secondaryBlue,
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
      children: [
        Image.asset(
          AppAssets.logo,
          height: 60,
          width: 60,
        ),
        const SizedBox(width: 12),
        Text(
          AppStrings.appName,
          style: AppTextStyles.heading,
          ),

      ],
    ),
  );
}
