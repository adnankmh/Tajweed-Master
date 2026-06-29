import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/app_strings.dart';
import 'data/tajweed_content.dart';
import 'models/content_models.dart';
import 'models/quran_models.dart';
import 'services/notifications/notification_service.dart';
import 'services/progress_service.dart';
import 'services/quran_repository.dart';
import 'services/settings_controller.dart';
import 'services/tajweed_analyzer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsController();
  await settings.load();
  await NotificationService().initialize();
  runApp(TajweedApp(settings: settings));
}

class TajweedApp extends StatelessWidget {
  const TajweedApp({super.key, required this.settings});
  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settings,
      builder: (context, _) {
        final isArabic = settings.language == 'ar';
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: t('appTitle', settings.language),
          theme: buildTheme(settings.themeId, settings.fontFamily),
          locale: Locale(settings.language),
          supportedLocales: supportedLanguages.map(Locale.new),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            final media = MediaQuery.of(context);
            return Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: MediaQuery(
                data: media.copyWith(textScaler: TextScaler.linear(settings.uiTextScale)),
                child: child!,
              ),
            );
          },
          home: FutureBuilder<List<QuranSurah>>(
            future: QuranRepository().load(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(t('appTitle', settings.language)),
                      ],
                    ),
                  ),
                );
              }
              return HomeShell(settings: settings, surahs: snapshot.data!);
            },
          ),
        );
      },
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.settings, required this.surahs});
  final SettingsController settings;
  final List<QuranSurah> surahs;

  @override
  State<HomeShell> createState() => _HomeShellState();
}


class _HomeShellState extends State<HomeShell> {
  int page = 0;
  bool navVisible = true;

  void goHome() => setState(() => page = 0);
  void goPage(int value) => setState(() => page = value);

