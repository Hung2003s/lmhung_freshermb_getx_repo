import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/base_view/base_view.dart';
import 'package:lmhung_freshermb_getx_repo/core/localization/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_controller.dart';

import '../../../core/common_widget/button/selected_widget.dart';
import '../../../core/gen/colors.gen.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseView(
      backgroundColor: theme.scaffoldBackgroundColor,
      buildAppBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          LocaleKeys.settingsTitle.tr,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      buildBody: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(LocaleKeys.theme.tr, context),
              const SizedBox(height: 8),
              _buildThemeSelector(context),
              const SizedBox(height: 24),
              _buildSectionTitle(LocaleKeys.language.tr, context),
              const SizedBox(height: 8),
              _buildLanguageSelector(context),
              const SizedBox(height: 24),
              Obx(
                () => controller.isBiometricAvailable.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(LocaleKeys.security.tr, context),
                          const SizedBox(height: 8),
                          _buildBiometricToggle(context),
                          const SizedBox(height: 24),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              _buildLogoutButton(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showLogoutConfirm(),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorName.orange.withValues(alpha: 0.1),
        foregroundColor: ColorName.orange,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: ColorName.orange.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.logout_rounded, size: 20),
          const SizedBox(width: 8),
          Text(
            LocaleKeys.logout.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorName.orange,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirm() {
    final theme = Theme.of(Get.context!);
    Get.defaultDialog(
      title: '',
      backgroundColor: theme.colorScheme.surface,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Icon(Icons.logout_rounded, size: 48, color: ColorName.error),
            const SizedBox(height: 16),
            Text(
              LocaleKeys.logoutConfirm.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          LocaleKeys.cancel.tr,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            fontSize: 16,
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () {
          Get.back();
          controller.logout();
        },
        child: Text(
          LocaleKeys.logout.tr,
          style: TextStyle(
            color: ColorName.error,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: context.theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            _buildThemeOption(
              context: context,
              icon: Icons.brightness_auto_rounded,
              title: LocaleKeys.systemMode.tr,
              subtitle: LocaleKeys.systemModeDesc.tr,
              isSelected: controller.isSystemMode,
              onTap: () => controller.setThemeMode(ThemeMode.system),
            ),
            _buildDivider(theme),
            _buildThemeOption(
              context: context,
              icon: Icons.light_mode_rounded,
              title: LocaleKeys.lightMode.tr,
              subtitle: LocaleKeys.lightModeDesc.tr,
              isSelected: controller.isLightMode,
              onTap: () => controller.setThemeMode(ThemeMode.light),
            ),
            _buildDivider(theme),
            _buildThemeOption(
              context: context,
              icon: Icons.dark_mode_rounded,
              title: LocaleKeys.darkMode.tr,
              subtitle: LocaleKeys.darkModeDesc.tr,
              isSelected: controller.isDarkMode,
              onTap: () => controller.setThemeMode(ThemeMode.dark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return SelectedWidget(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorName.orange.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? ColorName.orange
                    : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: ColorName.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            _buildLanguageOption(
              context: context,
              flag: '🇻🇳',
              title: LocaleKeys.vietnamese.tr,
              subtitle: 'Vietnamese',
              isSelected: controller.currentLanguageCode == 'vi',
              onTap: () => controller.setLanguage('vi'),
            ),
            _buildDivider(theme),
            _buildLanguageOption(
              context: context,
              flag: '🇺🇸',
              title: LocaleKeys.english.tr,
              subtitle: 'Tiếng Anh',
              isSelected: controller.currentLanguageCode == 'en',
              onTap: () => controller.setLanguage('en'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String flag,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return SelectedWidget(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: ColorName.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
    );
  }

  Widget _buildBiometricToggle(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: SelectedWidget(
        onTap: () => controller.toggleBiometric(),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: controller.isBiometricEnabled.value
                      ? ColorName.orange.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.fingerprint,
                  color: controller.isBiometricEnabled.value
                      ? ColorName.orange
                      : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.biometric.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      controller.isBiometricEnabled.value
                          ? LocaleKeys.biometricEnabledDesc.tr
                          : LocaleKeys.biometricDisabledDesc.tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: controller.isBiometricEnabled.value,
                onChanged: (_) => controller.toggleBiometric(),
                activeThumbColor: ColorName.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
