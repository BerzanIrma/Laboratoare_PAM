class Category {
  final String id;
  final String name;
  final bool selected;
  final String iconUrl;

  const Category({
    required this.id,
    required this.name,
    required this.selected,
    required this.iconUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      selected: json['selected'] as bool? ?? false,
      iconUrl: json['iconUrl'] as String? ?? '',
    );
  }
}