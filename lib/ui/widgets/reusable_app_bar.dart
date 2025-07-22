// lib/ui/widgets/reusable_app_bar.dart

import 'package:flutter/material.dart';

class ReusableAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback? onActionPressed;
  final IconData? actionIcon;
  final Color textColor;
  final Color iconColor;

  const ReusableAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    this.onActionPressed,
    this.actionIcon,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: iconColor, size: 20),
                onPressed: onBackPressed,
              ),
            ),

            Text(
              title,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: textColor,
              ),
            ),

            if (actionIcon != null && onActionPressed != null)
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    actionIcon!,
                    color: iconColor,
                    size: 20,
                  ),
                  onPressed: onActionPressed,
                ),
              )
            else
              const SizedBox(width: 34, height: 34),
          ],
        ),
      ),
    );
  }
}
