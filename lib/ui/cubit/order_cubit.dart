import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cup_coffe_case/data/repo/order_repository.dart';
import 'package:cup_coffe_case/data/repo/address_repository.dart';
import 'package:cup_coffe_case/data/entity/order.dart';
import 'package:cup_coffe_case/data/entity/address.dart';
import 'package:cup_coffe_case/data/state/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository = OrderRepository();
  final AddressRepository _addressRepository = AddressRepository();

  OrderCubit() : super(OrderInitial());

  Future<void> createOrder(Order order) async {
    emit(OrderLoading());
    try {
      final orderId = await _orderRepository.createOrder(order);
      emit(OrderSuccess(orderId));
      getUserOrders(); 
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  void getUserOrders() {
    _orderRepository.getUserOrders().listen(
          (orders) {
          emit(OrderLoaded(orders));
        },
      onError: (error) {
        emit(OrderError(error.toString()));
      },
    );
  }

  // Admin için tüm siparişleri getir
  void getAllOrders() {
    _orderRepository.getAllOrders().listen(
          (orders) {
          emit(OrderLoaded(orders));
        },
      onError: (error) {
        emit(OrderError(error.toString()));
      },
    );
  }

  Future<void> fetchAddresses() async {
    emit(OrderLoading());
    try {
      final addresses = await _addressRepository.getAddresses();
      emit(OrderAddressesLoaded(addresses));
    } catch (e) {
      emit(OrderError('Addresses could not be loaded: $e'));
    }
  }
}