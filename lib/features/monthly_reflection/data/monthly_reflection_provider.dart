import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyReflectionProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveMonthlyReflection(Map<String, dynamic> data) async {
    await _firestore.collection('monthly_reflections').add(data);
  }
}
