class CloudLesson {
  const CloudLesson({required this.id, required this.title, required this.body, this.locale = 'ar', this.updatedAt});
  final String id;
  final String title;
  final String body;
  final String locale;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'body': body,
    'locale': locale,
    'updatedAt': updatedAt?.toIso8601String(),
  };
}

class CloudQuestion {
  const CloudQuestion({required this.id, required this.prompt, required this.options, required this.answerIndex, required this.explanation, this.ruleId, this.level = 1});
  final String id;
  final String prompt;
  final List<String> options;
  final int answerIndex;
  final String explanation;
  final String? ruleId;
  final int level;
}

class UserStats {
  const UserStats({this.pagesRead = 0, this.streakDays = 0, this.points = 0, this.level = 1, this.bestScore = 0});
  final int pagesRead;
  final int streakDays;
  final int points;
  final int level;
  final int bestScore;
}

class CertificateRecord {
  const CertificateRecord({required this.id, required this.userId, required this.stageName, required this.score, required this.issuedAt, required this.verifyCode});
  final String id;
  final String userId;
  final String stageName;
  final int score;
  final DateTime issuedAt;
  final String verifyCode;
}

class RecitationAnalysisResult {
  const RecitationAnalysisResult({required this.accuracy, required this.notes, required this.mistakes});
  final double accuracy;
  final List<String> notes;
  final List<String> mistakes;
}
