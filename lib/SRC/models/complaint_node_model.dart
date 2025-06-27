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
      children: (json['children'] as List?)?.map((e) => ComplaintNode.fromJson(e)).toList() ?? [],
    );
  }
}