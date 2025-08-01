import 'package:cup_coffe_case/data/repo/coffee_shops_repository.dart';
import 'package:cup_coffe_case/data/repo/product_repository.dart';
import 'package:cup_coffe_case/data/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/product.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(products: [], nearCoffeeShops: []));

  final productRepo = ProductRepository();
  final coffeeShopsRepo = CoffeeShopsRepository();

  Future<void> loadPopularProducts(String category) async {
    print('🔄 Loading popular products for category: $category');
    try {
      var popularProducts = await productRepo.getPopularProducts(category);
      print('✅ Loaded ${popularProducts.length} popular products');
      for (var product in popularProducts) {
        print('  - ${product.name} (Popular: ${product.isPopular}, Category: ${product.category})');
      }
      emit(state.copyWith(products: popularProducts));
    } catch (e) {
      print('❌ Error loading popular products: $e');
      emit(state.copyWith(products: []));
    }
  }

  Future<void> loadNearCoffeeShops() async {
    print('🔄 Loading near coffee shops');
    try {
      var nearCoffeShops = await coffeeShopsRepo.getNearCoffeeShops();
      print('✅ Loaded ${nearCoffeShops.length} near coffee shops');
      emit(state.copyWith(nearCoffeeShops: nearCoffeShops));
    } catch (e) {
      print('❌ Error loading near coffee shops: $e');
      emit(state.copyWith(nearCoffeeShops: []));
    }
  }

  Future<void> searchProducts(String query) async {
    final results = await productRepo.searchProducts(query);
    emit(state.copyWith(products: results));
  }

  Future<void> toggleFavorite(Product product) async {
    await productRepo.toggleFavorite(product);
    final updatedProducts = await productRepo.getProducts();
    emit(state.copyWith(products: updatedProducts));
    final favorites = updatedProducts.where((p) => p.isFavorite).toList();
    if (favorites.isNotEmpty) {
      print('Favorites products:');
      for (var fav in favorites) {
        print(fav.name);
      }
    } else {
      print('No favorite product:');
    }
  }
}


