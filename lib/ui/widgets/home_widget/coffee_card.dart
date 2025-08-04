import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/home_cubit.dart';
import 'package:cup_coffe_case/data/entity/product.dart';

class CoffeeCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? imageHeight;
  final double? imageWidth;

  const CoffeeCard({
    super.key,
    required this.product,
    required this.onTap,
    this.width,
    this.height,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Default values for home page
    final cardWidth = width ?? 261;
    final cardHeight = height ?? 245;
    final imgWidth = imageWidth ?? 261;
    final imgHeight = imageHeight ?? 180;

    return GestureDetector(
      onTap: onTap,
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      product.imageUrl,
                      width: imgWidth,
                      height: imgHeight,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, 0.2),
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 20,
                    top: 12,
                    child: GestureDetector(
                      onTap: () {
                        context.read<HomeCubit>().toggleFavorite(product);
                      },
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0x40FFFFFF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            product.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: product.isFavorite ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    left: 11,
                    top: imgHeight - 32, // Adjusted for dynamic image height
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.white ),
                        SizedBox(width: 4),
                        Text(
                          '${product.delivery} min delivery',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: imgHeight - 33, // Adjusted for dynamic image height
                    left: imgWidth - 52, // Adjusted for dynamic image width
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Color(0xFFFFDA58)),
                        SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10 ,left: 2, right: 14),
                child: Row(
                  children: [
                    Text(product.name , style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                    ),

                    Spacer(),

                    Text("₹ ${product.price.toString() }", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                    ),
                  ]
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  children: [

                    Icon(Icons.location_on_outlined ,
                    size: 14,
                    color: AppColors.txtFieldColorDark,
                    ),

                    SizedBox(width: 2,)

                    ,Text(product.location , style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: AppColors.txtFieldColorDark
                  ),
                  ),
                  ]
                ),
              ),

            ],
          ),
        ),
      );
  }
}
