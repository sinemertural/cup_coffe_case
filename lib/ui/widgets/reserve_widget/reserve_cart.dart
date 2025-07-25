import 'package:cup_coffe_case/ui/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:cup_coffe_case/data/entity/product.dart';

class ReserveCart extends StatelessWidget {
  final Product product;

  const ReserveCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(product: product)));
      },
      child: Container(
        width: 183,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                product.imageUrl,
                width: 176,
                height: 202,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.name,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '₹ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
