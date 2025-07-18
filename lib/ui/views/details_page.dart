import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/entity/product.dart';

class DetailsPage extends StatefulWidget {
  Product product;

  DetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(right: 14, left: 14),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.product.imageUrl,
                      width: double.infinity,
                      height: 368,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Geri tuşu
                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Color(0x40FFFFFF),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                        const Text(
                          "Details",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),

                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Color(0x40FFFFFF),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.favorite_outline, color: Colors.white, size: 20),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "(\$${widget.product.price})",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.star, size: 20, color: Color(0xFFFFDA58)),
                          const SizedBox(width: 4),
                          Text(
                            widget.product.rating.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.product.description,
                        style: TextStyle(
                          color: AppColors.txtFieldColorDark,
                          fontSize: 14,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 73.3,
                      height: 73.3,
                      decoration: BoxDecoration(
                        color: Color(0x1AFFB067),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Image.asset("assets/icons/coffe_beans.png" ,
                          width: 33,
                          height: 33,
                          color: Color(0XFFFFB067),),
                      )
                    ),
                    Container(
                        width: 73.3,
                        height: 73.3,
                        decoration: BoxDecoration(
                          color: Color(0x1AFFB067),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Image.asset("assets/icons/milk_carton.png" ,
                            width: 33,
                            height: 33,
                            color: Color(0XFFFFB067),),
                        )
                    ),
                    Container(
                        width: 73.3,
                        height: 73.3,
                        decoration: BoxDecoration(
                          color: Color(0x1AFFB067),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Image.asset("assets/icons/whipped_cream.png" ,
                            width: 33,
                            height: 33,
                            color: Color(0XFFFFB067),),
                        )
                    ),
                  ],
                ),

                SizedBox(height: 32,),

                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text("Choose size", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    fontSize: 18
                  ),),
                ),

                SizedBox(height: 16,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Color(0xFF314D45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        child: Text(
                          widget.product.sizes[0],
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF314D45),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        child: Text(
                          widget.product.sizes[1],
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Color(0xFF2F4F46),
                          ),
                        ),
                      ),

                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF314D45),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        child: Text(
                          widget.product.sizes[2],
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Color(0xFF314D45),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40,),

                Padding(
                  padding: EdgeInsets.only(right: 30 , left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0x1AFFB067),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.remove , size: 16,color: Color(0xFFFFB067),),
                          onPressed: (){
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                        },),
                      ),

                      SizedBox(width: 20,),

                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),

                      SizedBox(width: 20,),
                  
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB067), // Turuncu
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, size: 16, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ),
                  
                      const Spacer(),
                  
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF314D45), // Koyu yeşil
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        onPressed: () {
                          // Sepete ekleme işlemi
                        },
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                      ),
                  
                  
                    ],
                  ),
                )


              ],
            )
          ],
        ),
      ),
    );
  }
}
