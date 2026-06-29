import '../models/cloud_models.dart';

abstract class CloudContentRepository {
  Future<List<CloudLesson>> loadLessons({String locale = 'ar'});
  Future<List<CloudQuestion>> loadQuestions({String? examId});
  Future<void> saveUserStats(String userId, UserStats stats);
  Future<UserStats> loadUserStats(String userId);
  Future<CertificateRecord> issueCertificate({required String userId, required String stageName, required int score});
}

/// V13 local fallback used until Firebase credentials are added.
class LocalCloudContentRepository implements CloudContentRepository {
  @override
  Future<List<CloudLesson>> loadLessons({String locale = 'ar'}) async => const [
    CloudLesson(
      id: 'tajweed_foundation',
      title: 'مدخل احترافي لعلم التجويد',
      body: 'هذا المحتوى يعمل محليًا الآن، وبعد ربط Firebase يمكن تعديله من لوحة الإدارة دون إصدار نسخة جديدة.',
    ),
  ];

  @override
  Future<List<CloudQuestion>> loadQuestions({String? examId}) async => const [
    CloudQuestion(
      id: 'q1',
      prompt: 'ما المقصود بالغنة؟',
      options: ['صوت يخرج من الخيشوم', 'مد طبيعي', 'إمالة', 'وقف اختباري'],
      answerIndex: 0,
      explanation: 'الغنة صوت رخيم يخرج من الخيشوم ويظهر في أحكام النون والميم المشددتين وبعض أحكام النون والميم الساكنتين.',
      ruleId: 'ghunnah',
      level: 1,
    ),
  ];

  @override
  Future<UserStats> loadUserStats(String userId) async => const UserStats(points: 20, level: 1, pagesRead: 3, streakDays: 1, bestScore: 80);

  @override
  Future<void> saveUserStats(String userId, UserStats stats) async {}

  @override
  Future<CertificateRecord> issueCertificate({required String userId, required String stageName, required int score}) async {
    final id = 'CERT-${DateTime.now().millisecondsSinceEpoch}';
    return CertificateRecord(id: id, userId: userId, stageName: stageName, score: score, issuedAt: DateTime.now(), verifyCode: id);
  }
}
