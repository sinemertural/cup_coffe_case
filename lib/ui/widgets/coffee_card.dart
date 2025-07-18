import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cup_coffe_case/data/entity/product.dart';

class CoffeeCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const CoffeeCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: SizedBox(
          width: 261,
          height: 245,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      product.imageUrl,
                      width: 261,
                      height: 180,
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
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0x40FFFFFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    left: 11,
                    top: 148,
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
                    top: 147,
                    left: 209,
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
