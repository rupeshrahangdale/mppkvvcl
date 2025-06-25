import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:mppkvvcl/SRC/widgets/widgets.dart';
 import 'dart:io';

import '../widgets/input_field.dart';
// import 'package:image_picker/image_picker.dart';

class AddComplaintScreen extends StatefulWidget {
  @override
  _AddComplaintScreenState createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  // Variables to hold selected values
  String? selectedEquipment;
  String? selectedComplaint;
  String? selectedVendor;
  String? photoPath;
  final moreInfoController = TextEditingController();
  //
  // XFile? _pickedImage;
  // String? _pickedImageName;
  // final ImagePicker _picker = ImagePicker();

  final List<String> equipmentList = ['Transformer', 'Switch', 'Cable'];
  final List<String> complaintList = ['Not Working', 'Sparking', 'Noise'];
  final List<String> vendorList = ['Vendor A', 'Vendor B', 'Vendor C'];

  // Future<void> pickPhoto() async {
  //   final picked = await _picker.pickImage(source: ImageSource.camera);
  //   if (picked != null) {
  //     setState(() {
  //       _pickedImage = picked;
  //       _pickedImageName = picked.name;
  //     });
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

                    CustomDropdownWidget(
                      lableText: 'Equipment Type',
                      hintText: 'Select Equipment',
                      items: equipmentList,
                      selectedItem: selectedEquipment,
                      onChanged: (val) =>
                          setState(() => selectedEquipment = val),
                    ),
                    SizedBox(height: 8),

                    CustomDropdownWidget(
                        lableText: 'Complaint Type',
                        items: complaintList,
                        selectedItem: selectedComplaint,
                        hintText: "Complaint Type ",
                        onChanged: (val) =>
                            setState(() => selectedComplaint = val)),
                    SizedBox(height: 8),

                    // Vendor Dropdown

                    CustomDropdownWidget(
                      lableText: 'Vendor Name',
                      items: vendorList,
                      selectedItem: selectedVendor,
                      hintText: "Select Vendor",
                      onChanged: (val) => setState(() => selectedVendor = val),
                    ),

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
                      onTap: (){},
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
                    // if (_pickedImageName != null) ...[
                    //   SizedBox(height: 8),
                    //   Text(
                    //     'Selected: $_pickedImageName',
                    //     style: TextStyle(fontSize: 13, color: Colors.black54),
                    //   ),
                    // ],
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
