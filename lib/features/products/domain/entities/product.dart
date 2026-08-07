class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
      'rating': {'rate': rating, 'count': ratingCount},
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'];

    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,

      rating: ratingData is Map
          ? (ratingData['rate'] as num).toDouble()
          : (ratingData as num).toDouble(),

      ratingCount: ratingData is Map
          ? ratingData['count'] as int
          : (json['ratingCount'] ?? 0),
    );
  }
}
