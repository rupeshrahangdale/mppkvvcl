import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';



class JobRoleDropdownScreen extends StatefulWidget {
  @override
  _JobRoleDropdownScreenState createState() => _JobRoleDropdownScreenState();
}

class _JobRoleDropdownScreenState extends State<JobRoleDropdownScreen> {
  final List<String> jobRoles = [
    'Developer',
    'Designer',
    'Consultant',
    'Student',
  ];

  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Job Roles Search Dropdown',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                CustomDropdown.search(
                  hintText: 'Select job role',
                  items: jobRoles,
                  initialItem: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                    print("Selected: $value");
                  },
                  decoration: CustomDropdownDecoration(
                    closedFillColor: Colors.grey[100],
                    expandedFillColor: Colors.grey[100],
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    closedBorder: Border.all(color: Colors.grey.shade300),
                    expandedBorder: Border.all(color: Colors.grey.shade400),
                    closedBorderRadius: BorderRadius.circular(10),
                    expandedBorderRadius: BorderRadius.circular(10),

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
