import 'package:cup_coffe_case/data/entity/product.dart';

List<Product> mockProducts = [
  Product(
      id: "1",
      name: "Cappuccino",
      imageUrl: "assets/coffees/Cappuccino.jpg",
      description: "A cappuccino is an espresso-based coffee drink that originated in Austria with later development taking place in Italy..Read more",
      category: "Coffee",
      price: 550.0,
      rating: 5.0,
      reviewCount: 105,
      sizes: ["100 ml" , "250 ml" , "500 ml"],
      location: "Coffee cafe",
      delivery: 10,
      quantity: 7,
      discount: 150,
      isPopular: true,
      isFavorite: false,
  ),

  Product(
    id: '2',
    name: 'South Filtered',
    imageUrl: "assets/coffees/southFiltered.png",
    description: 'A smooth, carefully filtered coffee made from South American beans.',
    category: 'Coffee',
    price: 490.0,
    rating: 4.8,
    reviewCount: 87,
    sizes: ['100 ml', '250 ml', '500 ml'],
    location: "Bunny cafe",
    delivery: 7,
    quantity: 2,
    discount: 70,
    isPopular: true,
    isFavorite: false
  ),

  Product(
    id: '3',
    name: 'Coffee',
    imageUrl: "assets/coffees/coffee.jpg",
    description: 'A smooth, carefully filtered coffee made from South American beans.',
    category: 'Coffee',
    price: 490.0,
    rating: 4.8,
    reviewCount: 87,
    sizes: ['100 ml', '250 ml', '500 ml'],
    location: "Bunny cafe",
    delivery: 7,
    quantity: 3,
    discount: 120,
    isPopular: true,
    isFavorite: false
  ),

  Product(
    id: '4',
    name: 'Latte',
    imageUrl: "assets/coffees/latte.jpg",
    description: 'A smooth, carefully filtered coffee made from South American beans.',
    category: 'Coffee',
    price: 490.0,
    rating: 4.8,
    reviewCount: 87,
    sizes: ['100 ml', '250 ml', '500 ml'],
    location: "Bunny cafe",
    delivery: 7,
    quantity: 5,
    isPopular: true,
    isFavorite: false
  ),

  Product(
    id: '5',
    name: 'Hot Chocolate',
    imageUrl: "assets/coffees/hot_chocolate.png",
    description: 'A smooth, carefully filtered coffee made from South American beans.',
    category: 'Coffee',
    price: 490.0,
    rating: 4.8,
    reviewCount: 87,
    sizes: ['100 ml', '250 ml', '500 ml'],
    location: "Bunny cafe",
    delivery: 7,
    quantity: 5,
    isPopular: true,
    isFavorite: false
  ),

  Product(
    id: '6',
    name: 'Filter Coffee',
    imageUrl: "assets/coffees/filter_coffee.png",
    description: 'A smooth, carefully filtered coffee made from South American beans.',
    category: 'Cake',
    price: 490.0,
    rating: 4.8,
    reviewCount: 87,
    sizes: ['100 ml', '250 ml', '500 ml'],
    location: "Bunny cafe",
    delivery: 7,
    quantity: 5,
    isPopular: true,
    isFavorite: false
  ),

];