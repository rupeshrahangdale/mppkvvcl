import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/screen/login_screen.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/permissions_helper.dart';
import '../widgets/all_card.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPaddingHorizontal,
              vertical: AppDimensions.defaultPaddingHorizontal),
          height: AppMediaQuery.screenHeight,
          width: AppMediaQuery.screenWidth,
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 24),
                  const Text(AppStrings.appPermissionsRequired,
                      style: AppTextStyles.heading),
                  const SizedBox(height: 8),
                  const Text(AppStrings.appPermissionsDescription,
                      textAlign: TextAlign.center, style: AppTextStyles.body),
                  const SizedBox(height: 24),
                  buildPermissionCard(
                    Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                    Colors.green,
                    "Internet Access",
                    "To connect with server for complaint management",
                  ),
                  buildPermissionCard(
                    Icons.location_on_rounded,
                    Colors.blue,
                    "Location Access",
                    "To detect and update exact location of complaint area",
                  ),
                  buildPermissionCard(
                    Icons.camera_alt,
                    Colors.deepPurple,
                    "Camera Access",
                    "Needed to capture image of defective parts for complaint",
                  ),
                  const SizedBox(height: 28),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPaddingHorizontal,
                    vertical: AppDimensions.defaultPaddingHorizontal),
                alignment: Alignment.bottomCenter,
                child: CostomPrimaryButton(
                    text: AppStrings.getStarted,
                    onPressed: () async {
                      final permissionService = PermissionService();
                      await permissionService.checkAndRequestPermissions();
                      // After permissions are granted, navigate to login screen
                      // You can also handle the case where permissions are denied

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('firstTime', false);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
