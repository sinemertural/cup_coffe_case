import 'package:cup_coffe_case/data/entity/coupon.dart';

abstract class CouponState {}

class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class CouponValid extends CouponState {
  final int discount;
  CouponValid(this.discount);
}

class CouponInvalid extends CouponState {
  final String message;
  CouponInvalid(this.message);
}

class CouponApplied extends CouponState {
  final Coupon coupon;
  CouponApplied(this.coupon);
}

class CouponsLoaded extends CouponState {
  final List<Coupon> coupons;
  CouponsLoaded(this.coupons);
}
