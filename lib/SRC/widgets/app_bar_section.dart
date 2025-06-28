import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constent/app_constant.dart';
import '../screen/login_screen.dart';

Widget AppBarSection(BuildContext context) {
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
        // logout button
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            // Handle notification button press

            // const SizedBox(height: 24),
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
        ),
      ],
    ),
  );
}
