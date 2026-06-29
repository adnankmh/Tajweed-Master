class GamificationEngine {
  int pointsForExam(int score) {
    if (score >= 95) return 120;
    if (score >= 85) return 90;
    if (score >= 70) return 60;
    return 25;
  }

  int levelFromPoints(int points) => 1 + (points ~/ 500);

  List<String> badges({required int pagesRead, required int streakDays, required int bestScore}) {
    final items = <String>[];
    if (pagesRead >= 10) items.add('قارئ منتظم');
    if (streakDays >= 7) items.add('سلسلة أسبوعية');
    if (bestScore >= 90) items.add('متقن الأحكام');
    return items;
  }
}
