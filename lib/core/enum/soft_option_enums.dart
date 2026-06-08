import 'locale_keys.dart';

enum SortOption {
  nameAsc, // Tên A -> Z
  nameDesc, // Tên Z -> A
  priceDesc, // Giá Cao -> Thấp
  priceAsc, // Giá Thấp -> Cao
  stockDesc, // Tồn kho Cao -> Thấp
  stockAsc; // Tồn kho Thấp -> Cao

  LocaleKeys get localeKey {
    switch (this) {
      case nameAsc:
        return LocaleKeys.sortNameAsc;
      case nameDesc:
        return LocaleKeys.sortNameDesc;
      case priceDesc:
        return LocaleKeys.sortPriceDesc;
      case priceAsc:
        return LocaleKeys.sortPriceAsc;
      case stockAsc:
        return LocaleKeys.sortStockAsc;
      case stockDesc:
        return LocaleKeys.sortStockDesc;
    }
  }

  String get title => localeKey.tr;
}
