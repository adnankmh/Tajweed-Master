# هيكلة V13 Enterprise

تم تجهيز المشروع ليخرج تدريجيًا من ملف `main.dart` الضخم إلى هيكلة تجارية:

```text
lib/core/config
lib/core/models
lib/core/services
lib/core/repositories
lib/core/widgets
lib/features/auth
lib/features/admin_panel
lib/features/certificates
lib/features/gamification
lib/features/recitation_ai
lib/features/offline_audio
lib/features/search
lib/features/statistics
lib/features/cloud_sync
```

## الفكرة
- `core`: خدمات عامة ونماذج وعقود Repository.
- `features`: كل ميزة في مجلد مستقل.
- `admin_panel`: لوحة الإدارة المستقلة.
- `firebase`: قواعد وسكيما السحابة.
- `cloud_functions`: منطق الشهادات والتحقق والتحليل الصوتي.

## لماذا هذا مهم؟
حتى لا يصبح التطبيق ملفًا واحدًا يصعب تطويره، وحتى يمكن لاحقًا إضافة Android/iOS وFirebase وAI بدون كسر التطبيق.
