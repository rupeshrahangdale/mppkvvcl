import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/screen/my_added_complaint_screen.dart';
import 'package:mppkvvcl/SRC/screen/new_complaint_screen.dart';
import 'package:mppkvvcl/SRC/services/api_services.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:mppkvvcl/SRC/widgets/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isLoading = false; // ✅ Spinner flag

  void _showSnackbar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Future<void> _handleLogin() async {
    final username = _userNameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(AppStrings.fillAllFields),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiService().login(username, password);
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['status'] == true) {
        final user = decoded['user'];
        final prefs = await SharedPreferences.getInstance();

        await prefs.setInt('user_id', user['id']);
        await prefs.setString('name', user['name']);
        await prefs.setString('username', user['username']);
        await prefs.setString('department', user['department']);
        await prefs.setString('profile_photo', user['profile_photo']);
        await prefs.setString('LoginUsername', username);
        await prefs.setString('LoginPassword', password);
        await prefs.setBool('isLoggedIn', true);

        _showSnackbar(decoded['message']);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        _showSnackbar(decoded['message'], isError: true);
      }
    } catch (e) {
      print("Login    error: $e");
      // Show error message
      _showSnackbar("Something went wrong: $e", isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

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

                    MyTextField(
                      fieldName: AppStrings.username,
                      myController: _userNameController,
                    ),
                    const SizedBox(height: 16),

                    MyTextField(
                      fieldName: AppStrings.password,
                      myController: _passwordController,
                      obscureText: _obscurePassword,
                    ),

                    const SizedBox(height: 32),
                    CostomPrimaryButton(
                      text: AppStrings.login,
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    ),
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
