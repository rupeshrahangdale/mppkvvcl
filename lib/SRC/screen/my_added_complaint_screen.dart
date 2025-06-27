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

  @override
  void initState() {
    super.initState();
    fetchUserComplaints();
  }

  Future<void> fetchUserComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? 0;
    final token = prefs.getString('token') ?? '';
    final url = 'https://serverx.in/api/complaints?user_id=$userId';

    if (userId == 0 || token.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return; // User not logged in or token not available
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': token,
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

  String formatDate(String dateTimeString) {
    try {
      final dt = DateTime.parse(dateTimeString);
      return "Created: \${dt.day} \${_monthName(dt.month)} \${dt.year}, \${_formatTime(dt)}";
    } catch (e) {
      return "Created: N/A";
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
                            child: buildStatCard(
                                '${userComplaints.length}', 'Total')),
                        const SizedBox(width: 8),
                        Expanded(child: buildStatCard('99', 'Open')),
                        const SizedBox(width: 8),
                        Expanded(child: buildStatCard('13', 'Closed')),
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
                              title: complaint.complaint,
                              date: complaint.createdAt,
                              location: complaint.location,
                              status: 'Pending',
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
