import 'package:hive/hive.dart';

part 'inspiration_model.g.dart';

@HiveType(typeId: 4) // Ensure this typeId is unique across all models
class InspirationModel extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final DateTime date;

  InspirationModel({required this.text, required this.date});
}
