// Model
class ComplaintNode {
  final int id;
  final String name;
  final List<ComplaintNode> children;

  ComplaintNode({required this.id, required this.name, required this.children});

  factory ComplaintNode.fromJson(Map<String, dynamic> json) {
    return ComplaintNode(
      id: json['id'],
      name: json['name'],
      children: (json['children'] as List?)
              ?.map((e) => ComplaintNode.fromJson(e))
              .toList() ??
          [],
    );
  }
}



// models/complaint_type_model.dart
class ComplaintType {
  final String cType;
  final String ctId;

  ComplaintType({required this.cType, required this.ctId});

  factory ComplaintType.fromJson(Map<String, dynamic> json) {
    return ComplaintType(
      cType: json['c_type'],
      ctId: json['ct_id'],
    );
  }
}

// models/vendor_model.dart
class VendorModel {
  final int vendorId;
  final String vName;

  VendorModel({required this.vendorId, required this.vName});

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      vendorId: json['vendor_id'],
      vName: json['v_name'],
    );
  }
}
