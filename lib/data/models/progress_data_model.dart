import 'package:hive/hive.dart';

part 'progress_data_model.g.dart';

@HiveType(typeId: 3)
class ProgressDataModel {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String type; // Either 'affirmation' or 'gratitude'

  ProgressDataModel({
    required this.date,
    required this.content,
    required this.type,
  });
}
