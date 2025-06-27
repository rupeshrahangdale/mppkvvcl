import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/widgets/all_card.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:mppkvvcl/SRC/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../models/complaint_node_model.dart';
import '../widgets/input_field.dart';
// import 'package:image_picker/image_picker.dart';

class AddComplaintScreen extends StatefulWidget {
  final String ComplaintType;
  AddComplaintScreen({required this.ComplaintType, Key? key}) : super(key: key);
  @override
  _AddComplaintScreenState createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  List<ComplaintNode> complaintData = [];

  ComplaintNode? selectedCategory;
  ComplaintNode? selectedDivision;
  ComplaintNode? selectedLocation;
  ComplaintNode? selectedEquipmentType;
  final moreInfoController = TextEditingController();

  String get ComplaintCategory => widget.ComplaintType;

  @override
  void initState() {
    super.initState();

    if (ComplaintCategory == "Control Center") {
      fetchComplaintData(1);
    } else if (ComplaintCategory == "Substation") {
      fetchComplaintData(2);
    } else if (ComplaintCategory == "Feeders") {
      fetchComplaintData(3);
    } else if (ComplaintCategory == "Line Equipment") {
      fetchComplaintData(4);
    }
    // fetchComplaintData(1);
  }

  Future<void> fetchComplaintData(int complaintCategory) async {
    final url =
        'https://serverx.in/api/complain-master-data?complaint_type_id=$complaintCategory';

    // get token that saved in shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    print(
        'Token: $token ========================> '); // Debugging line to check token

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
      print('Fetched complaint data: ${childrenJson.length} items');
      print('Fetched complaint data: ${decoded['children']}');
      setState(() {
        complaintData =
            childrenJson.map((e) => ComplaintNode.fromJson(e)).toList();
      });
    } else {
      print('Failed to fetch complaint data: ${response.statusCode}');
    }
  }

  // // Variables to hold selected values ////////////////////////////////
  String? selectedEquipment;
  String? selectedComplaint;
  String? selectedVendor;
  String? photoPath;
  //
  XFile? _pickedImage;
  String? _pickedImageName;
  final ImagePicker _picker = ImagePicker();
  //
  // final List<String> equipmentList = ['Transformer', 'Switch', 'Cable'];
  // final List<String> complaintList = ['Not Working', 'Sparking', 'Noise'];
  // final List<String> vendorList = ['Vendor A', 'Vendor B', 'Vendor C'];
  //
  Future<void> pickPhoto() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
        _pickedImageName = picked.name;
      });
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
              // app bar section
              AppBarSection(),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(AppStrings.newComplaintRegister,
                        style: AppTextStyles.heading),
                    Text(AppStrings.newComplaintRegisterDescription,
                        style: AppTextStyles.caption),
                    const SizedBox(height: 25),

                    // Equipment Dropdown
                    if (complaintData.isNotEmpty)
                      CustomDropdownWidget(
                        lableText: 'Category',
                        hintText: 'Select Category',
                        items: complaintData.map((e) => e.name).toList(),
                        selectedItem: selectedCategory?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedCategory = complaintData
                                .firstWhere((e) => e.name == "Line Equipment");
                            selectedDivision = null;
                            selectedLocation = null;
                            selectedEquipmentType = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),

                    if (selectedCategory != null)
                      CustomDropdownWidget(
                        lableText: 'Division',
                        hintText: 'Select Division',
                        items: selectedCategory!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedDivision?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedDivision = selectedCategory!.children
                                .firstWhere((e) => e.name == val);
                            selectedLocation = null;
                            selectedEquipmentType = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),

                    if (selectedDivision != null)
                      CustomDropdownWidget(
                        lableText: 'Location',
                        hintText: 'Select Location',
                        items: selectedDivision!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedLocation?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedLocation = selectedDivision!.children
                                .firstWhere((e) => e.name == val);
                            selectedEquipmentType = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),

                    if (selectedLocation != null)
                      CustomDropdownWidget(
                        lableText: 'Equipment Type',
                        hintText: 'Select Equipment Type',
                        items: selectedLocation!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedEquipmentType?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedEquipmentType = selectedLocation!.children
                                .firstWhere((e) => e.name == val);
                          });
                        },
                      ),
                    // const SizedBox(height: 8),

                    // Complaint Type Dropdown

                    SizedBox(height: 8),
                    CostomInputField(
                      label: "More Information",
                      hintText: "Type",
                      controller: moreInfoController,
                      maxLines: 3,
                    ),

                    SizedBox(height: 8),

                    // Photo Upload
                    Text('Complaint Photo', style: AppTextStyles.caption),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: DottedBorderContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.upload, color: Color(0xFF1A73E8)),
                            SizedBox(width: 8),
                            Text(
                              'Capture Photo',
                              style: TextStyle(
                                color: Color(0xFF1A73E8),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_pickedImageName != null) ...[
                      SizedBox(height: 8),
                      Text(
                        'Selected: $_pickedImageName',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                    SizedBox(height: 20),
                    // Create Button
                    CostomPrimaryButton(
                      text: 'Create Complaint',
                      onPressed: () {
                        // Handle complaint creation logic here
                        print('Complaint Created');

                        // Show success popup
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => SuccessPopupDialog(
                            title: AppStrings.complaintCreated,
                            description: AppStrings.complaintCreatedDescription,
                            buttonText: AppStrings.okay,
                            onTap: () {
                              Navigator.pop(context); // close dialog
                              Navigator.pop(
                                  context); // then go back to previous screen
                            },
                          ),
                        );
                      },
                    ),

                    // CostomPrimaryButton(text: , onPressed: onPressed)
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

class DottedBorderContainer extends StatelessWidget {
  final Widget child;

  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1A73E8),
          style: BorderStyle.solid, // Simulating dotted by styling
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: child),
    );
  }
}
