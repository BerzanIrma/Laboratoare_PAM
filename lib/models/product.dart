class Product {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'],
      imageUrl: json['imageUrl'],
    );
  }
}