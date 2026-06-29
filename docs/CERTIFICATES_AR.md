# نظام الشهادات V13

بعد إنهاء كل مرحلة بنتيجة 80% أو أكثر يمكن إصدار شهادة تحتوي:

- اسم المتعلم
- اسم المرحلة
- النتيجة
- رقم شهادة
- QR / رابط تحقق

## الملفات الجاهزة

```text
lib/features/certificates/certificate_blueprint.dart
cloud_functions/functions/src/index.ts
```

## التحقق
الدالة:

```text
verifyCertificate
```

تبحث عن رقم الشهادة في Firestore وتعيد حالة التحقق.
