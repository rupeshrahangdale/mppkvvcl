import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:mppkvvcl/SRC/services/api_services.dart';
import 'package:mppkvvcl/SRC/widgets/all_card.dart';
import 'package:mppkvvcl/SRC/widgets/app_bar_section.dart';
import 'package:mppkvvcl/SRC/widgets/costom_button.dart';
import 'package:mppkvvcl/SRC/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart'; // <- Add this import at top

import '../../models/complaint_node_model.dart';
import '../../widgets/input_field.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// import 'package:image_picker/image_picker.dart';

class LineEquipmentAddComplaint extends StatefulWidget {
  final String ComplaintCategory;
  LineEquipmentAddComplaint({required this.ComplaintCategory, Key? key})
      : super(key: key);
  @override
  _LineEquipmentAddComplaintState createState() =>
      _LineEquipmentAddComplaintState();
}

class _LineEquipmentAddComplaintState extends State<LineEquipmentAddComplaint> {
  List<ComplaintNode> complaintData = [];
  ComplaintNode? selectedCategory;
  ComplaintNode? selectedDivision;
  ComplaintNode? selectedLineEquipmentType;
  ComplaintNode? selectedLocation;
  ComplaintNode? selectedEquipment;
  ComplaintNode? selectedComplaint;
  ComplaintNode? selectedVandorName;
  final moreInfoController = TextEditingController();

  String get ComplaintCategory => widget.ComplaintCategory;

  @override
  void initState() {
    super.initState();

    if (ComplaintCategory == "Control Center") {
      fetchComplaintData(1);
    } else if (ComplaintCategory == "Substation") {
      fetchComplaintData(2);
    } else if (ComplaintCategory == "Feeders") {
      fetchComplaintData(3);
    } else if (ComplaintCategory == "Line Equipments") {
      fetchComplaintData(4);
    }
    // fetchComplaintData(1);
  }

