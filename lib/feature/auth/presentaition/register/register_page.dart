import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/navigation_bar/custom_app_bar.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/presentaition/register/register_controller.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';
import '../../../../core/common_widget/base_view/base_view.dart';
import '../../../../core/common_widget/button/selected_widget.dart';
import '../../../../gen/assets.gen.dart';
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
        Text('welcome_back'.tr, style: context.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('register_title'.tr, style: context.textTheme.titleSmall),
        const SizedBox(height: 24),
        InputField(
          isShowClearButton: true,
          controller: controller.userNameController,
          onChanged: (value) {
            controller.userNameText.value = value;
          },
          hint: 'username'.tr,
          title: 'username'.tr,
          // errorText: controller.showError ? state.userNameError : null,
        ),
        const SizedBox(height: 4),
        InputField(
          isPassword: true,
          controller: controller.passwordController,
          onChanged: (value) {
            controller.passwordText.value = value;
          },
          hint: 'password'.tr,
          title: 'password'.tr,
          textInputAction: TextInputAction.done,
          // errorText: state.showError ? state.passwordError : null,
          onSubmitted: (value) {
            controller.register();
          },
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
                'register'.tr,
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
              'or_register_with'.tr,
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
              title: 'help'.tr,
              icons: Assets.icons.headphone.svg(width: 20),
            ),
            const SizedBox(width: 16),
            FeatureButton(
              onTap: () {},
              title: 'Group',
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
        const SizedBox(height: 16),
      ],
    );
  }
}
