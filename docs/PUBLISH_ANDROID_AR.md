# بناء ونشر Android

## عبر GitHub Actions بدون Flutter على جهازك

1. ارفع المشروع إلى GitHub.
2. افتح Actions.
3. شغّل `Build Android APK and AAB`.
4. حمل Artifact الناتج، وستجد APK و AAB.

## محليًا

```bash
flutter create --platforms=android .
flutter pub get
flutter build apk --release
flutter build appbundle --release
```

للنشر على Google Play تحتاج:

- حساب Google Play Console.
- App Bundle بصيغة AAB.
- توقيع release keystore.
- Screenshots.
- سياسة خصوصية.
- وصف التطبيق.
- مراجعة علمية لمحتوى التجويد.
