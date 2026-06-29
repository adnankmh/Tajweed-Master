import '../../core/models/cloud_models.dart';

class CertificateBlueprint {
  String buildVerifyUrl(CertificateRecord cert, {String baseUrl = 'https://adnankmh.github.io/Tajweed-Master/verify'}) {
    return '$baseUrl?code=${Uri.encodeComponent(cert.verifyCode)}';
  }

  String buildPrintableHtml(CertificateRecord cert, String learnerName) {
    final verifyUrl = buildVerifyUrl(cert);
    return '''
<!doctype html><html lang="ar" dir="rtl"><meta charset="utf-8"><title>شهادة إتمام</title>
<body style="font-family:Arial; padding:48px; background:#f8f2df; color:#24312d">
  <div style="border:8px double #b08d32; padding:42px; text-align:center">
    <h1>شهادة إتمام</h1>
    <h2>تجويد ماستر برو</h2>
    <p>تشهد المنصة بأن المتعلم: <strong>$learnerName</strong></p>
    <p>أتم مرحلة: <strong>${cert.stageName}</strong> بنتيجة <strong>${cert.score}%</strong></p>
    <p>رقم الشهادة: ${cert.id}</p>
    <p>رابط التحقق: $verifyUrl</p>
  </div>
</body></html>
''';
  }
}
