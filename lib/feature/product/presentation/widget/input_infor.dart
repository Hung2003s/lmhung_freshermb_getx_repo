import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common_widget/input/text_input_field.dart';
import '../../../../gen/colors.gen.dart';

class InputInfor extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool? isShowClearButton;
  final String hint;
  final String title;
  final TextInputType? keyboardType;
  final String? errorText;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final int maxLine;
  final bool enable;

  const InputInfor({
    super.key,
    required this.controller,
    required this.onChanged,
    this.isShowClearButton,
    required this.hint,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.errorText, this.onSubmitted, this.textInputAction,
    this.maxLine = 1,
    required this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextInputFields(
          readOnly: enable,
          maxLine: maxLine,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600,
              color: Colors.white
          ),
          onSubmitted: onSubmitted,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType,
          onChanged: onChanged,
          controller: controller,
          isShowClearButton: isShowClearButton ?? false,
          hintText: hint,
          hintTextStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          errorText: errorText,
        ),
      ],
    );
  }
}
