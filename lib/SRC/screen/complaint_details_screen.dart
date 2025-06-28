import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_services.dart';
import '../widgets/widgets.dart';

// Sample Complaint data model
class Complaint {
  final String id;

  Complaint({
    required this.id,
  });
}

class ComplaintDetailsScreen extends StatefulWidget {
  final int complaintID;

  const ComplaintDetailsScreen({Key? key, required this.complaintID})
      : super(key: key);

  @override
  State<ComplaintDetailsScreen> createState() => _ComplaintDetailsScreenState();
}

class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  Map<String, dynamic>? complaintData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchComplaintDetails();
  }

  Future<void> fetchComplaintDetails() async {
    try {
      print("⏳ Getting token...");
      final prefs = await SharedPreferences.getInstance();
      final credentialsToken = await ApiService.getCredentialsToken();
      final token = prefs.getString('token') ?? '';

      final url =
          'https://serverx.in/api/complaints?comp_id=${widget.complaintID}';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': credentialsToken.toString(),
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      print("\n\n\n\n ✅ Complaint details fetched: $data \n\n\n\n\n");
      if (data['status'] == true &&
          data['data'] is List &&
          data['data'].isNotEmpty) {
        setState(() {
          complaintData = data['data'][0];
          isLoading = false;
        });
      } else {
        throw Exception('Complaint not found');
      }
    } catch (e) {
      print('Error fetching complaint details: $e');
      setState(() => isLoading = false);
    }
  }

  void showImagePopup(String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        child: imageUrl != "No image available"
            ? Container(
                padding: const EdgeInsets.all(10),
                width: AppMediaQuery.screenWidth * 0.8,
                height: AppMediaQuery.screenHeight * 0.4,
                child: Image.network(imageUrl, fit: BoxFit.contain),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                width: AppMediaQuery.screenWidth * 0.8,
                height: AppMediaQuery.screenHeight * 0.4,
                child: Center(
                  child: Text(
                    "No image available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
      ),
    );
  }

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
                AppBarSection(context),

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
                      Text(
                          'Complain for ${complaintData?['complain_category_name'] ?? 'null'}:',
                          style: AppTextStyles.subtitle),
                      const SizedBox(height: 8),
                      ComplaintProfile(
                        title:
                            "Division: ${complaintData?['complaint_description']['division'] ?? '-'}",
                        icon: Icons.location_on,
                        textColor: AppColors.textBlack,
                        location:
                            "${complaintData?['complaint_description']['location'] ?? '-'}",
                      ),
                      const SizedBox(height: 16),
                      const Text('Description:', style: AppTextStyles.subtitle),
                      const SizedBox(height: 8),

                      RichTextWidget(
                          subtitle: complaintData?['vendor'] ?? '-',
                          title: "Vendor Name- "),
                      RichTextWidget(
                          subtitle: complaintData?['complaint_description']
                                  ['equipment_type'] ??
                              '-',
                          title: "Equipment Type- "),
                      RichTextWidget(
                          subtitle:
                              "${complaintData?['complaint_description']['equipment'] ?? '-'}",
                          title: "Equipment- "),

                      RichTextWidget(
                          subtitle:
                              "${complaintData?['complaint_description']['complaint'] ?? '-'}",
                          title: "Complaint- "),

                      // remark
                      RichTextWidget(
                          subtitle: "${complaintData?['remark'] ?? '-'}",
                          title: "Remark- "),

                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => showImagePopup(
                            complaintData?['complain_photo_url'] ??
                                'No image available'),
                        child: Padding(
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
                                'View Complaint Image',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
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
                              color: complaintData?["status_label"]
                                          .toLowerCase() ==
                                      'pending'
                                  ? Colors.orange.withOpacity(0.1)
                                  : Colors.green,
                              // color: Colors.green,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadius),
                            ),
                            // if status is open, color is blue, else green

                            child: Text(
                              "${complaintData?["status_label"] ?? '-'}",
                              style: TextStyle(
                                  color: complaintData?["status_label"]
                                              .toLowerCase() ==
                                          'pending'
                                      ? Colors.orange
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
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
                            child: Text(
                                '#${complaintData?["complain_id"] ?? '-'}',
                                style: AppTextStyles.body),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('Created On:',
                              style: AppTextStyles.subtitle),
                          const SizedBox(width: 8),
                          Text(complaintData?["created_at"] ?? '-',
                              style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                      if (complaintData?["status_label"] == "Resolved") ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text('Resolved On:',
                                style: AppTextStyles.subtitle),
                            const SizedBox(width: 8),
                            Text(complaintData?["updated_at"] ?? '-',
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Text('Resolved Remark:',
                                style: AppTextStyles.subtitle),
                            const SizedBox(width: 8),
                            Text(complaintData?["resolved_remark"] ?? '-',
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // time taken to resolve
                        Row(
                          children: [
                            const Text('Time Taken:',
                                style: AppTextStyles.subtitle),
                            const SizedBox(width: 8),
                            Text(complaintData?["resolve_time"] ?? '-',
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // resolved by
                        Row(
                          children: [
                            const Text('Resolved By:',
                                style: AppTextStyles.subtitle),
                            const SizedBox(width: 8),
                            Text(complaintData?["resolved_by_name"] ?? '-',
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 6),

                        GestureDetector(
                          onTap: () => showImagePopup(
                              complaintData?['complain_photo_url'] ??
                                  'No image available'),
                          child: Padding(
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
                                  "View Resolved Image",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ✅ Bottom buttons placed here
      // if complaint is resolved, hide button
      // if complaint is not resolved, show button

      // bottomNavigationBar: complaintData?["status_label"] == "Resolved"
      //     ? null
      //     : Padding(
      bottomNavigationBar: complaintData?["status_label"] == "Resolved"
          ? null
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CostomPrimaryButton(
                      text: "Mark as Resolve",
                      onPressed: () {
                        showResolvedBottomDrawer(
                            context, complaintData?["complain_id"]);
                        print(
                            "Complaint marked as resolved in widget section \n\n\n");
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
                            complaintId: complaintData?["complain_id"],
                            dropdownItems: [
                              "DFE",
                              "OIL",
                              "STM",
                              "HTM",
                            ],
                            onTransfer: (selected) {
                              print(
                                  "Complaint transferred to $selected in widget section \n\n\n");
                            });
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

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.subtitle,
    required this.title,
  });

  final String subtitle;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text.rich(
        TextSpan(
          text: title,
          style: AppTextStyles.caption.copyWith(
              color: AppColors.textBlack, fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: subtitle,
              style: AppTextStyles.caption.copyWith(color: AppColors.greyText),
            ),
          ],
        ),
      ),
    );
  }
}
