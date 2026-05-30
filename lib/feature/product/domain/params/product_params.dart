class ProductInfoParam {
  final String name;
  final String code;
  final double? price;
  final int? stock;
  final int? category;
  final String? description;
  final String? image;

  const ProductInfoParam({
    required this.name,
    required this.code,
    this.price,
    this.stock,
    this.category,
    this.description,
    this.image,
  });
}
