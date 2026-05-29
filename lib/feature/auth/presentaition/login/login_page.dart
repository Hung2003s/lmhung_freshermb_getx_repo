import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/navigation_bar/custom_app_bar.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';
import '../../../../core/common_widget/base_view/base_view.dart';
import '../../../../core/common_widget/button/selected_widget.dart';
import '../../../../gen/assets.gen.dart';
import '../widget/feature_button.dart';
import '../widget/input_field.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      extendBodyBehindAppBar: true,
      tapOutsideToDismissKeyboard: true,
      resizeToAvoidBottomInset: false,
      buildAppBar: CustomAppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        titleWidget: RichText(
          text: TextSpan(
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'WH',
                style: TextStyle(
                  color: ColorName.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(text: 'Pro'),
            ],
          ),
        ),
      ),
      buildBody: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          final scale = (screenHeight / 800).clamp(0.7, 1.2);
          final isTablet = screenWidth > 600;
          final horizontalPadding = isTablet ? screenWidth * 0.15 : 12.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 12 * scale,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight - 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  loginContent(context, scale),
                  loginFooter(context, scale),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column loginContent(BuildContext context, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('welcome_back'.tr, style: context.textTheme.headlineSmall),
        SizedBox(height: 8 * scale),
        Text('login_description'.tr, style: context.textTheme.titleSmall),
        SizedBox(height: 24 * scale),
        AutofillGroup(
          child: Column(
            children: [
              Obx(
                () => InputField(
                  shakeKey: controller.userNameShakeKey.value,
                  isShowClearButton: true,
                  controller: controller.userNameController,
                  onChanged: (value) {
                    controller.userNameText.value = value;
                  },
                  hint: 'username'.tr,
                  title: 'username'.tr,
                  errorText: controller.displayedUserNameError,
                  autoFillHint: const [AutofillHints.username],
                ),
              ),
              SizedBox(height: 4 * scale),
              Obx(
                () => InputField(
                  shakeKey: controller.passwordShakeKey.value,
                  isPassword: true,
                  controller: controller.passwordController,
                  onChanged: (value) {
                    controller.passwordText.value = value;
                  },
                  hint: 'password'.tr,
                  title: 'password'.tr,
                  errorText: controller.displayedPasswordError,
                  textInputAction: TextInputAction.done,
                  autoFillHint: const [AutofillHints.password],
                  onSubmitted: (value) {
                    controller.login();
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8 * scale),
        Container(
          alignment: Alignment.centerRight,
          child: SelectedWidget(
            onTap: () {},
            child: Text(
              'forgot_password'.tr,
              style: TextStyle(
                fontSize: 14,
                color: ColorName.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget loginFooter(BuildContext context, double scale) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Obx(
          () => SelectedWidget(
            rippleColor: Colors.grey,
            highlightColor: Colors.grey,
            borderRadius: BorderRadius.circular(16),
            onTap: controller.isLocked.value || controller.isLoading.value
                ? null
                : () => controller.login(),
            backgroundColor: controller.isLocked.value
                ? Colors.grey
                : ColorName.orange,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16 * scale,
                horizontal: 16,
              ),
              child: Center(
                child: !controller.isLoading.value
                    ? Text(
                        controller.isLocked.value
                            ? 'login_locked_button'.tr
                            : 'login'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
              ),
            ),
          ),
        ),
        if (controller.isLocked.value)
          Padding(
            padding: EdgeInsets.only(top: 8 * scale),
            child: Obx(
              () => Text(
                controller.lockoutMessage.value,
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        SizedBox(height: 12 * scale),
        SelectedWidget(
          onTap: () => controller.navigateToRegister(),
          child: FittedBox(
            child: RichText(
              text: TextSpan(
                style: context.textTheme.labelLarge,
                children: [
                  TextSpan(text: "no_account".tr),
                  TextSpan(
                    text: "register".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorName.orange,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () =>
              controller.isBiometricAvailable.value &&
                  controller.isBiometricEnabled.value
              ? Column(
                  children: [
                    SizedBox(height: 16 * scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(color: ColorName.primary),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or_login_with'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: ColorName.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(color: ColorName.primary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * scale),
                    _buildBiometricLoginButton(context, scale),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        SizedBox(height: 16 * scale),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FeatureButton(
                title: 'help'.tr,
                icons: Assets.icons.headphone.svg(width: 20),
              ),
              SizedBox(width: screenWidth * 0.04),
              FeatureButton(
                title: 'group'.tr,
                icons: Assets.icons.icon.svg(width: 20),
              ),
            ],
          ),
        ),
        SizedBox(height: 16 * scale),
        SelectedWidget(
          onTap: () {},
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.4),
                decoration: TextDecoration.underline,
              ),
              children: [
                TextSpan(text: "need_help".tr),
                TextSpan(
                  text: "contact_support".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24 * scale),
      ],
    );
  }

  Widget _buildBiometricLoginButton(BuildContext context, double scale) {
    return SelectedWidget(
      borderRadius: BorderRadius.circular(16),
      onTap: controller.isLoading.value
          ? null
          : () => controller.loginWithBiometric(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14 * scale),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ColorName.orange.withValues(alpha: 0.5),
            width: 1.5,
          ),
          color: ColorName.orange.withValues(alpha: 0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint, size: 24, color: ColorName.orange),
            const SizedBox(width: 12),
            Text(
              'biometric_login'.trParams({
                's': controller.biometricTypeName.value,
              }),
              style: const TextStyle(
                color: ColorName.orange,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
