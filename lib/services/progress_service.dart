import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  Future<Set<int>> completedDays() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList('completed_days') ?? []).map(int.parse).toSet();
  }

  Future<void> markDayComplete(int day) async {
    final prefs = await SharedPreferences.getInstance();
    final current = (prefs.getStringList('completed_days') ?? []).toSet();
    current.add(day.toString());
    await prefs.setStringList('completed_days', current.toList()..sort());
  }

  Future<void> saveExamScore(String examId, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final old = prefs.getInt('exam_score_$examId') ?? 0;
    if (score > old) await prefs.setInt('exam_score_$examId', score);
  }

  Future<int> bestExamScore(String examId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('exam_score_$examId') ?? 0;
  }
}
