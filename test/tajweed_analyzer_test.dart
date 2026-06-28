import 'package:flutter_test/flutter_test.dart';
import 'package:tajweed_master_pro/services/tajweed_analyzer.dart';

void main() {
  test('detects iqlab across two words', () {
    final segments = TajweedAnalyzer.analyze('مِنْ بَعْدِ');
    expect(segments.any((s) => s.rule.id == 'iqlab'), true);
  });

  test('detects ghunnah on shaddah', () {
    final segments = TajweedAnalyzer.analyze('إِنَّ');
    expect(segments.any((s) => s.rule.id == 'ghunnah'), true);
  });
}
