import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constent/app_constant.dart';
import '../services/api_services.dart';
import '../widgets/app_bar_section.dart';
import '../widgets/input_field.dart';
import '../widgets/costom_button.dart';
import '../widgets/widgets.dart';
import 'login_screen.dart';

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
  bool _isLoading = false; // ✅ For loading spinner in button


  // ✅ Snackbar moved outside build method
  void _showSnackbar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Future<void> _handleChangePassword() async {
    final oldPwd = _oldPasswordController.text.trim();
    final newPwd = _newPasswordController.text.trim();
    final confirmPwd = _confirmPasswordController.text.trim();

    if (oldPwd.isEmpty) {
      _showSnackbar('Please enter your old password');
      return;
    }
    if (newPwd.isEmpty) {
      _showSnackbar('Please enter a new password');
      return;
    }
    if (confirmPwd.isEmpty) {
      _showSnackbar('Please confirm your new password');
      return;
    }
    if (newPwd != confirmPwd) {
      _showSnackbar('New password and confirm password must match');
      return;
    }
    setState(() => _isLoading = true);
    final credentialsToken = await ApiService.getCredentialsToken();
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await ApiService().changePassword(
        oldPassword: oldPwd,
        newPassword: newPwd,
        confirmPassword: confirmPwd,
        token: credentialsToken.toString(),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        _showSnackbar(data['message'] ?? 'Password changed successfully',
            isError: false);

        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();

        await prefs.setBool('isLoggedIn', false);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessPopupDialog(
            title: "Password Changed",
            description: data['message'] ?? 'Password changed successfully 👍',
            buttonText: AppStrings.okay,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
              print(
                  "Complaint submitted successfully! \n\n\n 👍👍👍👍👍😂😍😁🙌");
            },
          ),
        );
      } else {
        _showSnackbar(data['message'] ?? data['error']);
      }
    } catch (e) {
      _showSnackbar('Something went wrong. Try again.');
    }finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarSection(context),
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
                        myController: _oldPasswordController,
                      ),
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
                      onPressed: _handleChangePassword,
                        isLoading: _isLoading,// You can manage loading state if needed,

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
