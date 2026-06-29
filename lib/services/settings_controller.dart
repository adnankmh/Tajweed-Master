import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  String language = 'ar';
  String themeId = 'light';
  String fontFamily = 'Arial';
  double quranFontSize = 30;
  bool showColorGuide = true;

  static const _languageKey = 'language';
  static const _themeKey = 'theme';
  static const _fontKey = 'font';
  static const _fontSizeKey = 'quran_font_size';
  static const _guideKey = 'show_color_guide';

  double get uiTextScale => (0.84 + ((quranFontSize - 20) / 28) * 0.34).clamp(0.9, 1.22);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    language = prefs.getString(_languageKey) ?? 'ar';
    themeId = prefs.getString(_themeKey) ?? 'light';
    if (!themeNames.containsKey(themeId)) themeId = 'light';
    fontFamily = prefs.getString(_fontKey) ?? 'Arial';
    if (!fontFamilies.contains(fontFamily)) fontFamily = 'Arial';
    quranFontSize = (prefs.getDouble(_fontSizeKey) ?? 30).clamp(20, 56).toDouble();
    showColorGuide = prefs.getBool(_guideKey) ?? true;
    notifyListeners();
  }

  Future<void> setLanguage(String value) async {
    language = value;
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_languageKey, value);
  }

  Future<void> setThemeId(String value) async {
    themeId = themeNames.containsKey(value) ? value : 'light';
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_themeKey, themeId);
  }

  Future<void> setFontFamily(String value) async {
    fontFamily = fontFamilies.contains(value) ? value : 'Arial';
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_fontKey, fontFamily);
  }

  Future<void> changeFontSize(double delta) async {
    quranFontSize = (quranFontSize + delta).clamp(20, 56).toDouble();
    notifyListeners();
    (await SharedPreferences.getInstance()).setDouble(_fontSizeKey, quranFontSize);
  }

  Future<void> setFontSize(double value) async {
    quranFontSize = value.clamp(20, 56).toDouble();
    notifyListeners();
    (await SharedPreferences.getInstance()).setDouble(_fontSizeKey, quranFontSize);
  }

  Future<void> toggleGuide() async {
    showColorGuide = !showColorGuide;
    notifyListeners();
    (await SharedPreferences.getInstance()).setBool(_guideKey, showColorGuide);
  }

  Future<void> setGuide(bool value) async {
    showColorGuide = value;
    notifyListeners();
    (await SharedPreferences.getInstance()).setBool(_guideKey, value);
  }
}

const fontFamilies = [
  'Arial',
  'Tahoma',
  'Segoe UI',
  'Times New Roman',
  'Georgia',
  'Verdana',
  'Noto Naskh Arabic',
  'Amiri Quran',
  'Scheherazade New',
];

const themeNames = {
  'light': {'ar': 'فاتح', 'en': 'Light', 'fr': 'Clair', 'tr': 'Açık', 'es': 'Claro', 'de': 'Hell'},
  'dark': {'ar': 'داكن', 'en': 'Dark', 'fr': 'Sombre', 'tr': 'Koyu', 'es': 'Oscuro', 'de': 'Dunkel'},
  'gold': {'ar': 'ذهبي', 'en': 'Gold', 'fr': 'Doré', 'tr': 'Altın', 'es': 'Dorado', 'de': 'Gold'},
  'mint': {'ar': 'أخضر فاتح', 'en': 'Light Green', 'fr': 'Vert clair', 'tr': 'Açık yeşil', 'es': 'Verde claro', 'de': 'Hellgrün'},
  'sky': {'ar': 'أزرق سماوي', 'en': 'Sky Blue', 'fr': 'Bleu ciel', 'tr': 'Gök mavisi', 'es': 'Azul cielo', 'de': 'Himmelblau'},
};

Color quranPaperColor(String id, Brightness brightness) {
  switch (id) {
    case 'dark':
      return const Color(0xFF111827);
    case 'gold':
      return const Color(0xFFFFF8E1);
    case 'mint':
      return const Color(0xFFF0FDF4);
    case 'sky':
      return const Color(0xFFEFF8FF);
    case 'light':
    default:
      return const Color(0xFFFBF7EF);
  }
}

ThemeData buildTheme(String id, String fontFamily) {
  final configs = <String, ({Color seed, Brightness brightness, Color surface})>{
    'light': (seed: const Color(0xFF0F766E), brightness: Brightness.light, surface: const Color(0xFFF7FAF7)),
    'dark': (seed: const Color(0xFF38BDF8), brightness: Brightness.dark, surface: const Color(0xFF0B1220)),
    'gold': (seed: const Color(0xFFD97706), brightness: Brightness.light, surface: const Color(0xFFFFFBEB)),
    'mint': (seed: const Color(0xFF16A34A), brightness: Brightness.light, surface: const Color(0xFFF0FDF4)),
    'sky': (seed: const Color(0xFF0284C7), brightness: Brightness.light, surface: const Color(0xFFEFF8FF)),
  };
  final c = configs[id] ?? configs['light']!;
  final colorScheme = ColorScheme.fromSeed(seedColor: c.seed, brightness: c.brightness);
  return ThemeData(
    useMaterial3: true,
    brightness: c.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: c.surface,
    fontFamily: fontFamily,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: colorScheme.surface.withOpacity(.95),
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26), side: BorderSide(color: colorScheme.outlineVariant.withOpacity(.50))),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      side: BorderSide(color: colorScheme.outlineVariant),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(46, 46),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(fontWeight: FontWeight.w900),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(46, 46),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        side: BorderSide(color: colorScheme.outline.withOpacity(.45)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(.55),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: colorScheme.outlineVariant)),
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withOpacity(.30),
    ),
  );
}
