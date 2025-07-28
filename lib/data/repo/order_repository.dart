import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:cup_coffe_case/data/entity/product.dart';

import '../entity/order.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create order
  Future<String> createOrder(Order order) async{
    try{
      final docRef = await _firestore.collection('orders').add(order.toJson());
      return docRef.id;
    }catch(e){
      throw Exception("Sipariş Oluşturulamadı : $e");
    }
  }

  Stream<List<Order>> getAllOrders() {
    return _firestore
        .collection('orders')
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