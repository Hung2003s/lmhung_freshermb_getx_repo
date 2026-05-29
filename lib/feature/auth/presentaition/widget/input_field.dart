import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/animation/shake_widget.dart';

import '../../../../../core/common_widget/input/text_input_field.dart';
import '../../../../gen/colors.gen.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool? isShowClearButton;
  final String hint;
  final String title;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final String? errorText;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final Iterable<String>? autoFillHint;
  final GlobalKey<ShakeWidgetState>? shakeKey;

  const InputField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.isShowClearButton,
    required this.hint,
    required this.title,
    this.isPassword,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onSubmitted,
    this.textInputAction,
    this.autoFillHint,
    this.shakeKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        ShakeWidget(
          key: shakeKey,
          child: TextInputFields(
            iconColor: ColorName.orange,
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            textStyle: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            autoFillHint: autoFillHint,
            onSubmitted: onSubmitted,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: keyboardType,
            passwordType: isPassword ?? false,
            onChanged: onChanged,
            controller: controller,
            isShowClearButton: isShowClearButton ?? false,
            hintText: hint,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
