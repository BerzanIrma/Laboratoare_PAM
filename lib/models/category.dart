class Category {
  final String id;
  final String name;
  final bool selected;
  final String iconUrl;

  Category({
    required this.id,
    required this.name,
    required this.selected,
    required this.iconUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      selected: json['selected'],
      iconUrl: json['iconUrl'] ?? '',
    );
  }
}