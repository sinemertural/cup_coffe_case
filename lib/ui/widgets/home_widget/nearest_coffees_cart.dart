import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/entity/coffe_shops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class NearestCoffeesCart extends StatelessWidget {

  final CoffeShops coffeShops;
  final VoidCallback onTap;


  NearestCoffeesCart({
    super.key,
    required this.coffeShops,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200,
        width: 177,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                      coffeShops.imageUrl,
                      width: 177,
                      height: 154,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, 0.2),
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
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
                  right: 0,
                  top: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 85,
                        height: 30,
                        color: Colors.white.withOpacity(0.25),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "${coffeShops.distance.toString()} km",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffeShops.name ,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),

                SizedBox(height: 4,),

                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Color(0xFFFFDA58)),
                    SizedBox(width: 4),
                    Text(
                      "${ coffeShops.rating.toString()} / ${coffeShops.totalRatings}",
                      style: TextStyle(
                        color: AppColors.txtFieldColorDark,
                        fontSize: 14,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                )

              ]
            )
          ],
        ),
      ),
    );
  }
}