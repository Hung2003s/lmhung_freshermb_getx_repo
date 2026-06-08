import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/navigation_bar/custom_app_bar.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/presentation/register/register_controller.dart';
import '../../../../core/common_widget/base_view/base_view.dart';
import '../../../../core/common_widget/button/selected_widget.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/gen/colors.gen.dart';
import '../widget/feature_button.dart';
import '../widget/input_field.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      extendBodyBehindAppBar: true,
      tapOutsideToDismissKeyboard: true,
      resizeToAvoidBottomInset: false,
      buildAppBar: CustomAppBar(
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
      buildBody: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [loginContent(context), loginFooter(context)],
        ),
      ),
    );
  }

  Column loginContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(LocaleKeys.welcomeBack.tr, style: context.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(LocaleKeys.registerTitle.tr, style: context.textTheme.titleSmall),
        const SizedBox(height: 24),
        Obx(
          () => InputField(
            shakeKey: controller.userNameShakeKey.value,
            isShowClearButton: true,
            controller: controller.userNameController,
            onChanged: (value) {
              controller.userNameText.value = value;
            },
            hint: LocaleKeys.username.tr,
            title: LocaleKeys.username.tr,
            errorText: controller.displayedUserNameError,
          ),
        ),
        const SizedBox(height: 4),
        Obx(
          () => InputField(
            shakeKey: controller.passwordShakeKey.value,
            isPassword: true,
            controller: controller.passwordController,
            onChanged: (value) {
              controller.passwordText.value = value;
            },
            hint: LocaleKeys.password.tr,
            title: LocaleKeys.password.tr,
            errorText: controller.displayedPasswordError,
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              controller.register();
            },
          ),
        ),
      ],
    );
  }

  Widget loginFooter(BuildContext context) {
    return Column(
      children: [
        SelectedWidget(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            controller.register();
          },
          backgroundColor: ColorName.orange,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                LocaleKeys.register.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(color: ColorName.primary),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              LocaleKeys.orRegisterWith.tr,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorName.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(color: ColorName.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeatureButton(
              onTap: () {},
              title: LocaleKeys.help.tr,
              icons: Assets.icons.headphone.svg(width: 20),
            ),
            const SizedBox(width: 16),
            FeatureButton(
              onTap: () {},
              title: LocaleKeys.group.tr,
              icons: Assets.icons.icon.svg(width: 20),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
                TextSpan(text: LocaleKeys.needHelp.tr),
                TextSpan(
                  text: LocaleKeys.contactSupport.tr,
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
        const SizedBox(height: 16),
      ],
    );
  }
}
