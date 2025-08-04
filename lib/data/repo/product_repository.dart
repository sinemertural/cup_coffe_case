import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  Future<List<Product>> getProducts() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('products').get();
      final products = snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      // Load user-specific favorites
      if (currentUserId != null) {
        await _loadUserFavorites(products);
      }

      return products;
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
      
      final products = snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      // Load user-specific favorites
      if (currentUserId != null) {
        await _loadUserFavorites(products);
      }

      return products;
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
      
      final products = snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      // Load user-specific favorites
      if (currentUserId != null) {
        await _loadUserFavorites(products);
      }

      return products;
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
      
      final products = snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).where((product) => 
        product.name.toLowerCase().contains(query.toLowerCase())
      ).toList();

      // Load user-specific favorites
      if (currentUserId != null) {
        await _loadUserFavorites(products);
      }

      return products;
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  Future<void> _loadUserFavorites(List<Product> products) async {
    if (currentUserId == null) return;

    try {
      final userFavoritesDoc = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('favorites')
          .get();

      final favoriteProductIds = userFavoritesDoc.docs.map((doc) => doc.id).toSet();

      for (var product in products) {
        product.isFavorite = favoriteProductIds.contains(product.id);
      }
    } catch (e) {
      print('Error loading user favorites: $e');
    }
  }

  Future<void> toggleFavorite(Product product) async {
    if (currentUserId == null) return;

    try {
      final userFavoritesRef = _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('favorites')
          .doc(product.id);

      if (product.isFavorite) {
        // Remove from favorites
        await userFavoritesRef.delete();
        product.isFavorite = false;
      } else {
        // Add to favorites
        await userFavoritesRef.set({
          'productId': product.id,
          'addedAt': FieldValue.serverTimestamp(),
        });
        product.isFavorite = true;
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  Future<List<Product>> getUserFavorites() async {
    if (currentUserId == null) return [];

    try {
      final userFavoritesDoc = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('favorites')
          .get();

      final favoriteProductIds = userFavoritesDoc.docs.map((doc) => doc.id).toList();
      
      if (favoriteProductIds.isEmpty) return [];

      final productsSnapshot = await _firestore
          .collection('products')
          .where(FieldPath.documentId, whereIn: favoriteProductIds)
          .get();

      final products = productsSnapshot.docs.map((doc) {
        final product = Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        product.isFavorite = true;
        return product;
      }).toList();

      return products;
    } catch (e) {
      print('Error getting user favorites: $e');
      return [];
    }
  }
}
