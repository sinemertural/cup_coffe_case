import 'dart:ui';
import 'package:flutter/material.dart';

class MiniImageGallery extends StatelessWidget {
  final List<String> imagePaths;
  final String? overlayText;

  const MiniImageGallery({
    super.key,
    required this.imagePaths,
    this.overlayText,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 72,
          width: 275,
          decoration: BoxDecoration(
            color: const Color(0x40FFFFFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              bool isLast = index == imagePaths.length - 1 && overlayText != null;
              return _buildMiniImage(imagePaths[index], isLast ? overlayText : null);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMiniImage(String imagePath, String? overlay) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 56,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          if (overlay != null)
            Container(
              width: 56,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                overlay,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
