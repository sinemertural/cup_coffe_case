import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/entity/coffe_shops.dart';
import 'package:cup_coffe_case/ui/widgets/reserve_widget/reserve_cart.dart';
import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/entity/product.dart';
import '../../data/mock/mock_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/reserve_cubit.dart';

class ReservePage extends StatefulWidget {
  final CoffeShops coffeShops;
  final Product? product;
  const ReservePage({
    super.key,
    required this.coffeShops,
    this.product
  });

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {
  String selectedCategory = 'Coffee';

  @override
  void initState() {
    super.initState();
      context.read<ReserveCubit>().getProductsbyCategory('Coffee');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ReusableAppBar(title: "${widget.coffeShops.name}", onBackPressed: (){

          },
            textColor: Colors.black,
            iconColor: Colors.black,
          ),

          Container(
            width: 368,
            height: 117,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white
            ), child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25)
                ),
                child: Image.asset(widget.coffeShops.imageUrl ,
                  width: 90,
                  height: 117,
                  fit: BoxFit.cover,
                ),
              ),
              
              SizedBox(width: 12,),
              
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Reserve a table now", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    fontSize: 18
                  ),),
                    SizedBox(height: 8,),
                    Text("Lorem ipsum dolor sit amet, cons \nectetur adipiscing elit. " , style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: AppColors.txtFieldColorDark
                    ),)
                  ]
                ),
              ),
              SizedBox(width: 30,),
              Image.asset(
                "assets/icons/chevron_right.png",
                width: 10,
                height: 16,
              )
            ],
          ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 30,left: 30,right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Coffee';
                            });
                            context.read<ReserveCubit>().getProductsbyCategory('Coffee');
                          },
                          child: Column(
                            children: [
                              Text(
                                "Coffee",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: selectedCategory == 'Coffee' ? FontWeight.bold : FontWeight.w500,
                                  color: selectedCategory == 'Coffee' ? Colors.black : Colors.grey.shade400,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (selectedCategory == 'Coffee')
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 48),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Cake';
                            });
                            context.read<ReserveCubit>().getProductsbyCategory('Cake');
                          },
                          child: Column(
                            children: [
                              Text(
                                "Cakes",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: selectedCategory == 'Cake' ? FontWeight.bold : FontWeight.w500,
                                  color: selectedCategory == 'Cake' ? Colors.black : Colors.grey.shade400,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (selectedCategory == 'Cake')
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ],
                ),

                Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Image.asset(
                    "assets/icons/settings.png",
                    width: 70,
                    height: 70,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10, left: 30,right: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Today’s special", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),),
              ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20,left: 30,right: 30),
              child: BlocBuilder<ReserveCubit, List<Product>>(
                builder: (context, products) {
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.66,
                    ),
                    itemBuilder: (context, index) {
                      return ReserveCart(product: products[index]);
                    },
                  );
                },
              ),
            ),
            ),
        ],
      )
    );
  }
}
