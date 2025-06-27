
class PendingComplaintModel {
  final int id;
  final String title;
  final String location;
  final String date;
  final String description;
  final int status ;

  PendingComplaintModel({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
     required this.status,
  });

  factory PendingComplaintModel.fromJson(Map<String, dynamic> json) {
    final complaintDesc = json['complaint_description'] ?? {};
    return PendingComplaintModel(
      id: json['complain_id'],
      title: complaintDesc['complaint'] ?? '',
      location: complaintDesc['location'] ?? '',
      date: json['created_at'] ?? '',
      description: complaintDesc['equipment'] ?? '',
      status: json['status'] ?? 'Pending',
    );
  }
}