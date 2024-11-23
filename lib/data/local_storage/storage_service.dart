import 'package:hive/hive.dart';
import '../models/affirmation_model.dart';

class StorageService {
  static const _boxName = 'affirmationBox';

  Future<Box<AffirmationModel>> _openBox() async {
    return await Hive.openBox<AffirmationModel>(_boxName);
  }

  Future<void> addAffirmation(AffirmationModel affirmation) async {
    final box = await _openBox();
    await box.add(affirmation);
  }

  Future<List<AffirmationModel>> getAffirmations() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> clearAll() async {
    final box = await _openBox();
    await box.clear();
  }
}