  @override
  Widget build(BuildContext context) {
    final lang = widget.settings.language;
    final labels = [
      t('quran', lang),
      t('library', lang),
      t('lessons', lang),
      t('plan', lang),
      t('exams', lang),
      t('notifications', lang),
      t('settings', lang),
      t('publish', lang),
    ];
    final icons = [
      Icons.menu_book_rounded,
      Icons.auto_stories_rounded,
      Icons.school_rounded,
      Icons.calendar_month_rounded,
      Icons.quiz_rounded,
      Icons.notifications_active_rounded,
      Icons.tune_rounded,
      Icons.cloud_upload_rounded,
    ];
    final children = [
      QuranScreen(settings: widget.settings, surahs: widget.surahs),
      RulesLibraryScreen(settings: widget.settings),
      LessonsScreen(settings: widget.settings),
      LearningPlanScreen(settings: widget.settings),
      ExamsScreen(settings: widget.settings),
      NotificationsScreen(settings: widget.settings),
      SettingsScreen(settings: widget.settings),
      PublishScreen(settings: widget.settings),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        titleSpacing: 8,
        leading: IconButton(
          tooltip: navVisible ? t('hideNav', lang) : t('showNav', lang),
          icon: Icon(navVisible ? Icons.menu_open_rounded : Icons.menu_rounded),
          onPressed: () => setState(() => navVisible = !navVisible),
        ),
        title: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: goHome,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_stories_rounded, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Flexible(child: Text(t('appTitle', lang), overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900))),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: t('settings', lang),
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => goPage(6),
          ),
          IconButton(
            tooltip: navVisible ? t('hideNav', lang) : t('showNav', lang),
            icon: Icon(navVisible ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded),
            onPressed: () => setState(() => navVisible = !navVisible),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;
          final content = Column(
            children: [
              SettingsBar(settings: widget.settings, onOpenSettings: () => goPage(6)),
              Expanded(child: children[page]),
            ],
          );
          if (!isWide) return content;
          return Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                width: navVisible ? (constraints.maxWidth > 1180 ? 236 : 88) : 0,
                child: ClipRect(
                  child: OverflowBox(
                    alignment: AlignmentDirectional.topStart,
                    maxWidth: constraints.maxWidth > 1180 ? 236 : 88,
                    child: navVisible
                        ? NavigationRail(
                            selectedIndex: page,
                            onDestinationSelected: goPage,
                            extended: constraints.maxWidth > 1180,
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 12, bottom: 10),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                child: Text('ت', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w900, fontSize: 26)),
                              ),
                            ),
                            destinations: [
                              for (var i = 0; i < labels.length; i++) NavigationRailDestination(icon: Icon(icons[i]), label: Text(labels[i])),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              if (navVisible) const VerticalDivider(width: 1),
              Expanded(child: content),
            ],
          );
        },
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 980) return const SizedBox.shrink();
          return AnimatedSlide(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            offset: navVisible ? Offset.zero : const Offset(0, 1.05),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 240),
              child: navVisible ? MobileNavBar(selected: page, labels: labels, icons: icons, onSelect: goPage) : const SizedBox(height: 0),
            ),
          );
        },
      ),
      floatingActionButton: navVisible
          ? null
          : FloatingActionButton.small(
              tooltip: t('showNav', lang),
              onPressed: () => setState(() => navVisible = true),
              child: const Icon(Icons.menu_rounded),
            ),
    );
  }
}

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({super.key, required this.selected, required this.labels, required this.icons, required this.onSelect});
  final int selected;
  final List<String> labels;
  final List<IconData> icons;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: scheme.surface.withOpacity(.96),
          border: Border(top: BorderSide(color: scheme.outlineVariant.withOpacity(.55))),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 18, offset: const Offset(0, -4))],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < labels.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    selected: i == selected,
                    avatar: Icon(icons[i], size: 19),
                    label: Text(labels[i], maxLines: 1, overflow: TextOverflow.ellipsis),
                    onSelected: (_) => onSelect(i),
                    labelStyle: const TextStyle(fontWeight: FontWeight.w800),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsBar extends StatelessWidget {
  const SettingsBar({super.key, required this.settings, required this.onOpenSettings});
  final SettingsController settings;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(.82),
        border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(.45))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _MiniToolButton(tooltip: t('language', lang), icon: Icons.translate_rounded, onTap: () => _showChoiceSheet(context, title: t('language', lang), value: settings.language, items: supportedLanguages.map((code) => MapEntry(code, languageNames[code] ?? code)).toList(), onSelected: settings.setLanguage)),
            _MiniToolButton(tooltip: t('theme', lang), icon: Icons.palette_rounded, onTap: () => _showChoiceSheet(context, title: t('theme', lang), value: settings.themeId, items: themeNames.entries.map((e) => MapEntry(e.key, e.value[lang] ?? e.value['ar']!)).toList(), onSelected: settings.setThemeId)),
            _MiniToolButton(tooltip: t('font', lang), icon: Icons.font_download_rounded, onTap: () => _showChoiceSheet(context, title: t('font', lang), value: settings.fontFamily, items: fontFamilies.map((f) => MapEntry(f, f)).toList(), onSelected: settings.setFontFamily)),
            _MiniToolButton(tooltip: t('smallerFont', lang), icon: Icons.text_decrease_rounded, onTap: () => settings.changeFontSize(-2)),
            _MiniToolButton(tooltip: t('largerFont', lang), icon: Icons.text_increase_rounded, onTap: () => settings.changeFontSize(2)),
            _MiniBadge(text: settings.quranFontSize.toStringAsFixed(0)),
            _MiniToolButton(tooltip: settings.showColorGuide ? t('hideGuide', lang) : t('showGuide', lang), icon: settings.showColorGuide ? Icons.visibility_off_rounded : Icons.visibility_rounded, onTap: settings.toggleGuide),
            _MiniToolButton(tooltip: t('settings', lang), icon: Icons.tune_rounded, onTap: onOpenSettings),
          ],
        ),
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.65),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w900)),
      );
}

class _MiniToolButton extends StatelessWidget {
  const _MiniToolButton({required this.tooltip, required this.icon, required this.onTap});
  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Tooltip(
          message: tooltip,
          child: IconButton.filledTonal(
            icon: Icon(icon, size: 21),
            onPressed: onTap,
            style: IconButton.styleFrom(minimumSize: const Size(38, 38), maximumSize: const Size(38, 38), padding: EdgeInsets.zero),
          ),
        ),
      );
}

