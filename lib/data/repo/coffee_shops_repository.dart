import 'package:cup_coffe_case/data/entity/coffe_shops.dart';
import 'package:cup_coffe_case/data/mock/mock_coffe_shops.dart';

class CoffeeShopsRepository {

  Future<List<CoffeShops>> getNearCoffeeShops() async {
    return mockCoffeShops.where((coffeeShops) => coffeeShops.isNear == true ).toList();
  }

}