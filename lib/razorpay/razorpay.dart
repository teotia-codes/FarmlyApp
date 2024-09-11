import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPage extends StatefulWidget {
  final String totalPrice;

  const RazorPayPage(this.totalPrice, {super.key});

  @override
  State<RazorPayPage> createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorPayPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    // Automatically trigger checkout on page load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String amount = widget.totalPrice;
      checkout(amount);
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void checkout(String totalPrice) async {
    int amt = (double.parse(totalPrice) * 100).toInt(); // Convert to int for Razorpay
    var options = {
      'key': 'rzp_test_GcZZFDPP0jHtC4',
      'amount': amt,
      'name': 'Farmly',
      'prefill': {
        'contact': '1234567890',
        'email': 'test@gmail.com',
      },
      'external': {
        'wallets': ['paytm'],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Successful: ${response.paymentId!}",
      toastLength: Toast.LENGTH_LONG
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed: ${response.message!}",
      toastLength: Toast.LENGTH_LONG
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "External Wallet: ${response.walletName!}",
      toastLength: Toast.LENGTH_LONG
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator while processing
      ),
    );
  }
}
