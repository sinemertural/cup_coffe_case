import 'package:cup_coffe_case/data/entity/product.dart';

import '../entity/order.dart';

class OrderRepository {
  Future<void> completeOrder(Order order) async {
    print("Your order has been successfully created.");
    print("Ordered product: ${order.product.name}");
    print("Quantity: ${order.product.quantity}");
    print("Total payment: ${order.total}");
    print("Extras: ${order.product.extras.join(', ')}");
    print("Order date: ${order.date.toString()}");
  }

  double calculateTotal(Product product) {
    return (product.price * product.quantity) - product.discount + product.delivery;
  }
}