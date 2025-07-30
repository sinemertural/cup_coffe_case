import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cup_coffe_case/data/entity/coupon.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final VoidCallback? onApply;
  final VoidCallback? onRemove;
  final bool isApplied;

  const CouponCard({
    Key? key,
    required this.coupon,
    this.onApply,
    this.onRemove,
    this.isApplied = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${coupon.discount} TL İndirim',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Discount Amount
            Text(
              '${coupon.discount} TL İNDİRİM',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            
            // Minimum Limit
            Text(
              'Alt limit: ${coupon.minimumAmount.toStringAsFixed(2)} TL',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 12),
            
            // Action Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${coupon.discount} TL',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                ElevatedButton(
                  onPressed: isApplied ? onRemove : onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isApplied ? Colors.red[600] : AppColors.primary_green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(
                    isApplied ? 'Kaldır' : 'Uygula',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CouponListWidget extends StatelessWidget {
  final List<Coupon> coupons;
  final Function(Coupon)? onApplyCoupon;
  final VoidCallback? onRemoveCoupon;
  final Coupon? appliedCoupon;

  const CouponListWidget({
    Key? key,
    required this.coupons,
    this.onApplyCoupon,
    this.onRemoveCoupon,
    this.appliedCoupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return Container(
        height: 120,
        child: Center(
          child: Text(
            'Kullanılabilir kupon bulunamadı',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 165,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          final coupon = coupons[index];
          final isApplied = appliedCoupon?.id == coupon.id;
          
          return CouponCard(
            coupon: coupon,
            isApplied: isApplied,
            onApply: () => onApplyCoupon?.call(coupon),
            onRemove: onRemoveCoupon,
          );
        },
      ),
    );
  }
} 