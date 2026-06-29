class OfflineAudioBlueprint {
  /// Native implementation should use path_provider + dio/http + storage permissions.
  /// Kept as a blueprint to avoid breaking the current web build.
  Future<void> downloadSurah({required int surah, required String reciterId}) async {
    throw UnimplementedError('Enable native offline audio service after Android/iOS build setup.');
  }
}
