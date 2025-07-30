import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/ui/cubit/coupon_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/product.dart';
import '../../../data/state/coupon_state.dart';

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
      height: 220,
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
            BlocBuilder<CouponCubit, CouponState>(
              builder: (context, state) {
                final appliedCoupon = context.read<CouponCubit>().appliedCoupon;
                final couponDiscount = appliedCoupon?.discount ?? 0;
                
                return Row(
                  children: [
                    Text("Discount  ", style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),),
                    Spacer(),
                    Text("₹ $couponDiscount", style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),)
                  ],
                );
              },
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
            BlocBuilder<CouponCubit, CouponState>(
              builder: (context, state) {
                final appliedCoupon = context.read<CouponCubit>().appliedCoupon;
                final couponDiscount = appliedCoupon?.discount ?? 0;
                final total = widget.product.quantity * widget.product.price - couponDiscount + widget.product.delivery;
                
                return Row(
                  children: [
                    Text("Total  " , style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),),
                    Spacer(),
                    Text("₹ $total" , style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
