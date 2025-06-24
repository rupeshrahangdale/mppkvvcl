import 'package:flutter/material.dart';
import '../constent/app_constant.dart';
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

void showResolvedBottomDrawer(BuildContext context) {
  final TextEditingController _controllerResolveNote = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
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
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            const Text(
              'Resolve Complaint',
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: 20),

            CostomInputField(
              label: "Resolution Notes",
              hintText: "Enter resolution notes here",
              controller: _controllerResolveNote,
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Capture Image button
            GestureDetector(
              onTap: () {
                // TODO: trigger file picker
              },
              child: DottedBorderContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.upload, color: Color(0xFF1A73E8)), // Blue icon
                    SizedBox(width: 8),
                    Text(
                      'Capture Photo',
                      style: TextStyle(
                        color: Color(0xFF1A73E8), // Blue text
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Submit Button
            CostomPrimaryButton(
                text: "Mark as Resolve",
                onPressed: () {
                  if (_controllerResolveNote.text.isNotEmpty) {
                    // Handle the resolve actio
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Complaint marked as resolved"),
                      ),
                    );
                    SuccessPopupDialog(
                      title: "Complaint Resolved",
                      description: "Complaint has been marked as resolved.",
                      buttonText: "Okay",
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter resolution notes"),
                      ),
                    );
                  }
                }),

            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

//========================================================

void showTransferBottomDrawer({
  required BuildContext context,
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

                // Title
                const Text(
                  'Transfer Complaint',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Custom dropdown
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

                const SizedBox(height: 70),

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
                        onTransfer(selectedValue!);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a department"),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Transfer',
                      style: TextStyle(
                        color: AppColors.textBlack,
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
