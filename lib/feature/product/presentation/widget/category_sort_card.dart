import 'package:flutter/material.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';

class CategorySortCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CategorySortCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SelectedWidget(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding:const  EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 2,
          )
        ),
        child: Center(
          child: Text(title, style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}
