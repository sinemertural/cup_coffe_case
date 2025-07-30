import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cup_coffe_case/ui/cubit/order_cubit.dart';
import 'package:cup_coffe_case/ui/cubit/coupon_cubit.dart';
import 'package:cup_coffe_case/ui/views/processing_page.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/address_cart.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/coffe_order_card.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/order_summary_card.dart';
import 'package:cup_coffe_case/ui/widgets/coupon_widget/coupon_card.dart';
import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/order.dart';
import '../../data/state/order_state.dart';
import '../../data/state/coupon_state.dart';

class OrderPage extends StatefulWidget {
  final Product product;
  const OrderPage({
    super.key,
    required this.product
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Product product;
  String selectedSize = "";
  List<String> selectedExtras = [];

  @override
  void initState() {
    super.initState();
    product = widget.product;
    if (product.sizes.isNotEmpty) {
      selectedSize = product.sizes.length > 1 ? product.sizes[1] : product.sizes[0];
    }
    selectedExtras = List.from(product.extras);
    context.read<OrderCubit>().fetchAddresses();
    context.read<CouponCubit>().loadAllCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProcessingPage(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            ReusableAppBar(
              title: "Place Order",
              onBackPressed: () {
                Navigator.pop(context);
              },
              textColor: Colors.black,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderAddressesLoaded) {
                  return AddressCart(addresses: state.addresses);
                } else if (state is OrderError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 40,),
            CoffeOrderCard(
              product: product,
              selectedSize: selectedSize,
              selectedExtras: selectedExtras,
              onQuantityChanged: (newQuantity) {
                setState(() {
                  product.quantity = newQuantity;
                });
              },
              onSizeChanged: (newSize) {
                setState(() {
                  selectedSize = newSize;
                });
              },
              onExtrasChanged: (newExtras) {
                setState(() {
                  selectedExtras = newExtras;
                });
              },
            ),
            const SizedBox(height: 16,),
            // Coupon Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kuponlar",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<CouponCubit, CouponState>(
                    builder: (context, state) {
                      if (state is CouponsLoaded) {
                        return CouponListWidget(
                          coupons: state.coupons,
                          appliedCoupon: context.read<CouponCubit>().appliedCoupon,
                          onApplyCoupon: (coupon) {
                            final currentTotal = (product.price * product.quantity) + product.delivery;
                            if(currentTotal < coupon.minimumAmount){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text("Coupon could not be applied." , style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Poppins"
                                      ),),
                                      content: Text(
                                        "To use this coupon, you need to add ₺${(coupon.minimumAmount - currentTotal).toStringAsFixed(2)} more to your cart.",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Okey',
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }else{
                              context.read<CouponCubit>().applyCoupon(coupon);
                              // Update product discount
                              setState(() {
                                product.discount = coupon.discount.toDouble() as int;
                              });
                            }
                          },
                          onRemoveCoupon: () {
                            context.read<CouponCubit>().removeAppliedCoupon();
                            // Reset product discount
                            setState(() {
                              product.discount = 0;
                            });
                          },
                        );
                      } else if (state is CouponLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            OrderSummaryCard(product: product),
            const SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF314D45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    // Get applied coupon discount
                    final appliedCoupon = context.read<CouponCubit>().appliedCoupon;
                    final couponDiscount = appliedCoupon?.discount ?? 0;
                    
                    // Create a copy of product with updated discount
                    final productWithDiscount = Product(
                      id: product.id,
                      name: product.name,
                      imageUrl: product.imageUrl,
                      description: product.description,
                      category: product.category,
                      price: product.price,
                      rating: product.rating,
                      reviewCount: product.reviewCount,
                      sizes: product.sizes,
                      isPopular: product.isPopular,
                      location: product.location,
                      quantity: product.quantity,
                      discount: couponDiscount,
                      delivery: product.delivery,
                      extras: product.extras,
                      isFavorite: product.isFavorite,
                    );
                    
                    final total = (product.price * product.quantity) - couponDiscount + product.delivery;
                    final order = Order(
                      user_id: "user123",
                      id: "",
                      product: productWithDiscount,
                      date: DateTime.now(),
                      total: total,
                      selectedSize: selectedSize,
                      selectedExtras: selectedExtras,
                    );
                    context.read<OrderCubit>().createOrder(order);
                  },
                  child: const Text(
                    "Pay now",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
