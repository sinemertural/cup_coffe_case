import 'package:cup_coffe_case/data/entity/product.dart';

class Order {
  final String id;
  final Product product;
  final DateTime date;
  final double total;

  Order({
    required this.id,
    required this.product,
    required this.date,
    required this.total
  });
}