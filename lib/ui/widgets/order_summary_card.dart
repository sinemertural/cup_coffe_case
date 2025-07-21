import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/entity/product.dart';

class OrderSummaryCard extends StatefulWidget {
  final Product product;
  const OrderSummaryCard({
    super.key,
    required this.product
  });

  @override
  State<OrderSummaryCard> createState() => _OrderSummaryCardState();
}

class _OrderSummaryCardState extends State<OrderSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      width: 368,
      height: 256,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text("Selected  ", style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),),
                Spacer(),
                Text("${widget.product.quantity}", style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),),
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              children: [
                Text("Subtotal  ", style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),),
                Spacer(),
                Text("₹ ${widget.product.quantity * widget.product.price}", style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),)
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              children: [
                Text("Discount  ", style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),),
                Spacer(),
                Text("₹ ${widget.product.discount}", style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),)
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              children: [
                Text("Delivery  " , style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),),
                Spacer(),
                Text("₹ ${widget.product.delivery}" , style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),)
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              children: [
                Text("Total  " , style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),),
                Spacer(),
                Text("₹ ${widget.product.quantity * widget.product.price - widget.product.discount + widget.product.delivery}" , style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
