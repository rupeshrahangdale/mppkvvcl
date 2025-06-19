import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import '../constent/app_constant.dart';
import '../widgets/app_bar_section.dart';
import '../widgets/all_card.dart';
import 'all_complaint_screen.dart';
import 'change_password_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      AppStrings.welcomeMessage,
                      style: AppTextStyles.heading,
                    ),
                    Text(
                      'Rushabh Patel',
                      style: AppTextStyles.heading.copyWith(
                        fontSize: 28,
                        color: Colors.blue.shade300,
                      ),
                    ),


                    const SizedBox(height: 32),

                    CostomPrimaryButton(
                      text: AppStrings.addNewComplaint,
                      onPressed: () {},
                      icon: CupertinoIcons.plus,
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildActionCard(
                            title: AppStrings.myComplaint,
                            icon: CupertinoIcons.doc_append,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AllComplaintScreen(),
                                ),
                              );
                            }),
                        buildActionCard(
                            title: AppStrings.allPandingComplaints,
                            icon: CupertinoIcons.doc_text,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const AllComplaintScreen(),
                                ),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CostomPrimaryButton(
                      text: AppStrings.changePassword,
                      onPressed: () {
                        // Navigate to Change Password Screen
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ));
                      },
                      icon: CupertinoIcons.padlock_solid,
                      isLoading: false,
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
