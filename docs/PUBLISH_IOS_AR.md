# بناء ونشر iOS

بناء iPhone/iPad يحتاج macOS و Xcode. يمكن تشغيل Workflow `Build iOS No-Codesign` للتأكد من أن المشروع يبنى بدون توقيع.

للنشر الحقيقي في App Store تحتاج:

- Apple Developer Account.
- Bundle Identifier نهائي.
- Certificates و Provisioning Profiles.
- توقيع من Xcode أو Codemagic/Bitrise/GitHub Actions مع secrets.

أمر البناء:

```bash
flutter create --platforms=ios .
flutter build ios --release
```
