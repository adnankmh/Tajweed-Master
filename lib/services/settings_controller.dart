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

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    language = prefs.getString(_languageKey) ?? 'ar';
    themeId = prefs.getString(_themeKey) ?? 'light';
    fontFamily = prefs.getString(_fontKey) ?? 'Arial';
    quranFontSize = prefs.getDouble(_fontSizeKey) ?? 30;
    showColorGuide = prefs.getBool(_guideKey) ?? true;
    notifyListeners();
  }

  Future<void> setLanguage(String value) async {
    language = value;
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_languageKey, value);
  }

  Future<void> setThemeId(String value) async {
    themeId = value;
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_themeKey, value);
  }

  Future<void> setFontFamily(String value) async {
    fontFamily = value;
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_fontKey, value);
  }

  Future<void> changeFontSize(double delta) async {
    quranFontSize = (quranFontSize + delta).clamp(20, 48);
    notifyListeners();
    (await SharedPreferences.getInstance()).setDouble(_fontSizeKey, quranFontSize);
  }

  Future<void> toggleGuide() async {
    showColorGuide = !showColorGuide;
    notifyListeners();
    (await SharedPreferences.getInstance()).setBool(_guideKey, showColorGuide);
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
  'emerald': {'ar': 'زمردي', 'en': 'Emerald', 'fr': 'Émeraude', 'tr': 'Zümrüt', 'es': 'Esmeralda', 'de': 'Smaragd'},
  'royal': {'ar': 'ملكي', 'en': 'Royal', 'fr': 'Royal', 'tr': 'Kraliyet', 'es': 'Real', 'de': 'Königlich'},
  'warm': {'ar': 'مصحفي دافئ', 'en': 'Warm Mushaf', 'fr': 'Chaud', 'tr': 'Sıcak', 'es': 'Cálido', 'de': 'Warm'},
  'night': {'ar': 'ليلي فاخر', 'en': 'Luxury Night', 'fr': 'Nuit luxe', 'tr': 'Lüks gece', 'es': 'Noche', 'de': 'Luxusnacht'},
};

ThemeData buildTheme(String id, String fontFamily) {
  final configs = <String, ({Color seed, Brightness brightness, Color surface})>{
    'light': (seed: const Color(0xFF0F766E), brightness: Brightness.light, surface: const Color(0xFFFBF7EF)),
    'dark': (seed: const Color(0xFF38BDF8), brightness: Brightness.dark, surface: const Color(0xFF0F172A)),
    'emerald': (seed: const Color(0xFF047857), brightness: Brightness.light, surface: const Color(0xFFECFDF5)),
    'royal': (seed: const Color(0xFF4338CA), brightness: Brightness.dark, surface: const Color(0xFF111827)),
    'warm': (seed: const Color(0xFFB45309), brightness: Brightness.light, surface: const Color(0xFFFFF7ED)),
    'night': (seed: const Color(0xFFA78BFA), brightness: Brightness.dark, surface: const Color(0xFF070A12)),
  };
  final c = configs[id] ?? configs['light']!;
  final colorScheme = ColorScheme.fromSeed(seedColor: c.seed, brightness: c.brightness);
  return ThemeData(
    useMaterial3: true,
    brightness: c.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: c.surface,
    fontFamily: fontFamily,
    appBarTheme: AppBarTheme(centerTitle: false, backgroundColor: colorScheme.surface.withOpacity(.92)),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: colorScheme.outlineVariant.withOpacity(.5))),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      side: BorderSide(color: colorScheme.outlineVariant),
    ),
  );
}
