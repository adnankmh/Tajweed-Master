# إعداد Firebase لتجويد ماستر برو V13

هذه النسخة جاهزة معماريًا للربط مع Firebase، لكنها لا تحتوي مفاتيح مشروعك الخاصة. لا يمكن لأي نسخة أن تتصل بـ Firestore/Auth/Storage بدون إنشاء مشروع Firebase وإضافة إعداداته.

## 1) إنشاء مشروع Firebase
1. افتح Firebase Console.
2. أنشئ مشروعًا باسم: `tajweed-master-pro`.
3. فعّل:
   - Authentication
   - Firestore Database
   - Storage
   - Hosting
   - Functions إذا أردت الشهادات وAI لاحقًا.

## 2) Authentication
فعّل مزودي الدخول:
- Email/Password
- Google
- Apple
- Facebook

مهم: Apple/Facebook يحتاجان إعدادات من حساب المطور الخاص بكل منصة.

## 3) Firestore Collections
الهيكل المقترح:

```text
public_config/app
lessons/{lessonId}
rules/{ruleId}
questions/{questionId}
exams/{examId}
reciters/{reciterId}
news/{newsId}
users/{userId}
users/{userId}/progress/{progressId}
users/{userId}/certificates/{certificateId}
leaderboards/{boardId}/entries/{userId}
admin_logs/{logId}
```

## 4) Security Rules
استخدم الملفات:

```text
firebase/firestore.rules
firebase/storage.rules
firebase/firestore.indexes.json
```

## 5) Firebase Hosting
الملف الجاهز:

```text
firebase/firebase.json
```

يمكنك جعل:
- التطبيق: `app.tajweedmaster.com`
- الإدارة: `admin.tajweedmaster.com`

## 6) FlutterFire
بعد تثبيت Flutter محليًا أو داخل GitHub Actions، نفّذ:

```bash
flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage google_sign_in
flutterfire configure
```

ثم فعّل الملفات الموجودة في `lib/core` واربطها مع `firebase_options.dart`.

## 7) ملاحظة مهمة
لا أضع مفاتيح Firebase داخل المشروع هنا لأنها خاصة بحسابك. بعد إضافتها، تصبح الإدارة والشروحات والأسئلة والقراء قابلة للتعديل من السحابة دون إصدار نسخة جديدة.
