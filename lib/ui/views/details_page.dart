import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/ui/views/order_page.dart';
import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
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
  Set<String> selectedExtras = {};
  String? selectedSize;

  void toggleExtra(String extra) {
    setState(() {
      if (selectedExtras.contains(extra)) {
        selectedExtras.remove(extra);
      } else {
        selectedExtras.add(extra);
      }
    });
  }
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

                ReusableAppBar(
                  title: "Details",
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                  onActionPressed: () {
                    print("Favoriye eklendi");
                  },
                  actionIcon: Icons.favorite_border,
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
                    GestureDetector(
                      onTap: () => toggleExtra('extra coffee'),
                      child: Container(
                        width: 73.3,
                        height: 73.3,
                        decoration: BoxDecoration(
                          color: selectedExtras.contains('extra coffee') ? Color(0xFFFFB067) : Color(0x1AFFB067),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Image.asset("assets/icons/coffe_beans.png" ,
                            width: 33,
                            height: 33,
                            color: selectedExtras.contains('extra coffee') ? Colors.white : Color(0XFFFFB067),),
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () => toggleExtra('extra milk'),
                      child: Container(
                          width: 73.3,
                          height: 73.3,
                          decoration: BoxDecoration(
                            color: selectedExtras.contains('extra milk') ? Color(0xFFFFB067) : Color(0x1AFFB067),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Image.asset("assets/icons/milk_carton.png" ,
                              width: 33,
                              height: 33,
                              color: selectedExtras.contains('extra milk') ? Colors.white : Color(0XFFFFB067),),
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: () => toggleExtra('extra cream'),
                      child: Container(
                          width: 73.3,
                          height: 73.3,
                          decoration: BoxDecoration(
                            color: selectedExtras.contains('extra cream') ? Color(0xFFFFB067) : Color(0x1AFFB067),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Image.asset("assets/icons/whipped_cream.png" ,
                              width: 33,
                              height: 33,
                              color: selectedExtras.contains('extra cream') ? Colors.white : Color(0XFFFFB067),),
                          )
                      ),
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < widget.product.sizes.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = widget.product.sizes[i];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedSize == widget.product.sizes[i] ? Color(0xFF314D45) : Colors.transparent,
                                  border: Border.all(
                                    color: Color(0xFF314D45),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                child: Text(
                                  widget.product.sizes[i],
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    color: selectedSize == widget.product.sizes[i] ? Colors.white : Color(0xFF314D45),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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
                          widget.product.extras = selectedExtras.toList();
                          print('Seçilen ekstralar: ${widget.product.extras}');
                          print('Seçilen boyut: ${selectedSize ?? "Seçilmedi"}');
                          widget.product.quantity = quantity;
                          print('Seçilen adet: $quantity');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(product: widget.product,))).then((value){
                            print("Turned to Details Page");
                          });
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
