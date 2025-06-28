import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/screen/permission_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final firstTime = prefs.getBool('firstTime') ?? true;

    await Future.delayed(const Duration(seconds: 2)); // splash delay

    if (firstTime) {
      prefs.setBool('firstTime', false); // only once
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PermissionScreen()),
      );
    } else if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          height: AppMediaQuery.screenHeight,
          width: AppMediaQuery.screenWidth,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  AppAssets.logo,
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.appName, style: AppTextStyles.subtitle),
                      const SizedBox(width: 8),
                      Text(AppStrings.appVersion,
                          style: AppTextStyles.subtitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.appPowerdby,
                          style: AppTextStyles.body.copyWith(fontSize: 10)),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
