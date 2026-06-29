class V13FeatureFlags {
  const V13FeatureFlags._();

  /// Keeps the production build green before Firebase keys are added.
  /// Switch to true after completing docs/FIREBASE_SETUP_AR.md.
  static const bool firebaseEnabled = false;

  /// Shows local admin tools inside the app while the cloud admin portal is being configured.
  static const bool localAdminFallbackEnabled = true;

  /// AI recitation analysis needs a server/Cloud Function; the UI pipeline is prepared.
  static const bool aiRecitationServerEnabled = false;

  /// Offline audio download is prepared as a product flow. Native/mobile storage setup is in docs/OFFLINE_AUDIO_AR.md.
  static const bool offlineAudioDownloadEnabled = false;
}
