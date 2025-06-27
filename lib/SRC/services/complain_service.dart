import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/complaint_node_model.dart';

// Dummy CustomDropdownWidget for demo
class CustomDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final String hintText;
  final String lableText;
  final ValueChanged<String?> onChanged;

  const CustomDropdownWidget({
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.lableText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lableText, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedItem,
          hint: Text(hintText),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}



class AddComplaintGPT extends StatefulWidget {
  @override
  _AddComplaintGPTState createState() => _AddComplaintGPTState();
}

class _AddComplaintGPTState extends State<AddComplaintGPT> {
  List<ComplaintNode> complaintData = [];

  ComplaintNode? selectedCategory;
  ComplaintNode? selectedDivision;
  ComplaintNode? selectedLocation;
  ComplaintNode? selectedEquipmentType;

  @override
  void initState() {
    super.initState();
    fetchComplaintData();
  }

  Future<void> fetchComplaintData() async {
    final url = 'https://serverx.in/api/complain-master-data?complaint_type_id=1';
    // get token that saved in shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';


    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': token,
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> childrenJson = decoded['children'];
      setState(() {
        complaintData = childrenJson.map((e) => ComplaintNode.fromJson(e)).toList();
      });
    } else {
      print('Failed to fetch complaint data: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (complaintData.isNotEmpty)
                CustomDropdownWidget(
                  lableText: 'Category',
                  hintText: 'Select Category',
                  items: complaintData.map((e) => e.name).toList(),
                  selectedItem: selectedCategory?.name,
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = complaintData.firstWhere((e) => e.name == val);
                      selectedDivision = null;
                      selectedLocation = null;
                      selectedEquipmentType = null;
                    });
                  },
                ),
              SizedBox(height: 10),

              if (selectedCategory != null)
                CustomDropdownWidget(
                  lableText: 'Division',
                  hintText: 'Select Division',
                  items: selectedCategory!.children.map((e) => e.name).toList(),
                  selectedItem: selectedDivision?.name,
                  onChanged: (val) {
                    setState(() {
                      selectedDivision = selectedCategory!.children.firstWhere((e) => e.name == val);
                      selectedLocation = null;
                      selectedEquipmentType = null;
                    });
                  },
                ),
              SizedBox(height: 10),

              if (selectedDivision != null)
                CustomDropdownWidget(
                  lableText: 'Location',
                  hintText: 'Select Location',
                  items: selectedDivision!.children.map((e) => e.name).toList(),
                  selectedItem: selectedLocation?.name,
                  onChanged: (val) {
                    setState(() {
                      selectedLocation = selectedDivision!.children.firstWhere((e) => e.name == val);
                      selectedEquipmentType = null;
                    });
                  },
                ),
              SizedBox(height: 10),

              if (selectedLocation != null)
                CustomDropdownWidget(
                  lableText: 'Equipment Type',
                  hintText: 'Select Equipment Type',
                  items: selectedLocation!.children.map((e) => e.name).toList(),
                  selectedItem: selectedEquipmentType?.name,
                  onChanged: (val) {
                    setState(() {
                      selectedEquipmentType = selectedLocation!.children.firstWhere((e) => e.name == val);
                    });
                  },
                ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (selectedEquipmentType != null) {
                    print('Complaint Created for ${selectedEquipmentType!.name}');

                    setState(() {
                      selectedCategory = null;
                      selectedDivision = null;
                      selectedLocation = null;
                      selectedEquipmentType = null;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Complaint Created Successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select all fields')),
                    );
                  }
                },
                child: Text('Create Complaint'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
