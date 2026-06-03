import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';

import '../../../../core/gen/colors.gen.dart';

class CategorySortCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const CategorySortCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(Get.context!);
    return SelectedWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected
                      ? ColorName.orange
                      : theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_rounded, color: ColorName.orange),
          ],
        ),
      ),
    );
  }
}
