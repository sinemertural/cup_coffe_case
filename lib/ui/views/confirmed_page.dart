import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/ui/views/base_page.dart';
import 'package:cup_coffe_case/ui/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmedPage extends StatefulWidget {
  const ConfirmedPage({super.key});

  @override
  State<ConfirmedPage> createState() => _ConfirmedPageState();
}

class _ConfirmedPageState extends State<ConfirmedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 38),
                child: Image.asset(
                  "assets/giffs/confirmed.gif",
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 160),
              const Text(
                "Order Confirmed!",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const BasePage()),
                        (route) => false,
                  );
                },
                child: Text(
                  "back to homepage",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                    decorationThickness: 1.5,
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }
}
