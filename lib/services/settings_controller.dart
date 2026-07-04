import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  String language = 'ar';
  String themeId = 'light';
  String fontFamily = 'Arial';
  double quranFontSize = 30;
  bool showColorGuide = true;
  String mushafBackgroundId = 'theme';
  double buttonScale = 1.0;
  bool showAds = true;
  String accentHex = '';

  static const _languageKey = 'language';
  static const _themeKey = 'theme';
  static const _fontKey = 'font';
  static const _fontSizeKey = 'quran_font_size';
  static const _guideKey = 'show_color_guide';
  static const _mushafBackgroundKey = 'mushaf_background';
  static const _buttonScaleKey = 'button_scale';
  static const _showAdsKey = 'show_ads';
  static const _accentHexKey = 'accent_hex';

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
    mushafBackgroundId = prefs.getString(_mushafBackgroundKey) ?? 'theme';
    if (!mushafBackgroundNames.containsKey(mushafBackgroundId)) mushafBackgroundId = 'theme';
    buttonScale = (prefs.getDouble(_buttonScaleKey) ?? 1.0).clamp(0.85, 1.35).toDouble();
    showAds = prefs.getBool(_showAdsKey) ?? true;
    accentHex = prefs.getString(_accentHexKey) ?? '';
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

  Future<void> setMushafBackground(String value) async {
    mushafBackgroundId = mushafBackgroundNames.containsKey(value) ? value : 'theme';
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_mushafBackgroundKey, mushafBackgroundId);
  }

  Future<void> setButtonScale(double value) async {
    buttonScale = value.clamp(0.85, 1.35).toDouble();
    notifyListeners();
    (await SharedPreferences.getInstance()).setDouble(_buttonScaleKey, buttonScale);
  }

  Future<void> setShowAds(bool value) async {
    showAds = value;
    notifyListeners();
    (await SharedPreferences.getInstance()).setBool(_showAdsKey, value);
  }

  Future<void> setAccentHex(String value) async {
    accentHex = value.trim();
    notifyListeners();
    (await SharedPreferences.getInstance()).setString(_accentHexKey, accentHex);
  }

}


const fontFamilies = [
  'Arial',
  'Tahoma',
  'Segoe UI',
  'Times New Roman',
  'Georgia',
  'Verdana',
  'Courier New',
  'serif',
  'sans-serif',
  'monospace',
  'Noto Naskh Arabic',
  'Amiri Quran',
  'Scheherazade New',
];

const fontFallbacks = [
  'Arial',
  'Tahoma',
  'Segoe UI',
  'Noto Naskh Arabic',
  'Amiri Quran',
  'Scheherazade New',
  'Times New Roman',
  'serif',
];

const themeNames = {
  'light': {'ar': 'فاتح', 'en': 'Light', 'fr': 'Clair', 'tr': 'Açık', 'es': 'Claro', 'de': 'Hell'},
  'dark': {'ar': 'داكن', 'en': 'Dark', 'fr': 'Sombre', 'tr': 'Koyu', 'es': 'Oscuro', 'de': 'Dunkel'},
  'gold': {'ar': 'ذهبي', 'en': 'Gold', 'fr': 'Doré', 'tr': 'Altın', 'es': 'Dorado', 'de': 'Gold'},
  'mint': {'ar': 'أخضر فاتح', 'en': 'Light Green', 'fr': 'Vert clair', 'tr': 'Açık yeşil', 'es': 'Verde claro', 'de': 'Hellgrün'},
  'sky': {'ar': 'أزرق سماوي', 'en': 'Sky Blue', 'fr': 'Bleu ciel', 'tr': 'Gök mavisi', 'es': 'Azul cielo', 'de': 'Himmelblau'},
};

