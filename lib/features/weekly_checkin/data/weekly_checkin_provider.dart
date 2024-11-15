import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyCheckInProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveWeeklyCheckIn(Map<String, dynamic> data) async {
    await _firestore.collection('weekly_checkins').add(data);
  }
}
