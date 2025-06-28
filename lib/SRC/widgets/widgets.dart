import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constent/app_constant.dart';
import '../services/api_services.dart';
import 'input_field.dart';
import 'costom_button.dart';

/// A reusable bottom drawer with one text field and one button.
Future<T?> showSingleInputBottomDrawer<T>({
  required BuildContext context,
  required String title,
  required String label,
  required String hintText,
  required String buttonText,
  required TextEditingController controller,
  required VoidCallback onButtonPressed,
  bool obscureText = false,
  String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
  required Function(String value) onSubmit,
  required bool isLoading,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadius)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: AppDimensions.defaultPadding,
          right: AppDimensions.defaultPadding,
          bottom: MediaQuery.of(context).viewInsets.bottom +
              AppDimensions.defaultPadding,
          top: AppDimensions.defaultPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              title,
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: 16),
            CostomInputField(
              label: label,
              hintText: hintText,
              controller: controller,
              obscureText: obscureText,
              validator: validator,
              keyboardType: keyboardType,
            ),
            const SizedBox(height: 24),
            CostomPrimaryButton(
              text: buttonText,
              onPressed: onButtonPressed,
            ),
          ],
        ),
      );
    },
  );
}

//  =====================================================

class ComplaintProfile extends StatelessWidget {
  final String title;
  final String? location;
  final IconData icon;
  final Color? textColor;

  const ComplaintProfile({
    super.key,
    required this.title,
    required this.icon,
    this.location,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.black,
                fontSize: 15,
              ),
            ),
            if (location != null)
              Text(
                location!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

// =======================================================

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

// =======================================================

class SuccessPopupDialog extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;

  const SuccessPopupDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✔️ Circle check icon
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00C400),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),

            // 📝 Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // 💬 Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // 🔘 Button
            CostomPrimaryButtonBorder(text: buttonText, onPressed: onTap)
          ],
        ),
      ),
    );
  }
}

// =======================================================
//
// void showResolvedBottomDrawer(BuildContext context) {
//   final TextEditingController _controllerResolveNote = TextEditingController();
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           top: 24,
//           left: 20,
//           right: 20,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Drag handle
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade400,
//                 borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Title
//             const Text(
//               'Resolve Complaint',
//               style: AppTextStyles.heading,
//             ),
//             const SizedBox(height: 20),
//
//             CostomInputField(
//               label: "Resolution Notes",
//               hintText: "Enter resolution notes here",
//               controller: _controllerResolveNote,
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//
//             // Capture Image button
//             GestureDetector(
//               onTap: () {
//                 pickPhoto();
//               },
//               child: DottedBorderContainer(
//                 child: _pickedImageName != null
//                     ? Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 18.0),
//                   child: Text(
//                     'Selected: $_pickedImageName',
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 13, color: Colors.black54),
//                   ),
//                 )
//                     : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.upload,
//                         color: Color(0xFF1A73E8)),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Capture Photo',
//                       style: const TextStyle(
//                           color: Color(0xFF1A73E8), fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Submit Button
//             CostomPrimaryButton(
//                 text: "Mark as Resolve",
//                 onPressed: () {
//                   if (_controllerResolveNote.text.isNotEmpty) {
//                     // Handle the resolve actio
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Complaint marked as resolved"),
//                       ),
//                     );
//                     SuccessPopupDialog(
//                       title: "Complaint Resolved",
//                       description: "Complaint has been marked as resolved.",
//                       buttonText: "Okay",
//                       onTap: () {
//                         Navigator.pop(context); // Close the bottom sheet
//                       },
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Please enter resolution notes"),
//                       ),
//                     );
//                   }
//                 }),
//
//             const SizedBox(height: 20),
//           ],
//         ),
//       );
//     },
//   );
// }

