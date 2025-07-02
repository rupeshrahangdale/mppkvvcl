import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mppkvvcl/SRC/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../gpt.dart';
import '../constent/app_constant.dart';
import '../models/user_complaint.dart';
import '../widgets/all_card.dart';
import '../widgets/app_bar_section.dart';
import '../widgets/costom_button.dart';
import 'complaint_details_screen.dart';
import 'complaint_type_screen.dart';

class MyAllAddedComplaintScreen extends StatefulWidget {
  const MyAllAddedComplaintScreen({Key? key}) : super(key: key);

  @override
  State<MyAllAddedComplaintScreen> createState() =>
      _MyAllAddedComplaintScreenState();
}

class _MyAllAddedComplaintScreenState extends State<MyAllAddedComplaintScreen> {
  List<UserComplaint> userComplaints = [];
  bool isLoading = true;
  int totalComplaints = 0;
  int openComplaints = 0; // Pending => status = 2
  int closedComplaints = 0; // Resolved => status = 1
  static final String baseUrl = AppConfig.apiBaseURL;


  @override
  void initState() {
    super.initState();
    initializeApp(); // Call the async method to fetch data
  }

  Future<void> initializeApp() async {
    await fetchComplaintStats();
    fetchUserComplaints();
  }


  Future<void> fetchUserComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? 0;
    final credentialsToken = await ApiService.getCredentialsToken();
    final url = '$baseUrl/api/complaints?user_id=$userId';

    if (userId == 0 || credentialsToken == null) {
      setState(() {
        isLoading = false;
      });
      return; // User not logged in or token not available
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': credentialsToken,
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List complaints = decoded['data'];

      setState(() {
        userComplaints =
            complaints.map((json) => UserComplaint.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchComplaintStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id') ?? 0;
      final token = prefs.getString('token') ?? '';

      final url =
          Uri.parse('$baseUrl/api/complaint-stats?user_id=$userId');

      final response = await http.get(
        url,
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print("✅ Complaint stats fetched successfully: $json \n\n\n");
        if (json['status'] == true && json['data'] is List) {
          List data = json['data'];

          int pending = (data.firstWhere((e) => e['status'] == 2,
                      orElse: () => {'count': 0})['count'] ??
                  0)
              .toInt();
          int resolved = (data.firstWhere((e) => e['status'] == 1,
                      orElse: () => {'count': 0})['count'] ??
                  0)
              .toInt();
          int cancelled = (data.firstWhere((e) => e['status'] == 0,
                      orElse: () => {'count': 0})['count'] ??
                  0)
              .toInt();
          int transferred = (data.firstWhere((e) => e['status'] == 3,
                      orElse: () => {'count': 0})['count'] ??
                  0)
              .toInt();

          setState(() {
            openComplaints = pending;
            closedComplaints = resolved;
            totalComplaints = pending + resolved + cancelled + transferred;
          });
        }
      } else {
        print("❌ Failed to fetch stats: ${response.statusCode}");
      }
    } catch (e) {
      print("❗ Error fetching complaint stats: $e");
    }
  }

  // String formatDate(String dateTimeString) {
  //   try {
  //     final dt = DateTime.parse(dateTimeString);
  //     return "Created: \${dt.day} \${_monthName(dt.month)} \${dt.year}, \${_formatTime(dt)}";
  //   } catch (e) {
  //     return "Created: N/A";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarSection(context),
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
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: Column(
                  children: [
                    CostomPrimaryButton(
                      text: AppStrings.addNewComplaint,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ComplaintTypeScreen()),
                        );
                      },
                      icon: CupertinoIcons.plus,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: buildStatCard('$totalComplaints', 'Total')),
                        const SizedBox(width: 8),
                        Expanded(
                            child: buildStatCard('$openComplaints', 'Open')),
                        const SizedBox(width: 8),
                        Expanded(
                            child:
                                buildStatCard('$closedComplaints', 'Closed')),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' My Added Complaints', style: AppTextStyles.subtitle),
                    const SizedBox(height: 16),
                    if (isLoading)
                      Center(child: CircularProgressIndicator())
                    else if (userComplaints.isEmpty)
                      Text("No complaints found.")
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: userComplaints.length,
                        itemBuilder: (context, index) {
                          final complaint = userComplaints[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ComplaintDetailsScreen(
                                          complaintID: complaint.id,
                                        ))),
                            child: buildComplaintCard(
                              id: complaint.id.toString(),
                              complaintCategory: complaint.complaintCategory,
                              division: complaint.division,
                              vander: complaint.location,
                              status: complaint.status,
                              createdAt: complaint.createdAt,
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
