import 'package:flutter/material.dart';
import '../constent/app_constant.dart';
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
  bool _obscureOld = true;
  bool _obscureNew = true;
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
                    horizontal: AppDimensions.defaultPaddingHorizontal *2,
                    vertical: AppDimensions.defaultPaddingHorizontal
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Change Password',
                      style: AppTextStyles.heading
                          .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    CostomInputField(
                      label: '',
                      hintText: 'Old Password',
                      controller: _oldPasswordController,
                    ),
                     CostomInputField(
                      label: '',
                      hintText: 'New Password',
                      controller: _newPasswordController,
                      obscureText: _obscureNew,
                    ),
                     CostomInputField(
                      label: '',
                      hintText: 'Confirm Password',
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 36),
                    CostomPrimaryButton(
                      text: 'Save',
                      onPressed: () {
                        // TODO: Implement save logic
                        if (_newPasswordController.text ==
                            _confirmPasswordController.text) {
                          // Logic to change password
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Password changed successfully!')),
                          );
                          // navigate back or clear fields
          
                          _oldPasswordController.clear();
                          _newPasswordController.clear();
                          _confirmPasswordController.clear();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Passwords do not match!')),
                          );
                        }
                      },
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
