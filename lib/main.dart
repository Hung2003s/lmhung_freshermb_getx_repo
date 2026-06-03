import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/core/localization/app_translations.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/app_theme.dart';

import 'core/di/app_binding.dart';
import 'core/navigation/app_routers.dart';
import 'core/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Locale _getSavedLocale() {
    final box = GetStorage();
    final languageCode = box.read<String>(Constants.languageCodeKey);
    if (languageCode != null) {
      return Locale(languageCode, languageCode == 'vi' ? 'VN' : 'US');
    }
    return const Locale('vi', 'VN');
  }

  ThemeMode _getSavedThemeMode() {
    final box = GetStorage();
    final themeMode = box.read<String>(Constants.themeModeKey);
    if (themeMode != null) {
      switch (themeMode) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        default:
          return ThemeMode.system;
      }
    }
    return ThemeMode.system;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: Routes.splash,
      getPages: AppRouters.routes,
      translations: AppTranslations(),
      locale: _getSavedLocale(),
      fallbackLocale: const Locale('en', 'US'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _getSavedThemeMode(),
    );
  }
}
