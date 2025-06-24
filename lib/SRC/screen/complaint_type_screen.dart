import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/screen/new_complaint_screen.dart';

import '../widgets/all_card.dart';
import '../widgets/app_bar_section.dart';

class ComplaintTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // App Bar Section
              AppBarSection(),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const SizedBox(height: 8),
                    Text(AppStrings.complaintCategory,
                        style: AppTextStyles.heading),
                    Text(AppStrings.complaintCategoryDescription,
                        style: AppTextStyles.caption),
                    const SizedBox(height: 25),
                    // Categories Title
                    Text(
                      AppStrings.complaintType,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Categories Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Add Complaint Screen and pass the title
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddComplaintScreen(),
                              ),
                            );
                          },
                          child: ComplaintCategoryCard(
                            title: 'Control Center',
                            image: 'assets/dummy_data/add compa.png',
                          ),
                        ),
                        ComplaintCategoryCard(
                          title: 'Substation',
                          image: 'assets/dummy_data/my complaint.png',
                        ),
                        ComplaintCategoryCard(
                          title: 'Feeders',
                          image: 'assets/dummy_data/panding complaint.png',
                        ),
                        ComplaintCategoryCard(
                          title: 'Line Equipment',
                          image: 'assets/images/complaint.png',
                        ),
                      ],
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
