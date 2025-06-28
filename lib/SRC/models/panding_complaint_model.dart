class PendingComplaintModel {
  final int id;
  final String complaintCetegory;
  final String division;
  final String date;
  final String vender;
  final String status;

  PendingComplaintModel({
    required this.id,
    required this.complaintCetegory,
    required this.division,
    required this.date,
    required this.vender,
    required this.status,
  });

  factory PendingComplaintModel.fromJson(Map<String, dynamic> json) {
    final complaintDesc = json['complaint_description'] ?? {};
    return PendingComplaintModel(
      id: json['complain_id'],
      complaintCetegory: json['complain_category_name'] ?? '',
      division: complaintDesc['division'] ?? '',
      date: json['created_at'] ?? '',
      vender: json['vendor'] ?? '',
      status: json['status_label'] ?? 'Pending',
    );
  }
}
