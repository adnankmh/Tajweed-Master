// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:js_util' as js_util;

class PwaInstallService {
  static Future<bool> promptInstall() async {
    try {
      final fn = js_util.getProperty(html.window, 'tajweedPromptInstall');
      if (fn == null) return false;
      final result = js_util.callMethod(html.window, 'tajweedPromptInstall', []);
      if (result is bool) return result;
      if (result != null) {
        final value = await js_util.promiseToFuture<dynamic>(result);
        return value == true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
