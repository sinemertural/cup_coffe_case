import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup_coffe_case/data/entity/product.dart';

class Order {
  String id;
  final String user_id;
  final String userId;
  final String userEmail;
  final Product product;
  final DateTime date;
  final double total;
  final String selectedSize;
  final List<String> selectedExtras;

  Order({
    required this.id,
    required this.user_id,
    this.userId = '',
    this.userEmail = '',
    required this.product,
    required this.date,
    required this.total,
    required this.selectedSize,
    required this.selectedExtras,
  });

  //read order from firebase
  factory Order.fromJson(Map<String, dynamic> json, String key){
    return Order(
        id: key,
        user_id: json['user_id'] as String? ?? "",
        userId: json['userId'] as String? ?? "",
        userEmail: json['userEmail'] as String? ?? "",
        product: Product.fromJson(json['product'] as Map<String , dynamic>, ''),
        date: (json['date'] as Timestamp).toDate(),
        total: (json['total'] as num).toDouble(),
        selectedSize: json['selectedSize'] as String? ?? "",
        selectedExtras: List<String>.from(json['selectedExtras'] as List? ?? []),
    );
  }

  //write order to firebase
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'userId': userId,
      'userEmail': userEmail,
      'product': product.toJson(),
      'date': date,
      'total': total,
      'selectedSize': selectedSize,
      'selectedExtras': selectedExtras,
    };
  }

  Order copyWith({
    String? id,
    String? user_id,
    String? userId,
    String? userEmail,
    Product? product,
    DateTime? date,
    double? total,
    String? selectedSize,
    List<String>? selectedExtras,
  }) {
    return Order(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      product: product ?? this.product,
      date: date ?? this.date,
      total: total ?? this.total,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedExtras: selectedExtras ?? this.selectedExtras,
    );
  }
}