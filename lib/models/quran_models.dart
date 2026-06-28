class QuranSurah {
  const QuranSurah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.revelation,
    required this.ayahCount,
    required this.hasBasmalahHeader,
    required this.ayahs,
  });

  final int number;
  final String name;
  final String englishName;
  final String revelation;
  final int ayahCount;
  final bool hasBasmalahHeader;
  final List<QuranAyah> ayahs;

  factory QuranSurah.fromJson(Map<String, dynamic> json) => QuranSurah(
        number: json['number'] as int,
        name: json['name'] as String,
        englishName: json['englishName'] as String,
        revelation: json['revelation'] as String,
        ayahCount: json['ayahCount'] as int,
        hasBasmalahHeader: json['hasBasmalahHeader'] as bool? ?? true,
        ayahs: (json['ayahs'] as List<dynamic>)
            .map((item) => QuranAyah.fromJson(item as Map<String, dynamic>))
            .toList(growable: false),
      );
}

class QuranAyah {
  const QuranAyah({required this.number, required this.text});
  final int number;
  final String text;

  factory QuranAyah.fromJson(Map<String, dynamic> json) => QuranAyah(
        number: json['number'] as int,
        text: json['text'] as String,
      );
}
