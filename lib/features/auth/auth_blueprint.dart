/// V13 authentication blueprint.
/// After Firebase setup, connect these methods to FirebaseAuth providers:
/// Google, Apple, Facebook, Email/Password.
class AuthBlueprint {
  Future<void> signInWithGoogle() async => throw UnimplementedError('Enable Firebase first. See docs/FIREBASE_SETUP_AR.md');
  Future<void> signInWithApple() async => throw UnimplementedError('Enable Firebase first. See docs/FIREBASE_SETUP_AR.md');
  Future<void> signInWithFacebook() async => throw UnimplementedError('Enable Firebase first. See docs/FIREBASE_SETUP_AR.md');
  Future<void> signInWithEmail(String email, String password) async => throw UnimplementedError('Enable Firebase first. See docs/FIREBASE_SETUP_AR.md');
}
