import 'package:cup_coffe_case/data/entity/product.dart';

class CartItem{
  final String id;
  final Product product;
  final String selectedSize; //seçilen mL
  final int selectedQuantity; //seçilen miktar


  CartItem({
    required this.id,
    required this.product,
    required this.selectedSize,
    required this.selectedQuantity,
  });
}