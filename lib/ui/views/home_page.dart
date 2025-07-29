import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/ui/views/details_page.dart';
import 'package:cup_coffe_case/ui/widgets/home_widget/coffee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../../data/state/home_state.dart';
import '../widgets/home_widget/nearest_coffees_cart.dart';
import 'nearby_cafes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadPopularProducts('Coffee');
    context.read<HomeCubit>().loadNearCoffeeShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Get your ",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "Coffee",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                                TextSpan(
                                  text: "\non one finger tap",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ClipOval(
                          child: Image.asset(
                            "assets/pictures/person.jpg",
                            width: 58,
                            height: 58,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.textFieldColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          context.read<HomeCubit>().searchProducts(value);
                        },
                        decoration: const InputDecoration(
                          icon: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Image(
                              image: AssetImage("assets/icons/search.png"),
                              width: 24,
                              height: 24,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Search anything",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: AppColors.txtFieldColorDark,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular Coffee",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(
                height: 245,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 30.0 : 0.0),
                      child: CoffeeCard(
                        product: product,
                        onTap: () {
                          final updatedProduct = context.read<HomeCubit>().state.products
                              .firstWhere((p) => p.id == product.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(product: updatedProduct),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 16),
                ),
              ),


              const SizedBox(height: 16),

              Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Row(
                  children: [

                    Text("Nearest coffee shops" , style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),),

                    Spacer(),

                    Text("View all", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: AppColors.primary
                    ),),
                  ],
                ),
              ),

              const SizedBox(height: 16,),

              Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: SizedBox(
                  height: 245,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.nearCoffeeShops.length,
                    itemBuilder: (context, index) {
                      final coffeShops = state.nearCoffeeShops[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 16.0,
                        ),
                        child: NearestCoffeesCart(
                          coffeShops: coffeShops,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NearbyCafesPage(coffeShops:coffeShops)));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
