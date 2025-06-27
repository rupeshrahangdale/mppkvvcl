// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mppkvvcl/SRC/constent/app_constant.dart';
// import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
// import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
//
// class ComplaintDetailsScreen extends StatefulWidget {
//   final int complaintID;
//
//   const ComplaintDetailsScreen({Key? key, required this.complaintID}) : super(key: key);
//
//   @override
//   State<ComplaintDetailsScreen> createState() => _ComplaintDetailsScreenState();
// }
//
// class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
//   Map<String, dynamic>? complaintData;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchComplaintDetails();
//   }
//
//   Future<void> fetchComplaintDetails() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
//       final url = 'https://serverx.in/api/complaints?comp_id=${widget.complaintID}';
//
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': token,
//           'Accept': 'application/json',
//         },
//       );
//
//       final data = jsonDecode(response.body);
//       if (data['status'] == true && data['data'] is List && data['data'].isNotEmpty) {
//         setState(() {
//           complaintData = data['data'][0];
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Complaint not found');
//       }
//     } catch (e) {
//       print('Error fetching complaint details: $e');
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: SafeArea(
//         child: isLoading
//         ? Center(child: CircularProgressIndicator())
//         : SingleChildScrollView(
//     child: Container(
//     width: AppMediaQuery.screenWidth,
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     AppBarSection(),
//     Container(
//     padding: const EdgeInsets.all(AppDimensions.defaultPaddingVertical),
//     margin: const EdgeInsets.all(AppDimensions.defaultPadding),
//     decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
//     boxShadow: [
//     BoxShadow(
//     color: Color.fromRGBO(0, 0, 0, 0.16),
//     blurRadius: 4,
//     offset: Offset(0, 1),
//     ),
//     ],
//     ),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     const Text('Complain for categoryName:', style: AppTextStyles.subtitle),
//     const SizedBox(height: 8),
//     ComplaintProfile(
//     title: "Department",
//     icon: Icons.apartment,
//     textColor: Colors.blueAccent,
//     location: "Electricity Department",
//     ),
//     const SizedBox(height: 16),
//     ComplaintProfile(
//     title: "Location",
//     icon: Icons.location_on,
//     textColor: AppColors.textBlack,
//     location: complaintData?["complaint_description"]?["location"] ?? '-',
//     ),
//     const SizedBox(height: 16),
//     const Text('Description:', style: AppTextStyles.subtitle),
//     const SizedBox(height: 8),
//     Text(
//     complaintData?["complaint_description"]?["complaint"] ?? '-',
//     style: AppTextStyles.caption.copyWith(color: AppColors.greyText),
//     ),
//     const SizedBox(height: 16),
//     Padding(
//     padding: const EdgeInsets.only(bottom: 8.0),
//     child: Row(
//     children: [
//     Container(
//     decoration: BoxDecoration(
//     color: Colors.blue.shade50,
//     borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
//     ),
//     padding: const EdgeInsets.all(8),
//     child: Icon(Icons.image, color: Colors.blue),
//     ),
//     const SizedBox(width: 10),
//     Text(
//     "Complaint image",
//     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//     ),
//     ],
//     ),
//     ),
//     ],
//     ),
//     ),
//     Container(
//     margin: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
//     child: Column(
//     children: [
//     Row(
//     children: [
//     const Text('Status', style: AppTextStyles.subtitle),
//     const SizedBox(width: 8),
//     Container(
//     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//     decoration: BoxDecoration(
//     color: Colors.green,
//     borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
//     ),
//     child: Text(
//     complaintData?["status"].toString() ?? '-',
//     style: const TextStyle(
//     color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
//     ),
//     ),
//     ],
//     ),
//     const SizedBox(height: 16),
//     Row(
//     children: [
//     const Text('Complaint ID:', style: AppTextStyles.subtitle),
//     const SizedBox(width: 8),
//     Container(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//     decoration: BoxDecoration(
//     color: Colors.grey.shade200,
//     borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
//     ),
//     child: Text('#${widget.complaintID}', style: AppTextStyles.body),
//     ),
//     ],
//     ),
//     const SizedBox(height: 16),
//     Row(
//     children: [
//     const Text('Created:', style: AppTextStyles.subtitle),
//     const SizedBox(width: 8),
//     Text(
//     complaintData?["created_at"] ?? '-',
//     style: const TextStyle(fontSize: 13),
//     ),
//     ],
//     ),
//     ],
//     ),
//     ),
//     ],
//     ),
//     ),
//     ),
//     bottomNavigationBar: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
//     child: Row(
//     children: [
//     Expanded(
//     child: CostomPrimaryButton(
//     text: "Mark as Resolve",
//     onPressed: () {
//     showResolvedBottomDrawer(context);
//     SuccessPopupDialog(
//     title: "Complaint Resolved",
//     description: "Complaint has been marked as resolved.",
//     buttonText: "Okay",
//     onTap: () {
//     Navigator.pop(context);
//     Navigator.pop(context);
//     },
//     );
//     },
//     ),
//     ),
//     const SizedBox(width: 16),
//     Expanded(
//     child: CostomPrimaryButtonBorder(
//     text: "Transfer",
//     onPressed: () {
//     showTransferBottomDrawer(
//     context: context,
//     dropdownItems: [
//     'Technical Team',
//     'Billing Department',
//     'Customer Support',
//     'Field Staff',
//     ],
//     onTransfer: (selected) {
//     print("Transferred to: $selected");
//     },
//     );
//     },
//     borderColor: Colors.redAccent,
//     ),
//     ),
//     ],
//     ),
//     ),
//     );
//     }
// }
//