  Future<void> fetchComplaintData(int complaintCategory) async {
    final url =
        'https://serverx.in/api/complain-master-data?complaint_type_id=$complaintCategory';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    print("get token form Api ================================== ");
    final credentialsToken = await ApiService.getCredentialsToken();
    print("get token form Api $credentialsToken ========================");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': credentialsToken.toString(),
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> childrenJson = decoded['children'];

      final fetchedData =
          childrenJson.map((e) => ComplaintNode.fromJson(e)).toList();

      // ✅ Auto-select category based on passed ComplaintType
      final autoSelectedCategory = fetchedData.firstWhere(
        (node) =>
            node.name.toLowerCase() == widget.ComplaintCategory.toLowerCase(),
        orElse: () => fetchedData.isNotEmpty
            ? fetchedData.first
            : ComplaintNode(id: 0, name: '', children: []),
      );

      setState(() {
        complaintData = fetchedData;
        selectedCategory = autoSelectedCategory;
        selectedDivision = null;
        selectedLineEquipmentType = null;
        selectedLocation = null;
        selectedEquipment = null;
        selectedComplaint = null;
        selectedVandorName = null;
      });
    } else {
      print('Failed to fetch complaint data: ${response.statusCode}');
    }
  }

  Future<void> submitComplaint() async {
    try {
      print("⏳ Getting token...");
      final credentialsToken = await ApiService.getCredentialsToken();
      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getInt('user_id') ?? 0;

      print("🔐 Token: $credentialsToken");
      print("👤 User ID: $userID");

      final url = 'https://serverx.in/api/add-complaint';

      final body = {
        "complain_category": 1, // fixed or make dynamic if needed
        "complaint_description": {
          "division": selectedDivision?.name ?? '',
          "equipment_type": selectedLineEquipmentType?.name ?? '',
          "location": selectedLocation?.name ?? '',
          "equipment": selectedEquipment?.name ?? '',
          "complaint": selectedComplaint?.name ?? '',
        },
        "vendor": selectedVandorName?.name ?? '',
        "remark": moreInfoController.text.toString(), // More Info field
        "added_by": userID,
        "complain_photo": _pickedImage != null
            ? base64Encode(File(_pickedImage!.path).readAsBytesSync())
            : null, // Convert image to base64 if selected
      };

      final headers = {
        'Authorization': credentialsToken.toString(),
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      print("📤 Sending complaint data to server...");
      print("📦 Payload: ${jsonEncode(body)}");

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body);
      print('✅ API Response: $responseData');

      if (response.statusCode == 200 && responseData['status'] == true) {
        print(
            '\n\n\n\n\n✅ Complaint submitted successfully! ID: ${responseData['data']['id']} \n\n\n\n');

        // ✅ Complaint added successfully
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessPopupDialog(
            title: AppStrings.complaintCreated,
            description: AppStrings.complaintCreatedDescription,
            buttonText: AppStrings.okay,
            onTap: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back to previous screen
            },
          ),
        );
      } else {
        // ❌ API failed or returned error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              '❌ Failed to submit complaint: ${responseData['message'] ?? 'Unknown error'}'),
          backgroundColor: Colors.redAccent,
        ));
      }
    } catch (e) {
      print('❗ Error submitting complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while submitting complaint'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  Future<void> submitComplaintWithPhoto() async {
    try {
      print("⏳ Getting token...");
      final credentialsToken = await ApiService.getCredentialsToken();
      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getInt('user_id') ?? 0;

      final url = Uri.parse('https://serverx.in/api/add-complaint');

      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = credentialsToken.toString();
      request.headers['Accept'] = 'application/json';

      // Add fields
      request.fields['complain_category'] = '4'; // or make dynamic
      request.fields['vendor'] = selectedVandorName?.name ?? '';
      request.fields['remark'] = moreInfoController.text;
      request.fields['added_by'] = userID.toString();

      // Nested complaint_description fields
      request.fields['complaint_description[division]'] =
          selectedDivision?.name ?? '';
      request.fields['complaint_description[equipment_type]'] =
          selectedLineEquipmentType?.name ?? '';
      request.fields['complaint_description[location]'] =
          selectedLocation?.name ?? '';
      request.fields['complaint_description[equipment]'] =
          selectedEquipment?.name ?? '';
      request.fields['complaint_description[complaint]'] =
          selectedComplaint?.name ?? '';

      // Add photo if selected
      if (_pickedImage != null) {
        final file = File(_pickedImage!.path);
        final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
        final mimeParts = mimeType.split('/');

        request.files.add(await http.MultipartFile.fromPath(
          'complain_photo',
          file.path,
          filename: _pickedImage!.name,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        ));
      }

      print("📤 Sending complaint to API with image...");
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final responseData = jsonDecode(responseString);
        print("✅ API Response: $responseData \n\n\n\n\n");

        if (responseData['status'] == true) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SuccessPopupDialog(
              title: AppStrings.complaintCreated,
              description: AppStrings.complaintCreatedDescription,
              buttonText: AppStrings.okay,
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                print(
                    "Complaint submitted successfully! \n\n\n 👍👍👍👍👍😂😍😁🙌");
              },
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('❌ Failed: ${responseData['errors'] ?? 'Unknown error'}'),
            backgroundColor: Colors.redAccent,
          ));
        }
      } else {
        print("❌ Error response status: ${response.statusCode}");
        print("❌ Error response status: ${response}");
        print(
            "❌ Error response body: ${await response.stream.bytesToString()}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('❌ Complaint not submitted. Server error.'),
          backgroundColor: Colors.redAccent,
        ));
      }
    } catch (e) {
      print('❗ Error submitting complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('❗ Unexpected error occurred.'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  String? photoPath;
  //
  XFile? _pickedImage;
  String? _pickedImageName = null;
  final ImagePicker _picker = ImagePicker();
  //
  // final List<String> equipmentList = ['Transformer', 'Switch', 'Cable'];
  // final List<String> complaintList = ['Not Working', 'Sparking', 'Noise'];
  // final List<String> vendorList = ['Vendor A', 'Vendor B', 'Vendor C'];
  //
  Future<void> pickPhoto() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      final file = File(picked.path);

      // Compress image
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(dir.path, 'compressed_${picked.name}');

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70, // Reduce quality (you can fine-tune)
        format: CompressFormat.jpeg,
      );

      if (compressedFile != null) {
        setState(() {
          _pickedImage = XFile(compressedFile.path); // Use compressed image
          _pickedImageName = picked.name;
        });
        print("✅ Compressed image path: ${compressedFile.path}");
      } else {
        print("❌ Compression failed");
      }
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

                    // Line Equipment category Dropdown
                    if (complaintData.isNotEmpty)
                      CustomDropdownWidget(
                        lableText: 'Category',
                        hintText: 'Select Category',
                        items: complaintData.map((e) => e.name).toList(),
                        selectedItem: selectedCategory?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedCategory =
                                complaintData.firstWhere((e) => e.name == val);
                            selectedDivision = null;
                            selectedLocation = null;
                            selectedLineEquipmentType = null;
                            selectedEquipment = null;
                            selectedComplaint = null;
                            selectedVandorName = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),
                    // Division Dropdown

                    if (selectedCategory != null &&
                        selectedCategory!.children.isNotEmpty)
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
                            selectedLineEquipmentType = null;
                            selectedEquipment = null;
                            selectedComplaint = null;
                            selectedVandorName = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),
                    // Line Equipment Type Dropdown
                    if (selectedDivision != null &&
                        selectedDivision!.children.isNotEmpty)
                      CustomDropdownWidget(
                        lableText: 'Line Equipment Type',
                        hintText: 'Select Line Equipment Type',
                        items: selectedDivision!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedLineEquipmentType?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedLineEquipmentType = selectedDivision!
                                .children
                                .firstWhere((e) => e.name == val);
                            selectedLocation = null;
                            selectedEquipment = null;
                            selectedComplaint = null;
                            selectedVandorName = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),
                    // Location Dropdown
                    if (selectedLineEquipmentType != null &&
                        selectedLineEquipmentType!.children.isNotEmpty)
                      CustomDropdownWidget(
                        lableText: 'Location',
                        hintText: 'Select Location',
                        items: selectedLineEquipmentType!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedLocation?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedLocation = selectedLineEquipmentType!
                                .children
                                .firstWhere((e) => e.name == val);
                            selectedEquipment = null;
                            selectedComplaint = null;
                            selectedVandorName = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),
                    // Equipment Dropdown

                    if (selectedLocation != null &&
                        selectedLocation!.children.isNotEmpty)
                      CustomDropdownWidget(
                        lableText: 'Equipment',
                        hintText: 'Select Equipment',
                        items: selectedLocation!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedEquipment?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedEquipment = selectedLocation!.children
                                .firstWhere((e) => e.name == val);
                            selectedComplaint = null;
                            selectedVandorName = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),

                    // Complaint Dropdown
                    if (selectedEquipment != null &&
                        selectedEquipment!.children.isNotEmpty)
                      CustomDropdownWidget(
                        lableText: 'Complaint',
                        hintText: 'Select Complaint',
                        items: selectedEquipment!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedComplaint?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedComplaint = selectedEquipment!.children
                                .firstWhere((e) => e.name == val);
                            selectedVandorName = null;
                          });
                        },
                      ),
                    const SizedBox(height: 8),
                    // Vendor Name Dropdown
                    if (selectedComplaint != null &&
                        selectedComplaint!.children.isNotEmpty)
                      CustomDropdownWidget(
                        lableText: 'Vendor Name',
                        hintText: 'Select Vendor Name',
                        items: selectedComplaint!.children
                            .map((e) => e.name)
                            .toList(),
                        selectedItem: selectedVandorName?.name,
                        onChanged: (val) {
                          setState(() {
                            selectedVandorName = selectedComplaint!.children
                                .firstWhere((e) => e.name == val);
                          });
                        },
                      ),

                    // const SizedBox(height: 8),

                    // Complaint Type Dropdown

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
                      onTap: () {
                        pickPhoto();
                      },
                      child: DottedBorderContainer(
                        child: _pickedImageName != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: Text(
                                  'Selected: $_pickedImageName',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.upload,
                                      color: Color(0xFF1A73E8)),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Capture Photo',
                                    style: const TextStyle(
                                        color: Color(0xFF1A73E8), fontSize: 16),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    SizedBox(height: 20),
                    // Create Button
                    CostomPrimaryButton(
                      text: 'Create Complaint',
                      onPressed: () async {
                        // if (selectedCategory == null ||
                        //     selectedDivision == null ||
                        //     selectedLineEquipmentType == null ||
                        //     selectedLocation == null ||
                        //     selectedEquipment == null ||
                        //     selectedComplaint == null ||
                        //     selectedVandorName == null) {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text(
                        //         'Please select all fields before submitting.'),
                        //     backgroundColor: Colors.orange,
                        //   ));
                        //   return;
                        // }
                        // Handle complaint creation logic here
                        print(
                            "\n \n Creating Complaint with data: -------->  ");
                        print('✅ Complaint Created');
                        print('Category: ---> ${selectedCategory?.name}');
                        print('Division: ---> ${selectedDivision?.name}');
                        print(
                            'Line Equipment Type: ---> ${selectedLineEquipmentType?.name}');
                        print('Location: ---> ${selectedLocation?.name}');
                        print('Equipment: ---> ${selectedEquipment?.name}');
                        print('Complaint: ---> ${selectedComplaint?.name}');
                        print('Vendor Name: ---> ${selectedVandorName?.name}');
                        print('More Info: ---> ${moreInfoController.text}');
                        print(
                            'Photo Path: ---> ${_pickedImage?.path ?? "No photo selected"}');
                        print('Complaint Created -----------> \n\n\n');

                        if (_pickedImage != null) {
                          await submitComplaintWithPhoto();
                        } else {
                          await submitComplaint(); // fallback
                        }
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