Future<void> _showChoiceSheet<T>(BuildContext context, {required String title, required T value, required List<MapEntry<T, String>> items, required ValueChanged<T> onSelected}) async {
  await showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          for (final item in items)
            Card(
              child: ListTile(
                leading: Icon(item.key == value ? Icons.check_circle_rounded : Icons.circle_outlined, color: item.key == value ? Theme.of(context).colorScheme.primary : null),
                title: Text(item.value, style: const TextStyle(fontWeight: FontWeight.w800)),
                onTap: () {
                  Navigator.pop(context);
                  onSelected(item.key);
                },
              ),
            ),
        ],
      ),
    ),
  );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.settings});
  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t('settings', lang), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(t('settingsBody', lang), style: const TextStyle(height: 1.6, fontWeight: FontWeight.w600)),
                SectionTitle(t('language', lang)),
                Wrap(spacing: 8, runSpacing: 8, children: [for (final code in supportedLanguages) ChoiceChip(label: Text(languageNames[code] ?? code), selected: settings.language == code, onSelected: (_) => settings.setLanguage(code))]),
                SectionTitle(t('theme', lang)),
                Wrap(spacing: 8, runSpacing: 8, children: [for (final item in themeNames.entries) ChoiceChip(label: Text(item.value[lang] ?? item.value['ar']!), selected: settings.themeId == item.key, onSelected: (_) => settings.setThemeId(item.key))]),
                SectionTitle(t('font', lang)),
                Wrap(spacing: 8, runSpacing: 8, children: [for (final font in fontFamilies) ChoiceChip(label: Text(font), selected: settings.fontFamily == font, onSelected: (_) => settings.setFontFamily(font))]),
                SectionTitle(t('fontSize', lang)),
                Row(children: [
                  IconButton.filledTonal(onPressed: () => settings.changeFontSize(-2), icon: const Icon(Icons.text_decrease_rounded)),
                  Expanded(child: Slider(value: settings.quranFontSize, min: 20, max: 48, divisions: 14, label: settings.quranFontSize.toStringAsFixed(0), onChanged: settings.setFontSize)),
                  IconButton.filledTonal(onPressed: () => settings.changeFontSize(2), icon: const Icon(Icons.text_increase_rounded)),
                ]),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: settings.showColorGuide,
                  onChanged: settings.setGuide,
                  title: Text(t('colorGuide', lang), style: const TextStyle(fontWeight: FontWeight.w900)),
                  subtitle: Text(t('colorGuideBody', lang)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key, required this.settings, required this.surahs});
  final SettingsController settings;
  final List<QuranSurah> surahs;

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  int selected = 1;
  String search = '';

  @override
  Widget build(BuildContext context) {
    final lang = widget.settings.language;
    final surah = widget.surahs.firstWhere((s) => s.number == selected);
    final filtered = widget.surahs.where((s) => search.trim().isEmpty || s.name.contains(search) || s.englishName.toLowerCase().contains(search.toLowerCase()) || '${s.number}' == search.trim()).toList();
    final menuSurahs = filtered.any((s) => s.number == selected) ? filtered : [surah, ...filtered];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ScientificWarning(lang: lang),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      width: min(MediaQuery.of(context).size.width - 64, 380),
                      child: TextField(
                        decoration: InputDecoration(prefixIcon: const Icon(Icons.search), labelText: t('searchSurah', lang), border: const OutlineInputBorder()),
                        onChanged: (value) => setState(() => search = value),
                      ),
                    ),
                    DropdownButton<int>(
                      value: selected,
                      items: [
                        for (final s in menuSurahs) DropdownMenuItem(value: s.number, child: Text('${s.number}. ${s.name} — ${s.englishName}')),
                      ],
                      onChanged: (value) => setState(() => selected = value ?? selected),
                    ),
                    Chip(label: Text('${surah.revelation} • ${surah.ayahCount}')),
                    Chip(avatar: const Icon(Icons.touch_app_rounded, size: 18), label: Text(t('tapRule', lang))),
                  ],
                ),
                if (widget.settings.showColorGuide) ...[
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 8, children: [for (final r in tajweedRules) RuleChip(rule: r, lang: lang)]),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: quranPaperColor(widget.settings.themeId, Theme.of(context).brightness),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Text('﴿ ${surah.name} ﴾', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 16),
                for (final ayah in surah.ayahs) AyahView(ayah: ayah, settings: widget.settings),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class AyahView extends StatelessWidget {
  const AyahView({super.key, required this.ayah, required this.settings});
  final QuranAyah ayah;
  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    final text = ayah.text;
    final fullText = '$text  ﴿${ayah.number}﴾';
    final segments = TajweedAnalyzer.analyze(text);
    final textStyle = TextStyle(
      fontFamily: settings.fontFamily,
      fontSize: settings.quranFontSize,
      height: 2.10,
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (details) {
                final index = _textIndexAtOffset(fullText, textStyle, constraints.maxWidth, details.localPosition);
                if (index == null) return;
                final hit = _segmentAtIndex(segments, index);
                if (hit != null) showRuleSheet(context, hit.rule, settings.language);
              },
              child: CustomPaint(
                foregroundPainter: TajweedOverlayPainter(
                  text: fullText,
                  segments: segments,
                  style: textStyle,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                ),
                child: Text(
                  fullText,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                  style: textStyle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int? _textIndexAtOffset(String fullText, TextStyle style, double maxWidth, Offset localPosition) {
    if (maxWidth <= 0) return null;
    final painter = TextPainter(
      text: TextSpan(text: fullText, style: style),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
    )..layout(maxWidth: maxWidth);
    final pos = painter.getPositionForOffset(localPosition);
    return pos.offset;
  }

  HighlightSegment? _segmentAtIndex(List<HighlightSegment> segments, int index) {
    for (final s in segments) {
      if (index >= s.start && index < s.end) return s;
    }
    return null;
  }
}

class TajweedOverlayPainter extends CustomPainter {
  TajweedOverlayPainter({required this.text, required this.segments, required this.style, required this.textDirection, required this.textAlign});
  final String text;
  final List<HighlightSegment> segments;
  final TextStyle style;
  final TextDirection textDirection;
  final TextAlign textAlign;

  @override
  void paint(Canvas canvas, Size size) {
    if (segments.isEmpty || size.width <= 0) return;
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      textAlign: textAlign,
      maxLines: null,
    )..layout(maxWidth: size.width);

    for (final segment in segments) {
  final color = segment.rule.color;
  final boxes = painter.getBoxesForSelection(
    TextSelection(
      baseOffset: segment.start,
      extentOffset: segment.end,
    ),
  );

  for (final box in boxes) {
    final boxRect = box.toRect();

    if (boxRect.width <= 1 || boxRect.height <= 1) continue;

    final markerHeight = (style.fontSize ?? 30) * .15;

    final top = (boxRect.top + (style.fontSize ?? 30) * .08)
        .clamp(
          boxRect.top,
          boxRect.bottom - markerHeight,
        )
        .toDouble();

    final rect = Rect.fromLTWH(
      boxRect.left,
      top,
      boxRect.width,
      markerHeight.clamp(3, 6).toDouble(),
    );

    final paint = Paint()..color = color.withOpacity(.68);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        const Radius.circular(99),
      ),
      paint,
    );
  }
}

  @override
  bool shouldRepaint(covariant TajweedOverlayPainter oldDelegate) {
    return oldDelegate.text != text || oldDelegate.segments != segments || oldDelegate.style != style || oldDelegate.textDirection != textDirection || oldDelegate.textAlign != textAlign;
  }
}

void showRuleSheet(BuildContext context, TajweedRule rule, String lang) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: .65,
      maxChildSize: .92,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.all(22),
        children: [
          Row(children: [CircleAvatar(backgroundColor: rule.color), const SizedBox(width: 12), Expanded(child: Text(rule.title.tr(lang), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)))]),
          const SizedBox(height: 12),
          Text(rule.short.tr(lang), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Text(rule.deep.tr(lang), style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7)),
          const SizedBox(height: 18),
          RuleLearningBlocks(rule: rule, lang: lang),
          const SizedBox(height: 18),
          SectionTitle(t('examples', lang)),
          for (final e in rule.examples) QuranExample(e),
          SectionTitle(t('commonMistakes', lang)),
          for (final m in rule.commonMistakes) BulletText(m.tr(lang)),
          SectionTitle(t('questions', lang)),
          for (final q in rule.questions) QuestionPreview(question: q, lang: lang),
        ],
      ),
    ),
  );
}


