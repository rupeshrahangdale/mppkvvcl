import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppkvvcl/SRC/constent/app_constant.dart';

Widget buildPermissionCard(
    IconData icon, Color iconColor, String title, String description) {
  return Container(
    margin: const EdgeInsets.symmetric(
      vertical: AppDimensions.defaultMargin,
    ),
    padding: const EdgeInsets.all(AppDimensions.defaultPaddingVertical),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
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
  required String complaintCategory,
  required String division,
  required String vander,
  required String status,
  required String createdAt,
}) {
  Color statusColor;
  switch (status.toLowerCase()) {
    case 'transferred':
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
              complaintCategory,
              style: AppTextStyles.subtitle,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
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
        Text(
          'Complaint No. : #$id',
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          "$division",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          "$vander",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          "$createdAt",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

//====================================================================

Widget buildStatCard(String value, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      border: Border.all(color: Colors.black26),
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
        Text(value, style: AppTextStyles.subHeading),
        const SizedBox(height: 3),
        Text(label, style: AppTextStyles.caption),
      ],
    ),
  );
}

//====================================================================

Widget buildActionCard({
  required String title,
  required Image image,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: AppMediaQuery.screenHeight * 0.2,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.defaultPaddingVertical,
        horizontal: AppDimensions.defaultPaddingHorizontal,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.subtitle.copyWith(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

// ==================================================================

Widget buildPendingComplaintCard({
  required String id,
  required String complaintCategory,
  required String date,
  required String division,
  required String status,
  required String vander,
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
              complaintCategory,
              style: AppTextStyles.subtitle,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
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
          'Complaint No. : #$id',
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          "$division",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
        Text(
          "$vander",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          "$date",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// ==================================================================

class ComplaintCategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const ComplaintCategoryCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 12),
          Text(title,
              style: AppTextStyles.subtitle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}
