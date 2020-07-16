import 'package:firebase_database/firebase_database.dart';

class CouponModal{
  final String discountValue;
  final String couponKey;

  CouponModal(this.couponKey, this.discountValue);

  CouponModal.fromSnapShot(DataSnapshot datasnapshot):
      couponKey = datasnapshot.key,
      discountValue= datasnapshot.value["discount"];
  
}