class RuleLearningBlocks extends StatelessWidget {
  const RuleLearningBlocks({super.key, required this.rule, required this.lang});
  final TajweedRule rule;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final blocks = [
      (Icons.manage_search_rounded, t('howToIdentify', lang), _identifyText(rule, lang)),
      (Icons.record_voice_over_rounded, t('pronunciationMethod', lang), _pronounceText(rule, lang)),
      (Icons.hearing_rounded, t('listeningTraining', lang), _listeningText(rule, lang)),
      (Icons.checklist_rtl_rounded, t('selfReview', lang), _reviewText(rule, lang)),
    ];
    return Column(
      children: [
        for (final b in blocks)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(.55),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(.45)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 18, backgroundColor: rule.color.withOpacity(.16), child: Icon(b.$1, size: 19, color: rule.color)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(b.$2, style: const TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text(b.$3, style: const TextStyle(height: 1.55)),
                ])),
              ],
            ),
          ),
      ],
    );
  }

  String _identifyText(TajweedRule r, String lang) => lang == 'ar'
      ? 'ابدأ بتحديد موضع الحكم في الآية: هل هو نون ساكنة، تنوين، ميم ساكنة، مد، لام، راء، أو حرف صفة؟ بعد ذلك انظر إلى الحرف التالي أو الحركة المصاحبة. في التطبيق يظهر اللون كعلامة علوية فوق موضع الحكم دون تقطيع الكلمة حتى تبقى قراءة النص طبيعية.'
      : 'Start by locating the rule: noon sakin, tanween, silent meem, madd, lam, raa, or a letter attribute. Then check the following letter or vowel. The app now marks the place with an upper color marker without splitting the Quranic word.';

  String _pronounceText(TajweedRule r, String lang) => lang == 'ar'
      ? 'اقرأ الموضع ببطء أولًا، ثم اضبط زمن الغنة أو المد أو وضوح الحرف حسب الحكم. لا تجعل اللون هدفًا بصريًا فقط؛ الهدف أن يتحول إلى أداء صحيح في اللسان والشفتين والخيشوم.'
      : 'Read slowly first, then control the length of ghunnah or madd and the clarity of the letter. The marker is a learning aid; the goal is correct recitation performance.';

  String _listeningText(TajweedRule r, String lang) => lang == 'ar'
      ? 'استمع إلى قارئ متقن للآية نفسها، ثم كرر الموضع ثلاث مرات: مرة للتعرّف، مرة للتطبيق، ومرة للمراجعة. سجّل صوتك إن أمكن وقارن مقدار الغنة أو المد أو القلقلة.'
      : 'Listen to a skilled reciter, then repeat the same place three times: identify, apply, and review. Record yourself when possible and compare the sound.';

  String _reviewText(TajweedRule r, String lang) => lang == 'ar'
      ? 'اسأل نفسك: ما سبب الحكم؟ ما الحرف المؤثر؟ هل نطقت الغنة أو المد بالزمن الصحيح؟ هل بقيت الكلمة متصلة دون مبالغة أو اختلاس؟ إذا أجبت بوضوح فأنت جاهز للانتقال إلى أمثلة جديدة.'
      : 'Ask yourself: What caused the rule? Which letter matters? Did I keep the proper timing? Did I avoid exaggeration? Clear answers mean you can move to new examples.';
}

