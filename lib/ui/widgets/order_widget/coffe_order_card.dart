import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/entity/product.dart';

class CoffeOrderCard extends StatefulWidget {
  final Product product;
  final void Function(int)? onQuantityChanged;
  final String selectedSize;
  final List<String> selectedExtras;
  final void Function(String)? onSizeChanged;
  final void Function(List<String>)? onExtrasChanged;

  const CoffeOrderCard({
    super.key,
    required this.product,
    this.onQuantityChanged,
    required this.selectedSize,
    required this.selectedExtras,
    this.onSizeChanged,
    this.onExtrasChanged,
  });

  @override
  State<CoffeOrderCard> createState() => _CoffeOrderCardState();
}

class _CoffeOrderCardState extends State<CoffeOrderCard> {
  late int quantity;

  String get quantityText {
    switch (quantity) {
      case 1:
        return 'One';
      case 2:
        return 'Two';
      case 3:
        return 'Three';
      case 4:
        return 'Four';
      case 5:
        return 'Five';
      default:
        return quantity.toString();
    }
  }

  String get selectedSizeText {
    return widget.selectedSize.isNotEmpty ? widget.selectedSize : '';
  }

  String get orderMainText {
    return '${quantityText} ${selectedSizeText} with';
  }

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 368,
      height: 135,
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
                Text(
                  orderMainText,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: AppColors.txtFieldColorDark
                  ),
                ),
                if (widget.selectedExtras.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.selectedExtras.map((extra) =>
                        Text(
                          extra,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: AppColors.txtFieldColorDark
                          ),
                        )
                      ).toList(),
                    ),
                  ),
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
                        widget.onQuantityChanged?.call(quantity);
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
                    color: const Color(0xFFFFB067),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 14, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        quantity++;
                        widget.onQuantityChanged?.call(quantity);
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
