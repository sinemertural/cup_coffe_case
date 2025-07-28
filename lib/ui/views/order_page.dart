import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cup_coffe_case/ui/cubit/order_cubit.dart';
import 'package:cup_coffe_case/ui/views/processing_page.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/address_cart.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/coffe_order_card.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/order_summary_card.dart';
import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/order.dart';
import '../../data/state/order_state.dart';

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

  @override
  void initState() {
    super.initState();
    product = widget.product;
    context.read<OrderCubit>().fetchAddresses();
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
              onQuantityChanged: (newQuantity) {
                setState(() {
                  product.quantity = newQuantity;
                });
              },
            ),
            const SizedBox(height: 40,),
            OrderSummaryCard(product: product),
            const SizedBox(height: 20,),
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
                    final total = (product.price * product.quantity) - product.discount + product.delivery;
                    final order = Order(
                      user_id: "user123",
                      id: "",
                      product: product,
                      date: DateTime.now(),
                      total: total,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
