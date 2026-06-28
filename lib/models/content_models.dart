import 'package:flutter/material.dart';

class LocalText {
  const LocalText(this.values);
  final Map<String, String> values;
  String tr(String lang) => values[lang] ?? values['ar'] ?? values.values.first;
}

class TajweedRule {
  const TajweedRule({
    required this.id,
    required this.color,
    required this.title,
    required this.short,
    required this.deep,
    required this.examples,
    required this.commonMistakes,
    required this.questions,
    required this.category,
  });

  final String id;
  final Color color;
  final LocalText title;
  final LocalText short;
  final LocalText deep;
  final List<String> examples;
  final List<LocalText> commonMistakes;
  final List<QuizQuestion> questions;
  final String category;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.order,
    required this.title,
    required this.summary,
    required this.sections,
    required this.examples,
    required this.questions,
    required this.relatedRuleIds,
  });

  final String id;
  final int order;
  final LocalText title;
  final LocalText summary;
  final List<LessonSection> sections;
  final List<String> examples;
  final List<QuizQuestion> questions;
  final List<String> relatedRuleIds;
}

class LessonSection {
  const LessonSection({required this.heading, required this.body});
  final LocalText heading;
  final LocalText body;
}

class LearningDay {
  const LearningDay({
    required this.day,
    required this.title,
    required this.objective,
    required this.body,
    required this.examples,
    required this.tasks,
    required this.questions,
  });

  final int day;
  final LocalText title;
  final LocalText objective;
  final LocalText body;
  final List<String> examples;
  final List<LocalText> tasks;
  final List<QuizQuestion> questions;
}

class Exam {
  const Exam({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.minutes,
    required this.questions,
  });

  final String id;
  final LocalText title;
  final LocalText description;
  final String level;
  final int minutes;
  final List<QuizQuestion> questions;
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.reference,
  });

  final String id;
  final LocalText question;
  final List<LocalText> options;
  final int correctIndex;
  final LocalText explanation;
  final String? reference;
}

class HighlightSegment {
  const HighlightSegment({required this.start, required this.end, required this.rule});
  final int start;
  final int end;
  final TajweedRule rule;
}
