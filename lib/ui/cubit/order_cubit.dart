import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cup_coffe_case/data/repo/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/order.dart';

class OrderCubit extends Cubit<bool> {
  OrderCubit():super(false);
  final order_repo = OrderRepository();

  Future<void> completeOrder(Order order) async{
    await order_repo.completeOrder(order);
    emit(true);
  }
}