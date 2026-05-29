import 'package:get/get.dart';
import 'vi.dart';
import 'en.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {...Vi().keys, ...En().keys};
}
