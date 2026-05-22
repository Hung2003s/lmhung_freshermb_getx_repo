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
        return 'Tên: A -> Z';
      case nameDesc:
        return 'Tên: Z -> A';
      case priceDesc:
        return 'Giá: Cao -> Thấp';
      case priceAsc:
        return 'Giá: Thấp -> Cao';
      case stockAsc:
        return 'Số lượng: Thấp -> Cao';
      case stockDesc:
        return 'Số lượng: Cao -> Thấp';
    }
  }
}
