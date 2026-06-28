import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/quran_models.dart';

class QuranRepository {
  Future<List<QuranSurah>> load() async {
    final raw = await rootBundle.loadString('assets/data/quran_uthmani.json');
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((item) => QuranSurah.fromJson(item as Map<String, dynamic>)).toList(growable: false);
  }
}
