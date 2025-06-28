import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mppkvvcl/SRC/screen/complaint_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constent/app_constant.dart';
import '../models/panding_complaint_model.dart';
import '../services/api_services.dart';
import '../widgets/all_card.dart';
import '../widgets/app_bar_section.dart';

class AllPendingComplaintScreen extends StatefulWidget {
  const AllPendingComplaintScreen({Key? key}) : super(key: key);

  @override
  State<AllPendingComplaintScreen> createState() =>
      _AllPendingComplaintScreenState();
}

class _AllPendingComplaintScreenState extends State<AllPendingComplaintScreen> {
  List<PendingComplaintModel> pendingComplaints = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPendingComplaints();
  }

  Future<void> fetchPendingComplaints() async {
    try {
      print("⏳ Getting token...");
      final prefs = await SharedPreferences.getInstance();
      final credentialsToken = await ApiService.getCredentialsToken();

      final response = await http.get(
        Uri.parse('https://serverx.in/api/complaints?status=2'),
        headers: {
          'Authorization': credentialsToken.toString(),
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      print("\n\n\n\n 📥 Response: $data \n\n\n\n");
      if (data['status'] == true) {
        setState(() {
          pendingComplaints = List<PendingComplaintModel>.from(
            data['data'].map((json) => PendingComplaintModel.fromJson(json)),
          );
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print('❗ Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarSection(context),
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
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : pendingComplaints.isEmpty
                            ? const Text("No pending complaints found.")
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: pendingComplaints.length,
                                itemBuilder: (context, index) {
                                  final complaint = pendingComplaints[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ComplaintDetailsScreen(
                                                    complaintID: complaint.id,
                                                  )));
                                    },
                                    child: buildPendingComplaintCard(
                                      id: complaint.id.toString(),
                                      complaintCategory:
                                          complaint.complaintCetegory,
                                      date: complaint.date,
                                      division: complaint.division,
                                      status: complaint.status,
                                      vander: complaint.vender,
                                    ),
                                  );
                                },
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
