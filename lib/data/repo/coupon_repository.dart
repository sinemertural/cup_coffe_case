import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup_coffe_case/data/entity/coupon.dart';

class CouponRepository{
  final _couponRef = FirebaseFirestore.instance.collection('coupons');
  
  Future<List<Coupon>> getAllCoupons() async {
    try{
      final query = await _couponRef.where('isActive', isEqualTo: true).get();

      return query.docs.map((doc) => Coupon.fromJson(doc.data(), doc.id)).toList();
    }catch(e){
      print("Coupons could not be brought = $e");
      return[];
    }
  }

  Future<Coupon?> getCouponByCode(String code) async{
    try{
      final query = await _couponRef.where('code' , isEqualTo: code).get();

      if(query.docs.isEmpty) return null;

      final doc = query.docs.first;

      final coupon = Coupon.fromJson(doc.data(), doc.id);

      if (!coupon.isActive || coupon.expiryDate.isBefore(DateTime.now())) {
        return null;
      }

      return coupon;
    }catch(e){
      print("Coupon not brought");
      return null;
    }
  }
}