class RuleChip extends StatelessWidget {
  const RuleChip({super.key, required this.rule, required this.lang});
  final TajweedRule rule;
  final String lang;
  @override
  Widget build(BuildContext context) => ActionChip(
        avatar: CircleAvatar(radius: 7, backgroundColor: rule.color),
        label: Text(rule.title.tr(lang)),
        onPressed: () => showRuleSheet(context, rule, lang),
      );
}

class ScientificWarning extends StatelessWidget {
  const ScientificWarning({super.key, required this.lang});
  final String lang;
  @override
  Widget build(BuildContext context) => Card(
        color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.55),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.verified_user_rounded, color: Theme.of(context).colorScheme.tertiary),
              const SizedBox(width: 10),
              Expanded(child: Text('${t('warning', lang)}: ${t('warningBody', lang)}', style: const TextStyle(fontWeight: FontWeight.w600, height: 1.45))),
            ],
          ),
        ),
      );
}

class RulesLibraryScreen extends StatelessWidget {
  const RulesLibraryScreen({super.key, required this.settings});
  final SettingsController settings;
  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).size.width > 1100 ? 3 : MediaQuery.of(context).size.width > 700 ? 2 : 1, childAspectRatio: 1.75),
      itemCount: tajweedRules.length,
      itemBuilder: (context, index) {
        final r = tajweedRules[index];
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RuleDetailPage(rule: r, settings: settings))),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [CircleAvatar(backgroundColor: r.color), const SizedBox(width: 12), Expanded(child: Text(r.title.tr(lang), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)))]),
                const SizedBox(height: 12),
                Expanded(child: Text(r.short.tr(lang), maxLines: 4, overflow: TextOverflow.ellipsis, style: const TextStyle(height: 1.45))),
                Wrap(spacing: 6, children: [Chip(label: Text(r.category)), Chip(label: Text('${r.examples.length} ${t('examples', lang)}'))]),
              ]),
            ),
          ),
        );
      },
    );
  }
}

