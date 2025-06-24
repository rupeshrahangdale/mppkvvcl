import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/screen/my_added_complaint_screen.dart';
import 'package:mppkvvcl/SRC/screen/new_complaint_screen.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:mppkvvcl/SRC/widgets/input_field.dart';
import '../constent/app_constant.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: AppMediaQuery.screenHeight,
            width: AppMediaQuery.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    // const SizedBox(height: 24),
                    Column(
                      children: [
                        // Logo
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            AppAssets.logo,
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // App Name
                        Text(
                          AppStrings.appName,
                          style: AppTextStyles.heading.copyWith(
                            fontSize: 24,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const Text(AppStrings.appLoginDescription,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body),

                        SizedBox(height: 8),

                        Text(AppStrings.login,
                            style:
                                AppTextStyles.subtitle.copyWith(fontSize: 18)),
                      ],
                    ),

                    const SizedBox(height: 24),
                    // Email Field

                    // CostomInputField(
                    //     label: AppStrings.username,
                    //     hintText: AppStrings.enterUsername,
                    //     controller: _userNameController),
                    MyTextField(
                      fieldName: AppStrings.username,
                      myController: _userNameController,
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    // CostomInputField(
                    //   label: AppStrings.password,
                    //   hintText: AppStrings.enterPassword,
                    //   controller: _passwordController,
                    //   obscureText: _obscurePassword,
                    // ),

                    MyTextField(
                      fieldName: AppStrings.password,
                      myController: _passwordController,
                      obscureText: _obscurePassword,
                    ),

                    const SizedBox(height: 32),
                    CostomPrimaryButton(
                        text: AppStrings.login,
                        onPressed: () {
                          print(
                              "====================================================");
                          print('Username: \\${_userNameController.text}');
                          print('Password: \\${_passwordController.text}');
                          // navigate to home screen or perform login action
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        }),
                  ],
                ),

                // add app version and powered by text

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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
