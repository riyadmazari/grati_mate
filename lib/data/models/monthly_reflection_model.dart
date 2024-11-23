import 'package:hive/hive.dart';

part 'monthly_reflection_model.g.dart'; // Ensure this line is correct and the file is saved.

@HiveType(typeId: 2) // Ensure the typeId is unique across all your models.
class MonthlyReflectionModel {
  @HiveField(0)
  final String wins;

  @HiveField(1)
  final String improvements;

  @HiveField(2)
  final String inspiration;

  @HiveField(3)
  final DateTime date;

  MonthlyReflectionModel({
    required this.wins,
    required this.improvements,
    required this.inspiration,
    required this.date,
  });
}
