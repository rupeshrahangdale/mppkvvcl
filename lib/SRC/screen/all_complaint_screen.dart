import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import '../constent/app_constant.dart';
import '../widgets/all_card.dart';

class AllComplaintScreen extends StatelessWidget {
  const AllComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarSection(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlue,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    // New Complaint Button
                    InkWell(
                      onTap: () {
                        // TODO: Navigate to new complaint screen
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: AppMediaQuery.screenWidth * 0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '+ New Complaint',
                          style: AppTextStyles.subtitle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Stats Row
                    Row(
                      children: [
                        Expanded(child: buildStatCard('114', 'Total')),
                        const SizedBox(width: 8),
                        Expanded(child: buildStatCard('99', 'Open')),
                        const SizedBox(width: 8),
                        Expanded(child: buildStatCard('13', 'Closed')),
                      ],
                    ),

                    // Additional Stats
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Complaints',
                          style: AppTextStyles.subtitle,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to view all complaints
                          },
                          child: Text(
                            'View All',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Complaint Cards
                    buildComplaintCard(
                      id: '10403229612',
                      title: 'AC Repairing Services',
                      date: 'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                      location: 'Ahmed Show Room, Guishan, Dhaka',
                      status: 'Open',
                    ),
                    buildComplaintCard(
                      id: '10403229612',
                      title: 'AC Repairing Services',
                      date: 'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                      location: 'Ahmed Show Room, Guishan, Dhaka',
                      status: 'Resolved',
                    ),
                    buildComplaintCard(
                      id: '10403229612',
                      title: 'AC Repairing Services',
                      date: 'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                      location: 'Ahmed Show Room, Guishan, Dhaka',
                      status: 'Open',
                    ),
                    buildComplaintCard(
                      id: '10403229612',
                      title: 'AC Repairing Services',
                      date: 'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                      location: 'Ahmed Show Room, Guishan, Dhaka',
                      status: 'Open',
                    ),
                    buildComplaintCard(
                      id: '10403229612',
                      title: 'AC Repairing Services',
                      date: 'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                      location: 'Ahmed Show Room, Guishan, Dhaka',
                      status: 'Resolved',
                    ),
                    buildComplaintCard(
                      id: '10403229612',
                      title: 'AC Repairing Services',
                      date: 'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                      location: 'Ahmed Show Room, Guishan, Dhaka',
                      status: 'Open',
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
