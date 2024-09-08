import 'package:app/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPage extends StatefulWidget {
  const RazorPayPage({super.key});

  @override
  State<RazorPayPage> createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorPayPage> {
 late Razorpay _razorpay;
 TextEditingController amt = TextEditingController();

 void checkout(amt) async {
  amt = amt *100;
  var options = {
    'key' : 'rzp_test_GcZZFDPP0jHtC4',
    'amount': amt,
    'name': 'Farmly',
    'prefill': {
      'contact': '1234567890', 'email': 'test@gmail.com'
    },
    'external':{
      'wallets': ['paytm']
    }
  };
  try{
    _razorpay.open(options);
  }catch(e){
    debugPrint("Error : $e");
  }
 }
  
  void handlePaymentSucess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "Payment Succesful"+response.paymentId!, toastLength: Toast.LENGTH_LONG);
  }
 
 void handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "Payment Fail"+response.message!, toastLength: Toast.LENGTH_LONG);
  }
 
 void handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "External Wallet "+response.walletName!, toastLength: Toast.LENGTH_LONG);
  }
 
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSucess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              cursorColor: Colors.white,
              autofocus: false,
              decoration: const InputDecoration(
                labelText: "Enter amount to be paid",
                labelStyle: TextStyle(fontSize: 15,),
                border: OutlineInputBorder(                  borderSide: BorderSide(
          
                    color: Colors.black,
                    width: 1
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    
                    color: Colors.black,
                    width: 1
                  )
                ),
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
              ),
              controller: amt,
              validator: (value){
                if(value ==  null || value.isEmpty){
                  return "Please enter amount to be paid";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 30,),
           Padding(
             padding: const EdgeInsets.only(left: 100, right: 100),
             child: CustomOutlinedButton(onTap: (){
                   if(amt.text.toString().isNotEmpty){
                setState(() {
                  int amount = int.parse(amt.text.toString());
                  checkout(amount);
                });
              }
             }, text: "Make Payment"),
           )
        ],
      ),
    );
  }
}