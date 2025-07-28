import 'package:cup_coffe_case/data/entity/coffe_shops.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoffeeShopsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CoffeShops>> getNearCoffeeShops() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('coffee_shops')
          .where('isNear', isEqualTo: true)
          .get();
      
      return snapshot.docs.map((doc) {
        return CoffeShops.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error getting near coffee shops: $e');
      return [];
    }
  }
}