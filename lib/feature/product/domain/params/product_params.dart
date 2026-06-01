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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      if (price != null) 'price': price,
      if (stock != null) 'stock': stock,
      if (category != null) 'category_id': category,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
    };
  }
}
