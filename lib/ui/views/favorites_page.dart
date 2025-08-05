import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/state/home_state.dart';
import 'package:cup_coffe_case/ui/cubit/home_cubit.dart';
import 'package:cup_coffe_case/ui/widgets/home_widget/coffee_card.dart';
import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
import 'package:cup_coffe_case/ui/views/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
    });
    
    await context.read<HomeCubit>().loadUserFavorites();
    
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ReusableAppBar(
            title: "Favorites",
            onBackPressed: () {
              Navigator.pop(context);
            },
            textColor: Colors.black,
            iconColor: Colors.black,
          ),
          Expanded(
            child: _isLoading 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Favoriler yükleniyor...",
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
                              Icons.favorite_border,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Henüz favorilenmiş ürün yok.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                _loadFavorites();
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
                      onRefresh: _loadFavorites,
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                              child: CoffeeCard(
                                product: state.products[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        product: state.products[index],
                                      ),
                                    ),
                                  );
                                },
                                width: double.infinity,
                                height: 200, // Daha küçük card yüksekliği
                                imageWidth: double.infinity,
                                imageHeight: 140, // Daha küçük image yüksekliği
                              ),
                            ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
