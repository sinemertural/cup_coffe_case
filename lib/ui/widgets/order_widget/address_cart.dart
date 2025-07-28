import 'package:cup_coffe_case/core/painter/dashed_line_painter.dart';
import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/entity/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressCart extends StatelessWidget {
  final List<Address> addresses;

  const AddressCart({
    super.key,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 368,
      height: 256,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: List.generate(addresses.length * 2 - 1, (index) {
                    if (index.isEven) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Image.asset(
                          index == addresses.length * 2 - 2
                              ? "assets/icons/item.png"
                              : "assets/icons/location.png",
                          width: 30,
                          height: 30,
                        ),
                      );
                    } else {
                      return CustomPaint(
                        size: const Size(2, 60),
                        painter: DashedLinePainter(
                          color: Colors.orange.withOpacity(0.5),
                          dashLength: 5,
                          dashGap: 4,
                          strokeWidth: 2,
                        ),
                      );
                    }
                  }),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: addresses.map((address) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              address.details.replaceAll(r'\n', '\n'),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.txtFieldColorDark,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(height: 16,)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 30,
            right: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0x1AFFB067),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("assets/icons/pencil.png", width: 18, height: 18,),
            ),
          ),
        ],
      ),
    );
  }
}