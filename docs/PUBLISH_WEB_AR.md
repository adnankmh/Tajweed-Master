# نشر التطبيق على الإنترنت كـ Flutter Web

1. ارفع المشروع إلى GitHub.
2. افتح تبويب Actions.
3. شغّل Workflow باسم `Build Flutter Web`.
4. بعد نجاح البناء، ستجد Artifact باسم `tajweed-master-pro-web`.
5. يمكن أيضًا تفعيل GitHub Pages من Settings > Pages وربطها بـ GitHub Actions.

أوامر البناء اليدوي:

```bash
flutter pub get
flutter create --platforms=web .
flutter build web --release --pwa-strategy offline-first
```

مجلد النشر النهائي:

```text
build/web
```
