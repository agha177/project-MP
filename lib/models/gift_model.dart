import 'package:cloud_firestore/cloud_firestore.dart';

class Gift {
  final String id;
  final String name;
  final String category;
  final String status;

  Gift(
      {required this.id,
      required this.name,
      required this.category,
      required this.status});

  factory Gift.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Gift(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      status: data['status'] ?? 'Available',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'status': status,
    };
  }
}
