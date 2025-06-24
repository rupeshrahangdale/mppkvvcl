import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import '../constent/app_constant.dart';
import '../widgets/all_card.dart';
import '../widgets/costom_button.dart';
import 'complaint_type_screen.dart';

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
                margin: const EdgeInsets.all(AppDimensions.defaultPadding),
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
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
                    // New Complaint Button
                    CostomPrimaryButton(
                      text: AppStrings.addNewComplaint,
                      onPressed: () {
                        // add bottom sheet or navigate to complaint type screen

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComplaintTypeScreen(),
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
                    const SizedBox(height: 20),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' My Added Complaints',
                          style: AppTextStyles.subtitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // list of all my added list Complaint Cards

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5, // Replace with your actual data length
                      itemBuilder: (context, index) {
                        return buildComplaintCard(
                          id: '10403229612',
                          title: 'AC Repairing Services',
                          date:
                              'Last Update: 17 Oct 2023, Created: 17 Oct 2023',
                          location: 'Ahmed Show Room, Guishan, Dhaka ',
                          status: 'pending',
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
