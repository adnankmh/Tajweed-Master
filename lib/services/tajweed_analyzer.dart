import '../data/tajweed_content.dart';
import '../models/content_models.dart';

class TajweedAnalyzer {
  static final _throat = {'ء', 'أ', 'إ', 'ؤ', 'ئ', 'ا', 'ه', 'ع', 'ح', 'غ', 'خ'};
  static final _idghamGhunnah = {'ي', 'ن', 'م', 'و'};
  static final _idghamNoGhunnah = {'ل', 'ر'};
  static final _ikhfa = {'ت', 'ث', 'ج', 'د', 'ذ', 'ز', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ف', 'ق', 'ك'};
  static final _qalqalah = {'ق', 'ط', 'ب', 'ج', 'د'};
  static final _heavyRaaVowels = {'َ', 'ُ'};
  static final _lightRaaVowels = {'ِ'};

  static bool _isMark(String ch) {
    if (ch.isEmpty) return false;
    final c = ch.codeUnitAt(0);
    return c >= 0x064B && c <= 0x065F || c == 0x0670 || c == 0x06E1 || c == 0x06E2 || c == 0x06ED;
  }

  static bool _isTanween(String ch) => ch == 'ً' || ch == 'ٌ' || ch == 'ٍ';
  static bool _isSukun(String ch) => ch == 'ْ' || ch == 'ۡ';
  static bool _isShadda(String ch) => ch == 'ّ';
  static bool _isArabicLetter(String ch) => RegExp(r'[ء-يٱآأإؤئ]').hasMatch(ch);

  static int _clusterStart(String text, int index) {
    var i = index;
    while (i > 0 && _isMark(text[i])) i--;
    return i;
  }

  static int _clusterEnd(String text, int index) {
    var i = index + 1;
    while (i < text.length && _isMark(text[i])) i++;
    return i;
  }

  static int? _nextLetterIndex(String text, int after) {
    for (var i = after; i < text.length; i++) {
      final ch = text[i];
      if (_isArabicLetter(ch)) return i;
    }
    return null;
  }

  static int? _previousLetterIndex(String text, int before) {
    for (var i = before; i >= 0; i--) {
      final ch = text[i];
      if (_isArabicLetter(ch)) return i;
    }
    return null;
  }

  static bool _clusterHas(String text, int letterIndex, bool Function(String ch) test) {
    for (var i = letterIndex + 1; i < text.length && _isMark(text[i]); i++) {
      if (test(text[i])) return true;
    }
    return false;
  }

  static bool _previousClusterHas(String text, int before, bool Function(String ch) test) {
    final p = _previousLetterIndex(text, before);
    if (p == null) return false;
    return _clusterHas(text, p, test);
  }

  static void _add(List<HighlightSegment> list, int start, int end, String ruleId) {
    if (start >= end) return;
    final rule = ruleById(ruleId);
    // Avoid exact duplicates. Keep the first higher-level match.
    if (list.any((s) => s.start == start && s.end == end && s.rule.id == ruleId)) return;
    list.add(HighlightSegment(start: start, end: end, rule: rule));
  }

  static List<HighlightSegment> analyze(String text) {
    final segments = <HighlightSegment>[];

    for (var i = 0; i < text.length; i++) {
      final ch = text[i];
      if (!_isArabicLetter(ch) && !_isTanween(ch)) continue;

      // Tanween: mark carrier cluster + spaces + following letter cluster.
      if (_isTanween(ch)) {
        final carrier = _previousLetterIndex(text, i - 1) ?? i;
        final next = _nextLetterIndex(text, i + 1);
        if (next != null) {
          final nextCh = text[next];
          final start = _clusterStart(text, carrier);
          final end = _clusterEnd(text, next);
          if (_throat.contains(nextCh)) _add(segments, start, end, 'izhar');
          else if (_idghamGhunnah.contains(nextCh)) _add(segments, start, end, 'idgham_ghunnah');
          else if (_idghamNoGhunnah.contains(nextCh)) _add(segments, start, end, 'idgham_no_ghunnah');
          else if (nextCh == 'ب') _add(segments, start, end, 'iqlab');
          else if (_ikhfa.contains(nextCh)) _add(segments, start, end, 'ikhfa');
        }
      }

      if (ch == 'ن' && _clusterHas(text, i, _isSukun)) {
        final next = _nextLetterIndex(text, _clusterEnd(text, i));
        if (next != null) {
          final nextCh = text[next];
          final start = i;
          final end = _clusterEnd(text, next);
          if (_throat.contains(nextCh)) _add(segments, start, end, 'izhar');
          else if (_idghamGhunnah.contains(nextCh)) _add(segments, start, end, 'idgham_ghunnah');
          else if (_idghamNoGhunnah.contains(nextCh)) _add(segments, start, end, 'idgham_no_ghunnah');
          else if (nextCh == 'ب') _add(segments, start, end, 'iqlab');
          else if (_ikhfa.contains(nextCh)) _add(segments, start, end, 'ikhfa');
        }
      }

      if (ch == 'م' && _clusterHas(text, i, _isSukun)) {
        final next = _nextLetterIndex(text, _clusterEnd(text, i));
        if (next != null) {
          final nextCh = text[next];
          final end = _clusterEnd(text, next);
          if (nextCh == 'ب') _add(segments, i, end, 'meem_ikhfa');
          else if (nextCh == 'م') _add(segments, i, end, 'meem_idgham');
        }
      }

      if ((ch == 'ن' || ch == 'م') && _clusterHas(text, i, _isShadda)) {
        _add(segments, i, _clusterEnd(text, i), 'ghunnah');
      }

      // Natural madd approximations: madd letter with suitable previous vowel.
      if ((ch == 'ا' || ch == 'ٱ' || ch == 'ى' || ch == 'ـ') && _previousClusterHas(text, i - 1, (m) => m == 'َ' || m == 'ٰ')) {
        _add(segments, i, _clusterEnd(text, i), 'madd');
      }
      if (ch == 'و' && _previousClusterHas(text, i - 1, (m) => m == 'ُ')) {
        _add(segments, i, _clusterEnd(text, i), 'madd');
      }
      if (ch == 'ي' && _previousClusterHas(text, i - 1, (m) => m == 'ِ')) {
        _add(segments, i, _clusterEnd(text, i), 'madd');
      }

      if (_qalqalah.contains(ch) && _clusterHas(text, i, _isSukun)) {
        _add(segments, i, _clusterEnd(text, i), 'qalqalah');
      }

      if (ch == 'ر') {
        if (_clusterHas(text, i, (m) => _heavyRaaVowels.contains(m)) || _clusterHas(text, i, (m) => _lightRaaVowels.contains(m))) {
          _add(segments, i, _clusterEnd(text, i), 'raa');
        }
      }
    }

    // Lam of Allah: mark the lams in forms of Allah.
    final allah = RegExp(r'(ٱللَّه|اللَّه|للَّه|باللَّه|واللَّه)');
    for (final match in allah.allMatches(text)) {
      _add(segments, match.start, match.end, 'lam_jalalah');
    }

    segments.sort((a, b) {
      final c = a.start.compareTo(b.start);
      if (c != 0) return c;
      return b.end.compareTo(a.end);
    });
    return _mergeCompatible(segments);
  }

  static List<HighlightSegment> _mergeCompatible(List<HighlightSegment> items) {
    final result = <HighlightSegment>[];
    for (final s in items) {
      if (result.isNotEmpty) {
        final last = result.last;
        if (last.rule.id == s.rule.id && s.start <= last.end + 1) {
          result[result.length - 1] = HighlightSegment(start: last.start, end: s.end > last.end ? s.end : last.end, rule: last.rule);
          continue;
        }
        if (s.start < last.end) continue;
      }
      result.add(s);
    }
    return result;
  }
}
