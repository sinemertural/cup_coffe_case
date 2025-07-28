class Product{
  String id;
  final String name;
  final String imageUrl;
  final String description;
  final String category;
  final double price; //fiyat
  final double rating; //derecelendirme
  final int reviewCount; //inceleme sayısı
  final List<String> sizes; //[100 ml  ..]
  final bool isPopular;
  final String location;
  int discount ;
  int quantity;
  final int delivery; //teslimat süresi
  List<String> extras;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.sizes,
    required this.isPopular,
    required this.location,
    this.quantity = 0,
    this.discount = 0,
    required this.delivery,
    this.extras = const [],
    this.isFavorite = false
  });

  //read product from firebase
  factory Product.fromJson(Map<String, dynamic> json, String key){
    return Product(
        id: key,
        name: json["name"] as String? ?? "",
        imageUrl: json["imageUrl"] as String? ?? "",
        description: json["description"] as String? ?? "",
        category: json["category"] as String? ?? "",
        price: (json["price"] as num?)?.toDouble() ?? 0.0,
        rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
        reviewCount: json["reviewCount"] as int? ?? 0,
        sizes: List<String>.from(json["sizes"] as List? ?? []),
        isPopular: json["isPopular"] as bool? ?? false,
        location: json["location"] as String? ?? "",
        delivery: json["delivery"] as int? ?? 0,
        quantity: json["quantity"] as int? ?? 0,
        discount: json["discount"] as int? ?? 0,
        extras: List<String>.from(json["extras"] as List? ?? []),
        isFavorite: json["isFavorite"] as bool? ?? false
    );
  }

  //write product to firebase
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'sizes': sizes,
      'isPopular': isPopular,
      'location': location,
      'quantity': quantity,
      'discount': discount,
      'delivery': delivery,
      'extras': extras,
      'isFavorite': isFavorite,
    };
  }
}