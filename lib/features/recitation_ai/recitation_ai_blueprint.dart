import '../../core/models/cloud_models.dart';

class RecitationAiBlueprint {
  Future<RecitationAnalysisResult> analyzeLocalPlaceholder(String audioFilePathOrUrl) async {
    return const RecitationAnalysisResult(
      accuracy: 0.0,
      notes: [
        'تم تجهيز مسار التحليل. يحتاج التفعيل الحقيقي إلى Cloud Function أو خادم AI يستقبل ملف الصوت ويرجع أماكن الأخطاء.',
      ],
      mistakes: [],
    );
  }
}
