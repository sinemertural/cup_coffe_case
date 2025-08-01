import 'dart:async';
import 'package:cup_coffe_case/ui/views/base_page.dart';
import 'package:cup_coffe_case/ui/views/login_page.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pictures/background.jpg" ,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Cup ',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        fontFamily: "ComicNeue",
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Coffee',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: "ComicNeue",
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
