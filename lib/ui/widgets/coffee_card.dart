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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // GÖRSEL
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
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
                        product.rating.toStringAsFixed(1),
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

            const SizedBox(height: 8),

            Row(
              children: [
                Text(product.name , style: TextStyle(
                    fontFamily: "Poppins", 
                    fontSize: 18, 
                    fontWeight: FontWeight.w600),
              ),
                const SizedBox(width: 70),

                Text("₹ ${product.price}" , style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: "Poppins"
                ),)
              ]
            )
          ],
              
        ),
      );
  }
}
