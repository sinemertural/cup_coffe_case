class Product{
  final String id;
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

}