const mushafBackgroundNames = {
  'theme': {'ar': 'حسب الثيم', 'en': 'Theme default', 'fr': 'Thème', 'tr': 'Tema varsayılanı', 'es': 'Según tema', 'de': 'Nach Design'},
  'cream': {'ar': 'كريمي مصحفي', 'en': 'Cream Mushaf', 'fr': 'Crème', 'tr': 'Krem', 'es': 'Crema', 'de': 'Creme'},
  'white': {'ar': 'أبيض صافي', 'en': 'Pure white', 'fr': 'Blanc', 'tr': 'Beyaz', 'es': 'Blanco', 'de': 'Weiß'},
  'goldPaper': {'ar': 'ورق ذهبي هادئ', 'en': 'Soft gold paper', 'fr': 'Doré doux', 'tr': 'Yumuşak altın', 'es': 'Dorado suave', 'de': 'Sanftes Gold'},
  'greenPaper': {'ar': 'أخضر فاتح هادئ', 'en': 'Soft green', 'fr': 'Vert doux', 'tr': 'Yumuşak yeşil', 'es': 'Verde suave', 'de': 'Sanftes Grün'},
  'bluePaper': {'ar': 'أزرق سماوي هادئ', 'en': 'Soft sky blue', 'fr': 'Bleu doux', 'tr': 'Açık gök mavisi', 'es': 'Azul suave', 'de': 'Sanftes Blau'},
  'darkPaper': {'ar': 'ليلي مريح', 'en': 'Comfort dark', 'fr': 'Sombre confortable', 'tr': 'Rahat koyu', 'es': 'Oscuro cómodo', 'de': 'Komfort dunkel'},
};

Color quranPaperColor(String themeId, Brightness brightness, [String backgroundId = 'theme']) {
  final selected = backgroundId == 'theme' ? themeId : backgroundId;
  switch (selected) {
    case 'dark':
    case 'darkPaper':
      return const Color(0xFF0F172A);
    case 'gold':
    case 'goldPaper':
      return const Color(0xFFFFF7D6);
    case 'mint':
    case 'greenPaper':
      return const Color(0xFFF0FDF4);
    case 'sky':
    case 'bluePaper':
      return const Color(0xFFEFF8FF);
    case 'white':
      return const Color(0xFFFFFFFF);
    case 'cream':
    case 'light':
    default:
      return const Color(0xFFFBF7EF);
  }
}

Color? parseAdminAccentColor(String hex) {
  final value = hex.trim().replaceAll('#', '');
  if (value.length != 6) return null;
  final parsed = int.tryParse(value, radix: 16);
  if (parsed == null) return null;
  return Color(0xFF000000 | parsed);
}

ThemeData buildTheme(String id, String fontFamily, {String accentHex = '', double buttonScale = 1.0}) {
  final configs = <String, ({Color seed, Brightness brightness, Color surface})>{
    'light': (seed: const Color(0xFF0F766E), brightness: Brightness.light, surface: const Color(0xFFF7FAF7)),
    'dark': (seed: const Color(0xFF38BDF8), brightness: Brightness.dark, surface: const Color(0xFF0B1220)),
    'gold': (seed: const Color(0xFFD97706), brightness: Brightness.light, surface: const Color(0xFFFFFBEB)),
    'mint': (seed: const Color(0xFF16A34A), brightness: Brightness.light, surface: const Color(0xFFF0FDF4)),
    'sky': (seed: const Color(0xFF0284C7), brightness: Brightness.light, surface: const Color(0xFFEFF8FF)),
  };
  final c = configs[id] ?? configs['light']!;
  final adminSeed = parseAdminAccentColor(accentHex);
  final colorScheme = ColorScheme.fromSeed(seedColor: adminSeed ?? c.seed, brightness: c.brightness);
  return ThemeData(
    useMaterial3: true,
    brightness: c.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: c.surface,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallbacks,
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
        minimumSize: Size(48 * buttonScale, 48 * buttonScale),
        padding: EdgeInsets.symmetric(horizontal: 20 * buttonScale, vertical: 15 * buttonScale),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 1.5,
        shadowColor: colorScheme.primary.withOpacity(.20),
        textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: .1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(46 * buttonScale, 46 * buttonScale),
        padding: EdgeInsets.symmetric(horizontal: 16 * buttonScale, vertical: 13 * buttonScale),
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
