import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../../../../core/common_widget/button/selected_widget.dart';

class FeatureButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Widget icons;

  const FeatureButton({
    super.key,
    this.onTap,
    required this.title,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.theme.colorScheme.primary, width: 2),
      ),
      child: SelectedWidget(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: icons,
        ),
      ),
    );
  }
}
