import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constent/app_constant.dart';
import '../widgets/app_bar_section.dart';
import '../widgets/all_card.dart';
import 'all_panding_complaint.dart';
import 'login_screen.dart';
import 'my_added_complaint_screen.dart';
import 'change_password_screen.dart';
import 'complaint_type_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'User'; // default
  String department = 'Department'; // default

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? 'User';
    final dept = prefs.getString('department') ?? 'Department';
    await prefs.setBool('isLoggedIn', true);

    setState(() {
      userName = name;
      department = dept;
    });

    print('User Name: $userName');
    print('Department: $department');
  }

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
                    AppBarSection(context),
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
                          Text(userName, style: AppTextStyles.heading),
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
