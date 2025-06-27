import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import '../constent/app_constant.dart';
import '../widgets/app_bar_section.dart';
import '../widgets/all_card.dart';
 import 'all_panding_complaint.dart';
import 'my_added_complaint_screen.dart';
import 'change_password_screen.dart';
import 'complaint_type_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String name;
  final String? profilePhotoUrl;

  const HomeScreen({
    Key? key,
    required this.username,
    required this.name,
    this.profilePhotoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: AppMediaQuery.screenHeight * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    AppBarSection(),
                    Padding(
                      padding:
                          const EdgeInsets.all(AppDimensions.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.logo2,
                            height: 80,
                            // width: 80,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            AppStrings.welcomeMessage,
                            style: AppTextStyles.subtitle.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                          Text(name, style: AppTextStyles.heading),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 24),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.16),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: Offset(
                                      0,
                                      1,
                                    ),
                                  ),
                                ]),
                            child: Column(
                              children: [
                                CostomPrimaryButton(
                                  text: AppStrings.addNewComplaint,
                                  onPressed: () {
                                    // add bottom sheet or navigate to complaint type screen

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ComplaintTypeScreen(),
                                        ));

                                    // showSingleInputBottomDrawer(
                                    //   context: context,
                                    //   title: AppStrings.addNewComplaint,
                                    //   hintText: 'Enter Complaint Title',
                                    //   onSubmit: (String value) {
                                    //     // Handle the new complaint submission
                                    //     print('New Complaint: $value');
                                    //     //close the bottom sheet
                                    //
                                    //     Navigator.pop(context);
                                    //
                                    //
                                    //
                                    //   }, label: 'Complaint Title', buttonText: 'Submit Complaint', controller: TextEditingController(), isLoading: false,  onButtonPressed: () {  },
                                    // );
                                  },
                                  icon: CupertinoIcons.plus,
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: buildActionCard(
                                        title: AppStrings.myComplaint,
                                        image: Image.asset(
                                          AppAssets.myComplaintIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyAllAddedComplaintScreen()),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            16), // spacing between the two cards
                                    Expanded(
                                      child: buildActionCard(
                                        title: AppStrings.allPandingComplaints,
                                        image: Image.asset(
                                          AppAssets.pandingComplaintIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AllPendingComplaintScreen()),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                CostomPrimaryButtonBorder(
                                    text: AppStrings.changePassword,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChangePasswordScreen(),
                                          ));
                                    },
                                    isLoading: false),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.appName, style: AppTextStyles.subtitle),
                    const SizedBox(width: 8),
                    Text(AppStrings.appVersion, style: AppTextStyles.body),
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
