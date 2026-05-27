import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/navigation_bar/custom_app_bar.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';
import '../../../../core/common_widget/base_view/base_view.dart';
import '../../../../core/common_widget/button/selected_widget.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../navigation/routes.dart';
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
        Text('Chào mừng trở lại',
            style: context.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Đăng nhập để quản lý kho của bạn',
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(height: 24),
        InputField(
          isShowClearButton: true,
          controller: controller.userNameController,
          onChanged: (value) {
            controller.userNameText.value = value;
          },
          hint: 'Tài khoản',
          title: 'Tài khoản',
          // errorText: controller.showError ? state.userNameError : null,
        ),
        const SizedBox(height: 4),
        InputField(
          isPassword: true,
          controller: controller.passwordController,
          onChanged: (value) {
            controller.passwordText.value = value;
          },
          hint: 'Mật khẩu',
          title: 'Mật khẩu',
          textInputAction: TextInputAction.done,
          // errorText: state.showError ? state.passwordError : null,
          onSubmitted: (value) {
            controller.login();
          },
        ),
        Container(
          alignment: Alignment.centerRight,
          child: SelectedWidget(
            onTap: () {},
            child: Text(
              'Quên mật khẩu?',
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
        SelectedWidget(
          onTap: () {
            controller.login();
          },
          backgroundColor: ColorName.orange,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                TextSpan(text: "Chưa có tài khoản?"),
                TextSpan(
                  text: "Đăng ký",
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
                decoration: BoxDecoration(
                  color: ColorName.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Hoặc đăng nhập với',
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
                decoration: BoxDecoration(
                  color: ColorName.primary,
                ),
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
              title: 'Trợ giúp',
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
                TextSpan(text: "Cần trợ giúp?"),
                TextSpan(
                  text: "Liên hệ hỗ trợ",
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
