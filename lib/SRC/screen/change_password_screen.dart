import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constent/app_constant.dart';
import '../services/api_services.dart';
import '../widgets/app_bar_section.dart';
import '../widgets/input_field.dart';
import '../widgets/costom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarSection(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPaddingHorizontal * 2,
                    vertical: AppDimensions.defaultPaddingHorizontal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(AppStrings.changePassword,
                        style: AppTextStyles.heading),
                    Text(AppStrings.changePasswordDescription,
                        style: AppTextStyles.caption),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MyTextField(
                          fieldName: AppStrings.oldPassword,
                          myController: _oldPasswordController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MyTextField(
                        fieldName: AppStrings.newPassword,
                        myController: _newPasswordController,
                        obscureText: _obscureConfirm,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MyTextField(
                        fieldName: AppStrings.confirmPassword,
                        myController: _confirmPasswordController,
                        obscureText: _obscureConfirm,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CostomPrimaryButton(
                      text: "Update Password",
                        onPressed: () async {
                          final oldPwd = _oldPasswordController.text.trim();
                          final newPwd = _newPasswordController.text.trim();
                          final confirmPwd = _confirmPasswordController.text.trim();
                          // get token that saved in shared preferences
                          final prefs = await SharedPreferences.getInstance();
                          final token = prefs.getString('token') ?? '';
                          print('Token: $token ========================> '); // Debugging line to check token

                          if (newPwd != confirmPwd) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password and Confirm Password must match')
                              ,backgroundColor: Colors.redAccent,),
                            );
                            return;
                          }

                          try {
                            final response = await ApiService().changePassword(
                              oldPassword: _oldPasswordController.text.toString(),
                              newPassword: _newPasswordController.text.toString(),
                              confirmPassword: _confirmPasswordController.text.toString(),
                              token: token, // replace with actual token
                            );

                            final data = jsonDecode(response.body);

                            if (response.statusCode == 200 && data['status'] == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data['message'] ?? 'Password changed successfully'),backgroundColor: Colors.green,),
                              );

                              _oldPasswordController.clear();
                              _newPasswordController.clear();
                              _confirmPasswordController.clear();

                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data['message'] ?? data['error']),backgroundColor: Colors.redAccent,),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Something went wrong. Try again.')),
                            );
                          }
                        }

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
