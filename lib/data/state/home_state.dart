import '../entity/coffe_shops.dart';
import '../entity/product.dart';

class HomeState {
  final List<Product> products;
  final List<CoffeShops> nearCoffeeShops;

  HomeState({required this.products, required this.nearCoffeeShops});

  HomeState copyWith({
    List<Product>? products,
    List<CoffeShops>? nearCoffeeShops,
  }) {
    return HomeState(
      products: products ?? this.products,
      nearCoffeeShops: nearCoffeeShops ?? this.nearCoffeeShops,
    );
  }
}