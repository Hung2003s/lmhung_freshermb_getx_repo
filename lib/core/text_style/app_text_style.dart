import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle buttonTitle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  //heading
  static const TextStyle headline = TextStyle(
    color: ColorName.gray,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle heading2 = TextStyle(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle heading3 = TextStyle(
    color: ColorName.gray,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle heading4 = TextStyle(
    color: ColorName.gray,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle heading6 = TextStyle(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle heading7 = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  //text_file
  static const TextStyle hint = TextStyle(
    color: ColorName.gray,
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  //title
  static const TextStyle title3 = TextStyle(
    color: Colors.red,
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  //body
  static const TextStyle bodyMedium = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bodySmall = TextStyle(
    color: ColorName.gray,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  //caption
  static const TextStyle captionLarge = TextStyle(
    color: ColorName.gray,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle caption2 = TextStyle(
    color: ColorName.gray,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle captionSmall = TextStyle(
    color: ColorName.gray,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle captionMedium = TextStyle(
    color: ColorName.gray,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
