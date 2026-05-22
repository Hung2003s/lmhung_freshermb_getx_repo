import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/base_view/base_view.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/loading/bouncing_loading_widget.dart';
import 'package:lmhung_freshermb_getx_repo/feature/splash/splash_controller.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../../gen/assets.gen.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      resizeToAvoidBottomInset: true,
      safeAreaBottom: true,
      safeAreaTop: true,
      backgroundColor: Colors.black,
      buildBody: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          logoAndSlogan(),
          footer(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Column footer() {
    return Column(
          children: [
            BouncingLoadingWidget(color: ColorName.orange),
            const SizedBox(height: 16),
            const Text(
              'Initializing workspace',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            // RoundedButton(
            //     onPressed: () {
            //
            //     },
            //     title: 'Chạm để tiếp tục'),
          ],
        );
  }

  Column logoAndSlogan() {
    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Assets.images.appLogo.image(),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: 'Warehouse'),
                  TextSpan(
                    text: 'Pro',
                    style: TextStyle(
                      color: ColorName.orange,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Supply & Inventory',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                color: ColorName.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const SizedBox.shrink(),
            ),
          ],
        );
  }
}
