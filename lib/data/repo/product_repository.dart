import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Cache için static değişkenler
  static Map<String, List<Product>> _productCache = {};
  static Set<String> _userFavorites = {};
  static bool _favoritesLoaded = false;

  String? get currentUserId => _auth.currentUser?.uid;

  // Cache'i temizle
  void clearCache() {
    _productCache.clear();
    _userFavorites.clear();
    _favoritesLoaded = false;
  }

  // Kullanıcı favorilerini yükle ve cache'le
  Future<void> _loadUserFavoritesToCache() async {
    if (currentUserId == null || _favoritesLoaded) return;

    try {
      final userFavoritesDoc = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('favorites')
          .get();

      _userFavorites = userFavoritesDoc.docs.map((doc) => doc.id).toSet();
      _favoritesLoaded = true;
      print('✅ Loaded ${_userFavorites.length} favorites to cache');
    } catch (e) {
      print('❌ Error loading user favorites to cache: $e');
    }
  }

  // Cache'den favori durumunu kontrol et
  bool _isProductFavorite(String productId) {
    return _userFavorites.contains(productId);
  }

  // Cache'deki favori durumunu güncelle
  void _updateFavoriteInCache(String productId, bool isFavorite) {
    if (isFavorite) {
      _userFavorites.add(productId);
    } else {
      _userFavorites.remove(productId);
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      // Cache'den kontrol et
      final cacheKey = 'all_products';
      if (_productCache.containsKey(cacheKey)) {
        print('📦 Returning cached products');
        return _productCache[cacheKey]!;
      }

      final QuerySnapshot snapshot = await _firestore.collection('products').get();
      final products = snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      // Load user-specific favorites
      if (currentUserId != null) {
        await _loadUserFavoritesToCache();
        for (var product in products) {
          product.isFavorite = _isProductFavorite(product.id);
        }
      }

      // Cache'e kaydet
      _productCache[cacheKey] = products;
      print('✅ Loaded and cached ${products.length} products');
      return products;
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }

  Future<List<Product>> getPopularProducts(String category) async {
    try {
      // Cache'den kontrol et
      final cacheKey = 'popular_$category';
      if (_productCache.containsKey(cacheKey)) {
        print('📦 Returning cached popular products for $category');
        return _productCache[cacheKey]!;
      }

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
        await _loadUserFavoritesToCache();
        for (var product in products) {
          product.isFavorite = _isProductFavorite(product.id);
        }
      }

      // Cache'e kaydet
      _productCache[cacheKey] = products;
      print('✅ Loaded and cached ${products.length} popular products for $category');
      return products;
    } catch (e) {
      print('Error getting popular products: $e');
      return [];
    }
  }

  Future<List<Product>> getProductbyCategory(String category) async {
    try {
      // Cache'den kontrol et
      final cacheKey = 'category_$category';
      if (_productCache.containsKey(cacheKey)) {
        print('📦 Returning cached products for category $category');
        return _productCache[cacheKey]!;
      }

      final QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      
      final products = snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      // Load user-specific favorites
      if (currentUserId != null) {
        await _loadUserFavoritesToCache();
        for (var product in products) {
          product.isFavorite = _isProductFavorite(product.id);
        }
      }

      // Cache'e kaydet
      _productCache[cacheKey] = products;
      print('✅ Loaded and cached ${products.length} products for category $category');
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
        await _loadUserFavoritesToCache();
        for (var product in products) {
          product.isFavorite = _isProductFavorite(product.id);
        }
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
      await _loadUserFavoritesToCache();
      for (var product in products) {
        product.isFavorite = _isProductFavorite(product.id);
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
        _updateFavoriteInCache(product.id, false);
      } else {
        // Add to favorites
        await userFavoritesRef.set({
          'productId': product.id,
          'addedAt': FieldValue.serverTimestamp(),
        });
        product.isFavorite = true;
        _updateFavoriteInCache(product.id, true);
      }

      // Cache'i temizle ki yeniden yüklensin
      _productCache.clear();
      print('✅ Toggled favorite for ${product.name}');
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  Future<List<Product>> getUserFavorites() async {
    if (currentUserId == null) return [];

    try {
      await _loadUserFavoritesToCache();
      
      if (_userFavorites.isEmpty) return [];

      final productsSnapshot = await _firestore
          .collection('products')
          .where(FieldPath.documentId, whereIn: _userFavorites.toList())
          .get();

      final products = productsSnapshot.docs.map((doc) {
        final product = Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        product.isFavorite = true;
        return product;
      }).toList();

      print('✅ Loaded ${products.length} favorite products');
      return products;
    } catch (e) {
      print('Error getting user favorites: $e');
      return [];
    }
  }
}