class RuleDetailPage extends StatelessWidget {
  const RuleDetailPage({super.key, required this.rule, required this.settings});
  final TajweedRule rule;
  final SettingsController settings;
  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    return Scaffold(
      appBar: AppBar(title: Text(rule.title.tr(lang))),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [CircleAvatar(radius: 22, backgroundColor: rule.color), const SizedBox(width: 12), Expanded(child: Text(rule.title.tr(lang), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)))]),
          const SizedBox(height: 16),
          Text(rule.deep.tr(lang), style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8)),
          const SizedBox(height: 14),
          RuleLearningBlocks(rule: rule, lang: lang),
          SectionTitle(t('examples', lang)),
          for (final e in rule.examples) QuranExample(e),
          SectionTitle(t('commonMistakes', lang)),
          for (final item in rule.commonMistakes) BulletText(item.tr(lang)),
          SectionTitle(t('questions', lang)),
          for (final q in rule.questions) QuestionPreview(question: q, lang: lang),
        ]))),
      ]),
    );
  }
}

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key, required this.settings});
  final SettingsController settings;
  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(child: Text('${lesson.order}')),
            title: Text(lesson.title.tr(lang), style: const TextStyle(fontWeight: FontWeight.w900)),
            subtitle: Text(lesson.summary.tr(lang)),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonDetailPage(lesson: lesson, settings: settings))),
          ),
        );
      },
    );
  }
}

class LessonDetailPage extends StatelessWidget {
  const LessonDetailPage({super.key, required this.lesson, required this.settings});
  final Lesson lesson;
  final SettingsController settings;
  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    return Scaffold(
      appBar: AppBar(title: Text(lesson.title.tr(lang))),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(lesson.title.tr(lang), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(lesson.summary.tr(lang), style: Theme.of(context).textTheme.titleMedium),
          for (final s in lesson.sections) ...[SectionTitle(s.heading.tr(lang)), Text(s.body.tr(lang), style: const TextStyle(height: 1.7))],
          LessonDeepPractice(lang: lang),
          SectionTitle(t('examples', lang)),
          for (final e in lesson.examples) QuranExample(e),
          SectionTitle(t('questions', lang)),
          for (final q in lesson.questions) QuestionPreview(question: q, lang: lang),
          SectionTitle(t('library', lang)),
          Wrap(spacing: 8, runSpacing: 8, children: [for (final id in lesson.relatedRuleIds) RuleChip(rule: ruleById(id), lang: lang)]),
        ]))),
      ]),
    );
  }
}


class LessonDeepPractice extends StatelessWidget {
  const LessonDeepPractice({super.key, required this.lang});
  final String lang;

  @override
  Widget build(BuildContext context) {
    final items = lang == 'ar'
        ? [
            'اقرأ القاعدة ثم طبّقها مباشرة على مثال واحد قبل الانتقال للمثال التالي؛ التعلم المتدرج يمنع الخلط بين الأحكام المتشابهة.',
            'استخدم ثلاث مراحل: تحديد الموضع، معرفة السبب، ثم الأداء الصوتي الصحيح. لا تكتف بحفظ الاسم فقط.',
            'بعد كل درس ارجع إلى المصحف وابحث عن ثلاثة مواضع جديدة؛ هذا يحوّل الدرس من معلومات نظرية إلى مهارة تلاوة.',
          ]
        : [
            'Read the rule, then apply it to one example before moving to the next. Step-by-step practice prevents confusion.',
            'Use three stages: locate the place, understand the cause, then perform the correct sound.',
            'After every lesson, return to the Mushaf and find three new places to turn theory into recitation skill.',
          ];
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.38),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(.18)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(Icons.tips_and_updates_rounded, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 8), Text(t('studyMethod', lang), style: const TextStyle(fontWeight: FontWeight.w900))]),
        const SizedBox(height: 8),
        for (final item in items) BulletText(item),
      ]),
    );
  }
}

class LearningPlanScreen extends StatefulWidget {
  const LearningPlanScreen({super.key, required this.settings});
  final SettingsController settings;
  @override
  State<LearningPlanScreen> createState() => _LearningPlanScreenState();
}

class _LearningPlanScreenState extends State<LearningPlanScreen> {
  Set<int> done = {};
  @override
  void initState() {
    super.initState();
    ProgressService().completedDays().then((value) => setState(() => done = value));
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.settings.language;
    return ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t('plan', lang), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: done.length / learningPlan.length),
        const SizedBox(height: 8),
        Text('${done.length}/${learningPlan.length} ${t('completed', lang)}'),
      ]))),
      for (final day in learningPlan)
        Card(child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(backgroundColor: done.contains(day.day) ? Colors.green : null, child: Text('${day.day}')),
          title: Text(day.title.tr(lang), style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(day.objective.tr(lang)),
          trailing: Icon(done.contains(day.day) ? Icons.check_circle_rounded : Icons.arrow_forward_ios_rounded),
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(builder: (_) => LearningDayPage(day: day, settings: widget.settings)));
            final value = await ProgressService().completedDays();
            if (mounted) setState(() => done = value);
          },
        )),
    ]);
  }
}

