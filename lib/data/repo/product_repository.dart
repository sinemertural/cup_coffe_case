import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cup_coffe_case/data/mock/mock_products.dart';

class ProductRepository{
  Future<List<Product>> getProducts() async{
    return List<Product>.from(mockProducts);
  }

  Future<List<Product>> getPopularProducts(String category) async{
    return mockProducts.where((product) => product.isPopular == true && product.category.toLowerCase() == category.toLowerCase()).toList();
  }

  Future<List<Product>> getProductbyCategory(String category) async{
    return mockProducts.where((product) => product.category.toLowerCase() == category.toLowerCase()).toList();
  }

  Future<List<Product>> searchProducts(String query) async {
    return mockProducts
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> toggleFavorite(Product product) async {
    product.isFavorite = !(product.isFavorite ?? false);
  }
}
