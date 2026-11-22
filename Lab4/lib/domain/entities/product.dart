class Product {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: (json['name'] ?? json['title'] ?? '') as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      imageUrl: (json['imageUrl'] ??
          json['mainImageUrl'] ??
          json['thumbnail'] ??
          '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'imageUrl': imageUrl,
    };
  }
}