void showResolvedBottomDrawer(BuildContext context, int complaintId) {
  final TextEditingController _controllerResolveNote = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  String? _pickedImageName;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickAndCompressPhoto() async {
            final picked = await _picker.pickImage(source: ImageSource.camera);
            if (picked != null) {
              final file = File(picked.path);

              final dir = await getTemporaryDirectory();
              final targetPath =
                  path.join(dir.path, 'compressed_${picked.name}');

              final compressedFile =
                  await FlutterImageCompress.compressAndGetFile(
                file.absolute.path,
                targetPath,
                quality: 70,
                format: CompressFormat.jpeg,
              );

              if (compressedFile != null) {
                setState(() {
                  _pickedImage = XFile(compressedFile.path);
                  _pickedImageName = picked.name;
                });
              } else {
                print("❌ Compression failed");
              }
            }
          }

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Resolve Complaint',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CostomInputField(
                  label: "Resolution Notes",
                  hintText: "Enter resolution notes here",
                  controller: _controllerResolveNote,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Resolution Photo', style: AppTextStyles.caption),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: pickAndCompressPhoto,
                  child: DottedBorderContainer(
                    child: _pickedImageName != null
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
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
                            children: const [
                              Icon(Icons.upload, color: Color(0xFF1A73E8)),
                              SizedBox(width: 8),
                              Text(
                                'Capture Photo',
                                style: TextStyle(
                                  color: Color(0xFF1A73E8),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                CostomPrimaryButton(
                  text: "Mark as Resolve",
                  onPressed: () async {
                    if (_controllerResolveNote.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter resolution notes")),
                      );
                      return;
                    }

                    if (_pickedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please capture a photo")),
                      );
                      return;
                    }

                    // Submit to API
                    final prefs = await SharedPreferences.getInstance();
                    final token = await ApiService.getCredentialsToken();
                    final userId = prefs.getInt('user_id') ?? 2;

                    var request = http.MultipartRequest(
                      'POST',
                      Uri.parse(
                          'https://serverx.in/api/update-complaint/$complaintId'),
                    );
                    request.fields['resolved_by'] = userId.toString();
                    request.fields['resolved_remark'] =
                        _controllerResolveNote.text;
                    request.files.add(await http.MultipartFile.fromPath(
                      'resolved_photo',
                      _pickedImage!.path,
                    ));
                    request.headers['Authorization'] = token.toString();
                    request.headers['Accept'] = 'application/json';

                    final response = await request.send();
                    final responseBody = await response.stream.bytesToString();
                    final result = jsonDecode(responseBody);

                    if (result['status'] == true) {
                      print(
                          "✅ Complaint resolved successfully 👍👍👍👍👍👍👍👍👍👍👍👍👍");
                      print(result);

                      // Navigator.pop(context); // close drawer
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => SuccessPopupDialog(
                                title: "Complaint Resolved",
                                description: result['message'] ??
                                    "Complaint has been marked please check your complaint ,Yor complain id is ${result["data"]["complain_id"]}.",
                                buttonText: "Okay",
                                onTap: () {
                                  Navigator.pop(context);
                                  // go back
                                },
                              ));

                      print(
                          "✅ Complaint resolved successfully and SuccessPopupDialog is shown ");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result['message'] ?? 'Failed')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}

//========================================================

void showTransferBottomDrawer({
  required BuildContext context,
  required int complaintId,
  required List<String> dropdownItems,
  required void Function(String selectedValue) onTransfer,
}) {
  String? selectedValue;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> transferComplaint() async {
            final credentialsToken = await ApiService.getCredentialsToken();

            final uri = Uri.parse(
                "https://serverx.in/api/transfer-complaint/$complaintId");

            var request = http.MultipartRequest("POST", uri);
            request.headers['Authorization'] = credentialsToken.toString();
            request.fields['transfer_to'] = selectedValue!;

            try {
              final response = await request.send();
              final responseData = await response.stream.bytesToString();

              if (response.statusCode == 200) {
                final decoded = json.decode(responseData);
                String message =
                    decoded['message'] ?? "Complaint transferred successfully";
                print("Success: $responseData");
                onTransfer(selectedValue!);
                Navigator.pop(context);

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => SuccessPopupDialog(
                    title: "Complaint Transferred",
                    description: message, // ✅ using API response here
                    buttonText: "Okay",
                    onTap: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // close bottom sheet
                      print("Complaint transferred successfully ✅");
                    },
                  ),
                );
              } else {
                print("Error: $responseData");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Transfer failed: $responseData")),
                );
              }
            } catch (e) {
              print("Exception: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error during transfer")),
              );
            }
          }

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Transfer Complaint',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Department Dropdown
                CustomDropdownWidget(
                  items: dropdownItems,
                  selectedItem: selectedValue,
                  hintText: "Select Department",
                  lableText: "Department",
                  onChanged: (val) {
                    setState(() {
                      selectedValue = val;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Transfer Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (selectedValue != null && selectedValue!.isNotEmpty) {
                        transferComplaint();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please select a department")),
                        );
                      }
                    },
                    child: const Text(
                      'Transfer',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}
