# تحميل الصوت للعمل بدون إنترنت

النسخة الحالية تشغل الصوت من الإنترنت. في V13 تم وضع Blueprint للتحميل داخل:

```text
lib/features/offline_audio/offline_audio_blueprint.dart
```

## للتفعيل الحقيقي على Android/iOS
أضف لاحقًا:

```bash
flutter pub add path_provider dio permission_handler
```

ثم خزن ملفات السور حسب:

```text
reciters/{reciterId}/surah_{number}.mp3
```

## ملاحظة Web
المتصفح له قيود في التخزين، لذلك يفضّل Cache API أو IndexedDB للويب، وملفات الجهاز للتطبيق الأصلي.
