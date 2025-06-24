import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';

import '../widgets/widgets.dart';

// Sample Complaint data model
class Complaint {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime date;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
  });
}

class ComplaintDetailsScreen extends StatelessWidget {
  final Complaint complaint;
  final String? complainOf;
  final String? complainCreator;
  final String? imageurl;

  const ComplaintDetailsScreen({
    Key? key,
    required this.complaint,
    this.complainOf,
    this.complainCreator,
    this.imageurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: AppMediaQuery.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarSection(),

                // Complaint Details
                Container(
                  padding: const EdgeInsets.all(
                      AppDimensions.defaultPaddingVertical),
                  margin: const EdgeInsets.all(AppDimensions.defaultPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Complain for categoryName:',
                          style: AppTextStyles.subtitle),
                      const SizedBox(height: 8),
                      ComplaintProfile(
                        title: "Department",
                        icon: Icons.apartment,
                        textColor: Colors.blueAccent,
                        location: "Electricity Department",
                      ),
                      const SizedBox(height: 16),
                      ComplaintProfile(
                        title: "Location",
                        icon: Icons.location_on,
                        textColor: AppColors.textBlack,
                        location: "Bhopal",
                      ),
                      const SizedBox(height: 16),
                      const Text('Description:', style: AppTextStyles.subtitle),
                      const SizedBox(height: 8),
                      Text(
                        complaint.description,
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.greyText),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(Icons.image, color: Colors.blue),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Complaint image",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Status', style: AppTextStyles.subtitle),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: complaint.status.toLowerCase() == 'open'
                                  ? Colors.blue
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadius),
                            ),
                            child: Text(
                              complaint.status,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text('Complaint ID:',
                              style: AppTextStyles.subtitle),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadius),
                            ),
                            child: Text('#${complaint.id}',
                                style: AppTextStyles.body),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text('Created:', style: AppTextStyles.subtitle),
                          const SizedBox(width: 8),
                          Text("20/20/3023 2:20 PM",
                              style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ✅ Bottom buttons placed here
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: CostomPrimaryButton(
                text: "Mark as Resolve",
                onPressed: () {
                  showResolvedBottomDrawer(context);
                  SuccessPopupDialog(
                    title: "Complaint Resolved",
                    description: "Complaint has been marked as resolved.",
                    buttonText: "Okay",
                    onTap: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // then go back to previous screen
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CostomPrimaryButtonBorder(
                text: "Transfer",
                onPressed: () {
                  showTransferBottomDrawer(
                    context: context,
                    dropdownItems: [
                      'Technical Team',
                      'Billing Department',
                      'Customer Support',
                      'Field Staff',
                    ],
                    onTransfer: (selected) {
                      print("Transferred to: $selected");
                      // Handle the transfer logic here

                      print(
                          "Complaint transferred to: $selected in widget section");
                    },
                  );
                },
                borderColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
