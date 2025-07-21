import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/entity/product.dart';

class CoffeOrderCard extends StatefulWidget {
  final Product product;

  const CoffeOrderCard({
    super.key,
    required this.product
  });

  @override
  State<CoffeOrderCard> createState() => _CoffeOrderCardState();
}

class _CoffeOrderCardState extends State<CoffeOrderCard> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 368,
      height: 106,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(widget.product.imageUrl ,
              width: 81,
              fit: BoxFit.cover,
              ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name , style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),),
                SizedBox(height: 4,),
                Text("${widget.product.sizes[1].toString()} with " , style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: AppColors.txtFieldColorDark
                ),)
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Container(
                  width: 33,
                  height: 33,
                  decoration: BoxDecoration(
                    color: Color(0x1AFFB067),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove , size: 14,color: Color(0xFFFFB067),),
                    onPressed: (){
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },),
                ),

                SizedBox(width: 10,),

                Text(
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),

                SizedBox(width: 10,),

                Container(
                  width: 33,
                  height: 33,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB067), // Turuncu
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 14, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],

      ),
    );
  }
}
