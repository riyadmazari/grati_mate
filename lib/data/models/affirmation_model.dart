import 'package:hive/hive.dart';

part 'affirmation_model.g.dart';

@HiveType(typeId: 0)
class AffirmationModel extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final DateTime date;

  AffirmationModel({
    required this.text,
    required this.date,
  });
}