class LearningDayPage extends StatelessWidget {
  const LearningDayPage({super.key, required this.day, required this.settings});
  final LearningDay day;
  final SettingsController settings;
  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    return Scaffold(
      appBar: AppBar(title: Text(day.title.tr(lang))),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(day.objective.tr(lang), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          Text(day.body.tr(lang), style: const TextStyle(height: 1.7)),
          SectionTitle(t('examples', lang)),
          for (final e in day.examples) QuranExample(e),
          SectionTitle('المهام / Tasks'),
          for (final task in day.tasks) BulletText(task.tr(lang)),
          SectionTitle(t('questions', lang)),
          for (final q in day.questions) QuestionPreview(question: q, lang: lang),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () async {
              await ProgressService().markDayComplete(day.day);
              if (context.mounted) Navigator.pop(context);
            },
            icon: const Icon(Icons.check_circle_rounded),
            label: Text(t('markComplete', lang)),
          ),
        ]))),
      ]),
    );
  }
}

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({super.key, required this.settings});
  final SettingsController settings;
  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  final scores = <String, int>{};
  @override
  void initState() {
    super.initState();
    for (final e in exams) {
      ProgressService().bestExamScore(e.id).then((v) => setState(() => scores[e.id] = v));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.settings.language;
    return ListView(padding: const EdgeInsets.all(16), children: [
      for (final exam in exams)
        Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Expanded(child: Text(exam.title.tr(lang), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900))), Chip(label: Text(exam.level)), Chip(label: Text('${exam.minutes} min'))]),
          const SizedBox(height: 8),
          Text(exam.description.tr(lang)),
          const SizedBox(height: 8),
          Text('${t('score', lang)}: ${scores[exam.id] ?? 0}%'),
          const SizedBox(height: 12),
          FilledButton.icon(onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExamRunnerPage(exam: exam, settings: widget.settings)));
            final v = await ProgressService().bestExamScore(exam.id);
            if (mounted) setState(() => scores[exam.id] = v);
          }, icon: const Icon(Icons.play_arrow_rounded), label: Text(t('startExam', lang))),
        ]))),
    ]);
  }
}

class ExamRunnerPage extends StatefulWidget {
  const ExamRunnerPage({super.key, required this.exam, required this.settings});
  final Exam exam;
  final SettingsController settings;
  @override
  State<ExamRunnerPage> createState() => _ExamRunnerPageState();
}

class _ExamRunnerPageState extends State<ExamRunnerPage> {
  late final List<QuizQuestion> questions;
  late final List<int?> answers;
  bool finished = false;

