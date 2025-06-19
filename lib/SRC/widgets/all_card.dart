


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';

Widget buildPermissionCard(
    IconData icon, Color iconColor, String title, String description) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical:AppDimensions.defaultMargin, ),
    padding: const EdgeInsets.all(AppDimensions.defaultPadding),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: iconColor, size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(description,
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}



//====================================================================


class CategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const CategoryCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 80,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}



//====================================================================


Widget buildComplaintCard({
  required String id,
  required String title,
  required String date,
  required String location,
  required String status,
}) {
  Color statusColor;
  switch (status.toLowerCase()) {
    case 'open':
      statusColor = Colors.blue;
      break;
    case 'resolved':
      statusColor = Colors.green;
      break;
    default:
      statusColor = Colors.orange;
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.subtitle,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: AppTextStyles.caption.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'ID: #$id',
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              date,
              style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on_outlined,
                size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              location,
              style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}



//====================================================================



Widget buildStatCard(String value, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: AppDimensions.defaultPaddingVertical, horizontal: AppDimensions.defaultPaddingHorizontal),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.heading.copyWith(
            color: AppColors.primaryBlue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}