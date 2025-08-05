import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/state/auth_state.dart';
import 'package:cup_coffe_case/ui/cubit/auth_cubit.dart';
import 'package:cup_coffe_case/ui/views/details_page.dart';
import 'package:cup_coffe_case/ui/views/admin/admin_coupon_page.dart';
import 'package:cup_coffe_case/ui/views/profile_page.dart';
import 'package:cup_coffe_case/ui/widgets/home_widget/coffee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/base_cubit.dart';
import '../../data/state/home_state.dart';
import '../widgets/home_widget/nearest_coffees_cart.dart';
import 'nearby_cafes_page.dart';
import 'chat_page.dart';
import '../cubit/chat_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    
    await Future.wait([
      context.read<HomeCubit>().loadPopularProducts('Coffee'),
      context.read<HomeCubit>().loadNearCoffeeShops(),
    ]);
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ChatCubit>().clearChat();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatPage(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child:  Image.asset("assets/icons/support.png"),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if(state is AuthAuthenticated){
              final user = state.user;
              if(user.isAdmin){
                return AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.admin_panel_settings, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminCouponPage(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      body: _isLoading 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                SizedBox(height: 16),
                Text(
                  "Yükleniyor...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          )
        : BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.coffee,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Ürün bulunamadı.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _loadData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Yenile",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: _loadData,
                child: ListView(
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
                              GestureDetector(
                                onTap: (){
                                  context.read<BaseCubit>().changePage(4);
                                },
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/pictures/person.jpg",
                                    width: 58,
                                    height: 58,
                                    fit: BoxFit.cover,
                                  ),
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
                ),
              );
            },
          ),
    );
  }
}
