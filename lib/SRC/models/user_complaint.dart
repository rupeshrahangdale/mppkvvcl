// models/user_complaint_model.dart
class UserComplaint {
  final int id;
  final String division;
  final String equipmentType;
  final String location;
  final String equipment;
  final String complaintCategory;
  final String vendor;
  final String createdAt;
  final String status; // Assuming you might want to add status later

  UserComplaint({
    required this.id,
    required this.division,
    required this.equipmentType,
    required this.location,
    required this.equipment,
    required this.complaintCategory,
    required this.vendor,
    required this.createdAt,
    required this.status,
  });

  factory UserComplaint.fromJson(Map<String, dynamic> json) {
    final desc = json['complaint_description'] ?? {};
    return UserComplaint(
      id: json['complain_id'] ?? 0,
      division: desc['division'] ?? '',
      equipmentType: desc['equipment_type'] ?? '',
      location: desc['location'] ?? '',
      equipment: desc['equipment'] ?? '',
      complaintCategory: json['complain_category_name'] ?? 'not found',
      vendor: json['vendor'] ?? '',
      createdAt: json['created_at'] ?? '',
      status: json['status_label'] ?? '', // Assuming status is a string
    );
  }
}
