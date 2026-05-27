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
        leading:SizedBox(),
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
        Text(
          'login_description'.tr,
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(height: 24),
        AutofillGroup(
          child: Column(
            children: [
              InputField(
                isShowClearButton: true,
                controller: controller.userNameController,
                onChanged: (value) {
                  controller.userNameText.value = value;
                },
                hint: 'username'.tr,
                title: 'username'.tr,
                autoFillHint: const [AutofillHints.username],
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
                autoFillHint: const [AutofillHints.password],
                // errorText: state.showError ? state.passwordError : null,
                onSubmitted: (value) {
                  controller.login();
                },
              ),
            ],
          ),
        ),

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

  Widget loginFooter(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => SelectedWidget(
          rippleColor: Colors.grey,
          highlightColor: Colors.grey,
          borderRadius: BorderRadius.circular(16),
          onTap: controller.isLocked.value ? null : controller.isLoading.value ?  null : () {
            controller.login();
          },
          backgroundColor: controller.isLocked.value ? Colors.grey : ColorName.orange,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Center(
              child: (!controller.isLoading.value) ? Text(
                controller.isLocked.value ? 'login_locked_button'.tr : 'login'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ) : const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
        ),
        // Show lockout message if locked
        if (controller.isLocked.value)
          Padding(
            padding: const EdgeInsets.only(top: 8),
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
        const SizedBox(height: 8),
        SelectedWidget(
          onTap: () {
            controller.navigateToRegister();
          },
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
              'or_login_with'.tr,
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
              title: 'help'.tr,
              icons: Assets.icons.headphone.svg(width: 20),
            ),
            const SizedBox(width: 16),
            FeatureButton(
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