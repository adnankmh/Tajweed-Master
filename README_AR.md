# Tajweed Master Pro — V13 Enterprise Foundation

هذه نسخة V13 المؤسسية من تطبيق تجويد ماستر برو. تم تجهيزها لتكون أساسًا قويًا للتطبيق التجاري العالمي قبل بناء Android/iOS النهائي.

## ما الجديد في V13؟

### 1) Firebase Ready
تمت إضافة بنية كاملة للربط مع:

- Firebase Auth
- Firestore
- Storage
- Hosting
- Cloud Functions

الملفات موجودة داخل:

```text
firebase/
cloud_functions/
docs/FIREBASE_SETUP_AR.md
```

> لا يمكن تشغيل Firebase الحقيقي بدون مفاتيح مشروعك الخاصة. النسخة الحالية تعمل Local/Fallback وتحافظ على نجاح GitHub Actions، وبعد إضافة إعدادات Firebase يتم تفعيل السحابة.

### 2) لوحة إدارة مستقلة
تمت إضافة لوحة إدارة قابلة للنشر على:

```text
admin.tajweedmaster.com
```

المسار:

```text
admin_panel/index.html
```

وتحتوي على:
- إدارة المستخدمين
- إدارة الأسئلة
- إدارة الدروس
- إدارة الامتحانات
- إدارة القراء
- إدارة الإشعارات
- إدارة الأخبار
- الشهادات
- تحليل التلاوة AI
- تصدير/استيراد JSON

تسجيل دخول تجريبي:

```text
UserName: Adnan
Password: Adnan123
```

### 3) إعادة هيكلة احترافية
تمت إضافة مجلدات Enterprise:

```text
lib/core
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

### 4) نظام حسابات — Blueprint
جاهز لربط:
- Google
- Apple
- Facebook
- Email/Password

الملف:

```text
lib/features/auth/auth_blueprint.dart
```

### 5) شهادات PDF/QR — Blueprint
الملفات:

```text
lib/features/certificates/certificate_blueprint.dart
cloud_functions/functions/src/index.ts
```

### 6) الذكاء الاصطناعي للتلاوة — Pipeline
تم تجهيز المسار:

```text
Flutter -> Storage -> Cloud Function -> AI Engine -> Firestore -> Flutter UI
```

الملف:

```text
docs/AI_RECITATION_PIPELINE_AR.md
```

### 7) الإحصائيات والألعاب
تم تجهيز:
- نقاط
- مستويات
- شارات
- Leaderboard schema
- Progress model

الملف:

```text
lib/features/gamification/gamification_engine.dart
```

### 8) تحميل الصوت Offline — Blueprint
الملف:

```text
lib/features/offline_audio/offline_audio_blueprint.dart
```

### 9) البحث الشامل — Blueprint
الملف:

```text
lib/features/search/search_index_blueprint.dart
```

## طريقة الرفع إلى GitHub

ارفع ملفات V13 كلها فوق المستودع الحالي:

```text
Code > Add file > Upload files
```

ثم انتظر GitHub Actions.

## ملاحظة مهمة
هذه نسخة Enterprise Foundation: تبني الأساس الحقيقي للتطبيق العالمي، لكنها لا تربط Firebase فعليًا إلا بعد أن تضيف إعدادات مشروع Firebase الخاص بك. هذا مقصود حتى لا يفشل البناء على GitHub.
