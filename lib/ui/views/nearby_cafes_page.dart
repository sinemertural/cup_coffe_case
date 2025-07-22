import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/entity/coffe_shops.dart';
import 'package:cup_coffe_case/ui/views/reserve_page.dart';
import 'package:cup_coffe_case/ui/widgets/mini_image_gallery.dart';
import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NearbyCafesPage extends StatefulWidget {
  final CoffeShops coffeShops;
  const NearbyCafesPage({
    super.key,
    required this.coffeShops
  });

  @override
  State<NearbyCafesPage> createState() => _NearbyCafesPageState();
}

class _NearbyCafesPageState extends State<NearbyCafesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 14 , right: 14),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.coffeShops.imageUrl,
                      width: double.infinity,
                      height: 368,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                    child: MiniImageGallery(
                      imagePaths: [
                        "assets/coffee_shops/coffe_shops_details/coffe_shops_detail_one.jpg",
                        "assets/coffee_shops/coffe_shops_details/coffe_shops_detail_two.jpg",
                        "assets/coffee_shops/coffe_shops_details/coffe_shops_detail_three.jpg",
                        "assets/coffee_shops/coffe_shops_details/coffe_shops_detail_four.jpg",
                      ],
                      overlayText: "+30",
                    ),
                  ),
                ),
                ReusableAppBar(
                  title: "Nearby shops",
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 30,top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.coffeShops.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Color(0xFFFFDA58)),
                          const SizedBox(width: 4),
                          Text(
                            "${widget.coffeShops.rating} / ${widget.coffeShops.totalRatings}",
                            style: const TextStyle(
                              color: AppColors.txtFieldColorDark,
                              fontSize: 14,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 2,),
                  Text(widget.coffeShops.title, style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.black
                  ),
                  ),
                  const SizedBox(height: 20,),
                  Text(widget.coffeShops.description, style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: AppColors.txtFieldColorDark
                  ),
                  ),
                  const SizedBox(height: 30,),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "assets/pictures/map.png",
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: MediaQuery.of(context).size.width / 2 - 18.5,
                        child: SizedBox(
                          width: 37,
                          height: 37,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: 37,
                                height: 37,
                                decoration: BoxDecoration(
                                  color: const Color(0x33E13300),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.redAccent,
                                    width: 0.5
                                  )
                                ),
                              ),
                              Image.asset(
                                "assets/icons/map_location.png",
                                width: 21,
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30,),

                  SizedBox(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReservePage(coffeShops: widget.coffeShops)));
                      },
                      child: const Text(
                        "View products",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )


                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
