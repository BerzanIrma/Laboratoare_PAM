class Review {
  final String id;
  final String author;
  final String avatarUrl;
  final double rating;
  final String createdAtLabel;
  final String text;

  Review({
    required this.id,
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.createdAtLabel,
    required this.text,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      author: json['author'],
      avatarUrl: json['avatarUrl'],
      rating: (json['rating'] as num).toDouble(),
      createdAtLabel: json['createdAtLabel'],
      text: json['text'],
    );
  }
}