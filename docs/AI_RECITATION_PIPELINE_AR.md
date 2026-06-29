# مسار تحليل التلاوة بالذكاء الاصطناعي

الميزة المطلوبة:
يرفع المستخدم تسجيلًا لصوته، ثم تظهر له:

- نسبة صحة التلاوة
- مواضع الأخطاء
- نوع الخطأ: إخفاء، غنة، مد، قلقلة، تفخيم، ترقيق
- شرح الخطأ وتدريب مقترح

## المسار التقني المقترح

```text
Flutter App -> Firebase Storage -> Cloud Function -> AI/ASR Engine -> Tajweed Rule Engine -> Firestore Result -> Flutter Highlight UI
```

## Cloud Function جاهزة كبداية

```text
cloud_functions/functions/src/index.ts
```

الدالة:

```text
analyzeRecitationPlaceholder
```

جاهزة للربط بخادم AI لاحقًا.

## ملاحظة دقة شرعية
تحليل التلاوة آليًا يحتاج مراجعة علمية قوية. لا يجوز تقديمه للمستخدم على أنه حكم نهائي دون تنبيه أنه مساعد تعليمي.
