class SearchHit {
  const SearchHit({required this.type, required this.title, required this.snippet, required this.targetId});
  final String type;
  final String title;
  final String snippet;
  final String targetId;
}

class SearchIndexBlueprint {
  List<SearchHit> search(String query) {
    final normalized = query.trim();
    if (normalized.isEmpty) return const [];
    return [
      SearchHit(type: 'rule', title: 'نتيجة تجريبية للأحكام', snippet: 'سيبحث V13 بعد الربط داخل القرآن والأحكام والشروحات والامتحانات.', targetId: normalized),
    ];
  }
}
