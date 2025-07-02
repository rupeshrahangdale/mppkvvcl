import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/screen/AddNewComplaint/line_equipment_add_complaint.dart';
import 'package:mppkvvcl/SRC/screen/new_complaint_screen.dart';
import 'package:mppkvvcl/SRC/services/complain_service.dart';

import '../widgets/all_card.dart';
import '../widgets/app_bar_section.dart';
import 'AddNewComplaint/control_center_add_complaint.dart';
import 'AddNewComplaint/feeder_add_complaint.dart';
import 'AddNewComplaint/substation_add_complaint.dart';

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
              AppBarSection(context),
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
                            print("Complaint Category: Control Center");
                            // Navigate to the Add Complaint Screen and pass the title
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContrlCenterAddComplaint(),
                              ),
                            );
                          },
                          child: ComplaintCategoryCard(
                            title: 'Control Center',
                            image: 'assets/dummy_data/add compa.png',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Add Complaint Screen and pass the title
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubstationAddComplaint(),
                              ),
                            );
                          },
                          child: ComplaintCategoryCard(
                            title: 'Substation',
                            image: 'assets/dummy_data/my complaint.png',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Add Complaint Screen and pass the title
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeederAddComplaint(),
                              ),
                            );
                          },
                          child: ComplaintCategoryCard(
                            title: 'Feeders',
                            image: 'assets/dummy_data/panding complaint.png',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Add Complaint Screen and pass the title
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LineEquipmentAddComplaint(
                                  ComplaintCategory: "Line Equipments",
                                ),
                              ),
                            );
                          },
                          child: ComplaintCategoryCard(
                            title: 'Line Equipment',
                            image: 'assets/images/complaint.png',
                          ),
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
