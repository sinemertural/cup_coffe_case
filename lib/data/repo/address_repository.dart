import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup_coffe_case/data/entity/address.dart';

class AddressRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<List<Address>> getAddresses() async{
    try{
      final QuerySnapshot snapshot = await _firestore
          .collection('addresses').get();
      return snapshot.docs.map((doc) {
        return Address.fromJson(doc.data() as Map<String , dynamic>, doc.id);
      }).toList();
    }catch(e){
      print('Error getting addresses: $e');
      return [];
    }
  }
}