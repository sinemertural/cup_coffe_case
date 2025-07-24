import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/entity/product.dart';
import 'package:cup_coffe_case/data/mock/mock_addresses.dart';
import 'package:cup_coffe_case/ui/views/processing_page.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/address_cart.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/coffe_order_card.dart';
import 'package:cup_coffe_case/ui/widgets/order_widget/order_summary_card.dart';
import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ReusableAppBar(
            title: "Place Order",
            onBackPressed: () {
              Navigator.pop(context);
            },
            textColor: Colors.black,
            iconColor: Colors.black,
          ),
          AddressCart(addresses: mockAddresses),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProcessingPage(),
                    ),
                  ).then((value) {
                    print("Turned to Details Page");
                  });
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
    );
  }
}
