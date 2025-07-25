import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cup_coffe_case/data/repo/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReserveCubit extends Cubit<List<Product>>{
  ReserveCubit() : super(<Product>[]);
  var product_repository = ProductRepository();

  Future<void> getProductsbyCategory(String category) async{
    var productbyCategory = await product_repository.getProductbyCategory(category);
    emit(productbyCategory);
  }
}