import 'package:hive/hive.dart';

part 'prompt_model.g.dart';

@HiveType(typeId: 2) // Ensure a unique typeId
class PromptModel extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final bool isPinned;

  @HiveField(2)
  final DateTime date; // Added the date property

  PromptModel({
    required this.text,
    required this.isPinned,
    required this.date,
  });
}
