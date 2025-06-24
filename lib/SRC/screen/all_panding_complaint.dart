import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import '../constent/app_constant.dart';
import '../widgets/all_card.dart';
import '../widgets/costom_button.dart';
import 'complaint_details_screen.dart';
import 'complaint_type_screen.dart';

class AllPendingComplaintScreen extends StatelessWidget {
  const AllPendingComplaintScreen({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(AppStrings.allPandingComplaints,
                        style: AppTextStyles.heading),
                    Text(AppStrings.allPandingComplaintsDescription,
                        style: AppTextStyles.caption),
                    const SizedBox(height: 25),
                    // list of all my added list Complaint Cards

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5, // Replace with your actual data length
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to complaint details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComplaintDetailsScreen(
                                  complaint: Complaint(
                                    id: '10403229612',
                                    title: 'AC Repairing Services',
                                    description:
                                        'The AC is not cooling properly and requires urgent attention.',
                                    status: 'Pending',
                                    date: DateTime.now(),
                                  ),
                                  complainCreator: "Rushabh Patel",
                                ),
                              ),
                            );
                          },
                          child: buildPendingComplaintCard(
                            id: '10403229612',
                            title: 'AC Repairing Services',
                            date: ' 17 Oct 2023 ',
                            location: 'Bhopal',
                            status: 'Pending',
                            complaintDescription:
                                'The AC is not cooling properly and requires urgent attention.',
                          ),
                        );
                      },
                    ),

                    // buildComplaintCard(
                    //   id: '10403229612',
                    //   title: 'AC Repairing Services',
                    //   date: 'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                    //   location: ' Ahmed Show Room, Guishan, Dhaka sav a  f jj dfh',
                    //   status: 'Open',
                    // ),
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
