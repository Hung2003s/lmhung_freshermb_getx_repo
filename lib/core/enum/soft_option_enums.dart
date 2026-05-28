import 'package:get/get.dart';

enum SortOption {
  nameAsc, // Tên A -> Z
  nameDesc, // Tên Z -> A
  priceDesc, // Giá Cao -> Thấp
  priceAsc, // Giá Thấp -> Cao
  stockDesc, // Tồn kho Cao -> Thấp
  stockAsc; // Tồn kho Thấp -> Cao

  String get title {
    switch (this) {
      case nameAsc:
        return 'sort_name_asc'.tr;
      case nameDesc:
        return 'sort_name_desc'.tr;
      case priceDesc:
        return 'sort_price_desc'.tr;
      case priceAsc:
        return 'sort_price_asc'.tr;
      case stockAsc:
        return 'sort_stock_asc'.tr;
      case stockDesc:
        return 'sort_stock_desc'.tr;
    }
  }
}
