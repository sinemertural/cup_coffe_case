import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entity/order.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;
  String? get currentUserEmail => _auth.currentUser?.email;

  //create order
  Future<String> createOrder(Order order) async {
    if (currentUserId == null) {
      throw Exception("User not authenticated");
    }

    try {
      // Add user information to order
      final orderWithUser = order.copyWith(
        userId: currentUserId!,
        userEmail: currentUserEmail ?? '',
      );

      final docRef = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('orders')
          .add(orderWithUser.toJson());
      
      return docRef.id;
    } catch (e) {
      throw Exception("Order could not be created : $e");
    }
  }

  Stream<List<Order>> getUserOrders() {
    if (currentUserId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('orders')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Order.fromJson(doc.data(), doc.id))
            .toList());
  }

  // Admin için tüm siparişleri getir
  Stream<List<Order>> getAllOrders() {
    return _firestore
        .collectionGroup('orders')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Order.fromJson(doc.data(), doc.id))
            .toList());
  }

  double calculateTotal(Product product) {
    return (product.price * product.quantity) - product.discount + product.delivery;
  }
}