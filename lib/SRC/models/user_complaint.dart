// models/user_complaint_model.dart
class UserComplaint {
  final int id;
  final String division;
  final String equipmentType;
  final String location;
  final String equipment;
  final String complaint;
  final String vendor;
  final String createdAt;

  UserComplaint({
    required this.id,
    required this.division,
    required this.equipmentType,
    required this.location,
    required this.equipment,
    required this.complaint,
    required this.vendor,
    required this.createdAt,
  });

  factory UserComplaint.fromJson(Map<String, dynamic> json) {
    final desc = json['complaint_description'] ?? {};
    return UserComplaint(
      id: json['complain_id'] ?? 0,
      division: desc['division'] ?? '',
      equipmentType: desc['equipment_type'] ?? '',
      location: desc['location'] ?? '',
      equipment: desc['equipment'] ?? '',
      complaint: desc['complaint'] ?? '',
      vendor: json['vendor'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