  @override
  void initState() {
    super.initState();
    questions = [...widget.exam.questions];
    answers = List<int?>.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.settings.language;
    final correct = List.generate(questions.length, (i) => answers[i] == questions[i].correctIndex).where((v) => v).length;
    final score = questions.isEmpty ? 0 : ((correct / questions.length) * 100).round();
    return Scaffold(
      appBar: AppBar(title: Text(widget.exam.title.tr(lang))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        if (finished) Card(color: score >= 80 ? Colors.green.withOpacity(.15) : Colors.orange.withOpacity(.15), child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${t('score', lang)}: $score%', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
          Text(score >= 80 ? 'ممتاز — يمكنك إصدار شهادة إنجاز داخل التطبيق.' : 'جيد — راجع الأخطاء ثم أعد الاختبار.'),
        ]))),
        for (var i = 0; i < questions.length; i++) Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${i + 1}. ${questions[i].question.tr(lang)}', style: const TextStyle(fontWeight: FontWeight.w900)),
          for (var j = 0; j < questions[i].options.length; j++) RadioListTile<int>(
            value: j,
            groupValue: answers[i],
            onChanged: finished ? null : (v) => setState(() => answers[i] = v),
            title: Text(questions[i].options[j].tr(lang)),
            secondary: finished && j == questions[i].correctIndex ? const Icon(Icons.check_circle, color: Colors.green) : finished && j == answers[i] ? const Icon(Icons.cancel, color: Colors.red) : null,
          ),
          if (finished) Text(questions[i].explanation.tr(lang), style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
        ]))),
        FilledButton.icon(
          onPressed: finished ? () => Navigator.pop(context) : () async {
            setState(() => finished = true);
            await ProgressService().saveExamScore(widget.exam.id, score);
          },
          icon: Icon(finished ? Icons.arrow_back_rounded : Icons.fact_check_rounded),
          label: Text(finished ? 'رجوع' : t('finishExam', lang)),
        ),
      ]),
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.settings});
  final SettingsController settings;
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  TimeOfDay time = const TimeOfDay(hour: 8, minute: 0);
  bool permission = false;
  @override
  Widget build(BuildContext context) {
    final lang = widget.settings.language;
    return ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t('notifications', lang), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Text(lang == 'ar' ? 'فعّل التذكير اليومي لتثبيت عادة التلاوة والتعلم. على الويب تعمل الإشعارات عند HTTPS أو localhost، وعلى الهاتف بعد منح الصلاحية.' : 'Enable daily reminders. Web notifications require HTTPS or localhost; mobile requires permission.'),
        const SizedBox(height: 16),
        Wrap(spacing: 10, runSpacing: 10, children: [
          FilledButton.icon(onPressed: () async {
            final ok = await NotificationService().requestPermission();
            setState(() => permission = ok);
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'تم تفعيل الصلاحية' : 'لم يتم منح الصلاحية')));
          }, icon: const Icon(Icons.lock_open_rounded), label: Text('Permission')),
          OutlinedButton.icon(onPressed: () async => NotificationService().showTest(t('appTitle', lang), 'موعد ورد التجويد اليومي'), icon: const Icon(Icons.notifications_active_rounded), label: Text(t('testNotification', lang))),
          OutlinedButton.icon(onPressed: () async {
            final picked = await showTimePicker(context: context, initialTime: time);
            if (picked != null) setState(() => time = picked);
          }, icon: const Icon(Icons.schedule_rounded), label: Text(time.format(context))),
          FilledButton.icon(onPressed: () async {
            await NotificationService().saveDailyReminder(time.hour, time.minute);
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${t('save', lang)}: ${time.format(context)}')));
          }, icon: const Icon(Icons.save_rounded), label: Text(t('save', lang))),
        ]),
        const SizedBox(height: 12),
        Chip(label: Text(permission ? 'Permission granted' : 'Permission pending')),
      ]))),
    ]);
  }
}

class PublishScreen extends StatelessWidget {
  const PublishScreen({super.key, required this.settings});
  final SettingsController settings;
  @override
  Widget build(BuildContext context) {
    final lang = settings.language;
    final items = [
      'flutter pub get',
      'flutter create --platforms=android,ios,web,windows,macos,linux .',
      'flutter analyze',
      'flutter build web --release',
      'flutter build appbundle --release',
      'flutter build ios --release',
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t('publishReady', lang), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        Text(lang == 'ar' ? 'هذه النسخة Flutter Web/Mobile/Desktop جاهزة كسورس كود للنشر. يمكن بناؤها على جهاز فيه Flutter أو عبر GitHub Actions بدون تثبيت Flutter على جهازك.' : 'This Flutter source is ready for Web/Mobile/Desktop release. Build locally or via GitHub Actions.'),
        const SizedBox(height: 16),
        for (final item in items) Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(14)),
          child: SelectableText(item, textDirection: TextDirection.ltr),
        ),
      ]))),
      ScientificWarning(lang: lang),
    ]);
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Text(text, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
      );
}

class QuranExample extends StatelessWidget {
  const QuranExample(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(.65), borderRadius: BorderRadius.circular(14)),
        child: Directionality(textDirection: TextDirection.rtl, child: Text(text, style: const TextStyle(fontSize: 23, height: 1.7, fontWeight: FontWeight.w700), textAlign: TextAlign.right)),
      );
}

class BulletText extends StatelessWidget {
  const BulletText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('•  ', style: TextStyle(fontWeight: FontWeight.bold)), Expanded(child: Text(text, style: const TextStyle(height: 1.55)))]),
      );
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview({super.key, required this.question, required this.lang});
  final QuizQuestion question;
  final String lang;
  @override
  Widget build(BuildContext context) => ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(question.question.tr(lang), style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          for (var i = 0; i < question.options.length; i++) ListTile(
            dense: true,
            leading: Icon(i == question.correctIndex ? Icons.check_circle_rounded : Icons.circle_outlined, color: i == question.correctIndex ? Colors.green : null),
            title: Text(question.options[i].tr(lang)),
          ),
          Padding(padding: const EdgeInsets.all(8), child: Text(question.explanation.tr(lang), style: const TextStyle(fontWeight: FontWeight.w700))),
        ],
      );
}
