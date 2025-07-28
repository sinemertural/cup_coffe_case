import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }

  Future<List<Product>> getPopularProducts(String category) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('isPopular', isEqualTo: true)
          .where('category', isEqualTo: category)
          .get();
      
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting popular products: $e');
      return [];
    }
  }

  Future<List<Product>> getProductbyCategory(String category) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting products by category: $e');
      return [];
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('products')
          .get();
      
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).where((product) => 
        product.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  Future<void> toggleFavorite(Product product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.id)
          .update({'isFavorite': !product.isFavorite});
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }
}
