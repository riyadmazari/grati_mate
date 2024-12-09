import 'package:hive/hive.dart';

part 'weekly_data_model.g.dart';

@HiveType(typeId: 1)
class WeeklyDataModel {
  @HiveField(0)
  final String focus;

  @HiveField(1)
  final String reflection;

  @HiveField(2)
  final String favorite;

  @HiveField(3)
  final DateTime date;

  WeeklyDataModel({
    required this.focus,
    required this.reflection,
    required this.favorite,
    required this.date,
  });
}
