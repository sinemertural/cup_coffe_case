import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Coupon{
  final String id;
  final String code;
  final int discount;
  final bool isActive;
  final DateTime expiryDate;
  final double minimumAmount;

  Coupon({
    required this.id,
    required this.code,
    required this.discount,
    required this.isActive,
    required this.expiryDate,
    this.minimumAmount = 0.0}
      );

  factory Coupon.fromJson(Map<String, dynamic> json, String key) {
    return Coupon(
      id: key,
      code: json["code"] as String? ?? "",
      isActive: json["isActive"] as bool? ?? false,
      discount: json["discount"] as int? ?? 0,
      expiryDate: (json["expiryDate"] as Timestamp).toDate(),
      minimumAmount: (json["minimumAmount"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount': discount,
      'isActive': isActive,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'minimumAmount': minimumAmount,
    };
  }
}