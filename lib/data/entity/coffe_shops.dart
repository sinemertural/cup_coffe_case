class CoffeShops {
  String id;
  final String name;
  final String imageUrl;
  final double distance;
  final double rating;
  final int totalRatings;
  final bool isNear;
  final String description;
  final String title;

  CoffeShops({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.rating,
    required this.totalRatings,
    required this.isNear,
    required this.description,
    required this.title
  });
  
  factory CoffeShops.fromJson(Map<String, dynamic> json, String key) {
    return CoffeShops(
      id: key,
      name: json["name"] as String? ?? "",
      imageUrl: json["imageUrl"] as String? ?? "",
      distance: (json["distance"] as num?)?.toDouble() ?? 0.0,
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      totalRatings: json["totalRatings"] as int? ?? 0,
      isNear: json["isNear"] as bool? ?? false,
      description: json["description"] as String? ?? "",
      title: json["title"] as String? ?? "",
    );
  }
}

