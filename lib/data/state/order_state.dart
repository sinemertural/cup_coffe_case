import 'package:cup_coffe_case/data/entity/order.dart';
import 'package:cup_coffe_case/data/entity/address.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}
class OrderSuccess extends OrderState {
  final String orderId;
  OrderSuccess(this.orderId);
}
class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded(this.orders);
}
class OrderAddressesLoaded extends OrderState {
  final List<Address> addresses;
  OrderAddressesLoaded(this.addresses);
}
class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}