import 'package:cup_coffe_case/data/entity/address.dart';

import 'card_item.dart';

class Order {
  final String id;
  final Address addresses;
  final List<CartItem> cartItems;
  final double discount; //indirim


  Order({
    required this.id,
    required this.addresses,
    required this.cartItems,
    required this.discount,

  });

  int get totalItems =>
      cartItems.fold(0, (total, item) => total + item.selectedQuantity);

  double get subtotal =>
      cartItems.fold(0, (total, item) => total + item.product.price * item.selectedQuantity);


}
