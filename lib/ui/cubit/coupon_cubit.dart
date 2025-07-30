import 'package:cup_coffe_case/data/repo/coupon_repository.dart';
import 'package:cup_coffe_case/data/state/coupon_state.dart';
import 'package:cup_coffe_case/data/entity/coupon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponCubit extends Cubit<CouponState> {
  final CouponRepository couponRepository;
  Coupon? _appliedCoupon;
  List<Coupon> _coupons = [];

  CouponCubit(this.couponRepository) : super(CouponInitial());

  Coupon? get appliedCoupon => _appliedCoupon;
  List<Coupon> get coupons => _coupons;

  Future<void> loadAllCoupons() async {
    emit(CouponLoading());
    try {
      _coupons = await couponRepository.getAllCoupons();
      emit(CouponsLoaded(_coupons));
    } catch (e) {
      emit(CouponInvalid("Kuponlar yüklenemedi."));
    }
  }

  Future<void> validateCoupon(String code) async {
    emit(CouponLoading());

    final coupon = await couponRepository.getCouponByCode(code.trim());

    if (coupon != null) {
      emit(CouponValid(coupon.discount));
    } else {
      emit(CouponInvalid("The coupon is invalid or expired."));
    }
  }

  void applyCoupon(Coupon coupon) {
    _appliedCoupon = coupon;
    emit(CouponsLoaded(_coupons));
  }

  void removeAppliedCoupon() {
    _appliedCoupon = null;
    emit(CouponsLoaded(_coupons));
  }

  void resetCoupon() {
    _appliedCoupon = null;
    emit(CouponInitial());
  }
}