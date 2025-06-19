import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/screen/login_screen.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';

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
                    Icons.location_on_rounded,
                    Colors.blue,
                    "Location Access",
                    "Used to show nearby services, maps, and personalize content based on your area.",
                  ),
                  buildPermissionCard(
                    Icons.folder_rounded,
                    Colors.deepPurple,
                    "Files Access",
                    "Needed to upload/download documents or media files from your storage.",
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
                    onPressed: () {
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
