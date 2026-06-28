# Tajweed Master Pro — Flutter Publish Ready

هذه نسخة Flutter كاملة لتطبيق تعليم أحكام التلاوة والتجويد، مبنية من النسخة السابقة V6/V7/V8 لكن كسورس Flutter حقيقي جاهز للنشر عبر الويب والمتاجر.

## أهم المزايا

- مصحف كامل 114 سورة / 6236 آية بالرسم العثماني داخل `assets/data/quran_uthmani.json`.
- تلوين أحكام التجويد على الحروف والمواضع فقط قدر الإمكان، مع ربط الحروف المتتالية بين كلمتين بنفس اللون.
- شرح تفصيلي عند الضغط على الحكم الملوّن.
- لغات واجهة: عربي، إنجليزي، فرنسي، تركي، إسباني، ألماني.
- الثيم الافتراضي فاتح، واللغة الافتراضية عربية، والخط الافتراضي Arial.
- ثيمات متعددة وخطوط متعددة وشريط علوي دائم لتغيير اللغة والثيم والخط وحجم الخط.
- مكتبة أحكام موسعة.
- دروس منفصلة.
- خطة تعلم 30 يوم.
- مركز امتحانات ونتائج محفوظة محليًا.
- إشعارات Web على HTTPS/localhost وإشعارات أصلية تجريبية على Android/iOS/Desktop عبر flutter_local_notifications.
- ملفات Web PWA داخل `web/`.
- GitHub Actions لبناء Web وAndroid وiOS بدون تثبيت Flutter على جهازك.

## التشغيل المحلي

```bash
flutter pub get
flutter create --platforms=android,ios,web,windows,macos,linux .
flutter run -d chrome
```

## نشر Flutter Web

```bash
flutter build web --release --pwa-strategy offline-first
```

بعدها ارفع محتويات:

```text
build/web
```

إلى Netlify أو Vercel أو GitHub Pages أو أي استضافة Static.

## بناء Android

```bash
flutter create --platforms=android .
flutter build apk --release
flutter build appbundle --release
```

## بناء iOS

يلزم macOS + Xcode + Apple Developer Account عند النشر الحقيقي:

```bash
flutter create --platforms=ios .
flutter build ios --release
```

## ملاحظة علمية مهمة

التلوين الحالي خوارزمي تعليمي. قبل اعتماد التطبيق كتطبيق مصحف تجويد رسمي، يجب مراجعة قاعدة التلوين حرفًا حرفًا من شيخ/مختص أو جهة علمية معتمدة.
