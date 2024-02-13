import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_razorpay_sdk/flutter_razorpay_sdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class razorPaymentDemo extends StatefulWidget{
  static const routeName = '/razorPaymentDemo';
  @override
  State<StatefulWidget> createState() {
   return razorPaymentDemoState();
  }

}
class razorPaymentDemoState extends State<razorPaymentDemo>  {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Razorpay Sample App'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(onPressed: openCheckout, child: Text('Open'))
                ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ZFZ2yyCIffZ723', //pocketuse client
//      'key': 'rzp_test_hGmLEAthGerAr5', //workig
      // 'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': 2000,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '', 'email': 'test@razorpay.com'},
//      'prefill': {'contact': '7048493778', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
   // Toast.show("SUCCESS: " + response.paymentId, context, gravity: Toast.TOP);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "SUCCESS: " + response.paymentId),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "ERROR: " + response.code.toString() + " - " + response.message),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //Toast.show( "EXTERNAL_WALLET: " + response.walletName, context, gravity: Toast.TOP);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "EXTERNAL_WALLET: " + response.walletName),
      ),
    );
  }
}
