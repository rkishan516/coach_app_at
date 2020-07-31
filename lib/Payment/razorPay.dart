import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPayment {
  Razorpay _razorPay;
  RazorPayPayment(Function _handlePaymentSuccess, Function _handlePaymentError,
      Function _handleExternalWallet) {
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void clearListener() {
    _razorPay.clear();
  }

  checkoutPayment(int amount, String name, String description, String phoneNo,
      String email) {
    try {
      _razorPay.open(
        {
          'key': 'rzp_test_DKloPhodH3Kmnh',
          'amount': amount,
          'name': name,
          'description': description,
          'prefill': {
            'contact': phoneNo,
            'email': email,
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
