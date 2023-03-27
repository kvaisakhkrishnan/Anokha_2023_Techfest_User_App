import 'package:flutter/material.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';

class PayUCheckoutPage extends StatefulWidget {
  @override
  _PayUCheckoutPageState createState() => _PayUCheckoutPageState();
}

class _PayUCheckoutPageState extends State<PayUCheckoutPage>
    implements PayUCheckoutProProtocol {
  late PayUCheckoutProFlutter _checkoutPro;

  var payUPaymentParams = {
    PayUPaymentParamKey.key: "YOUR_MERCHANT_KEY",
    PayUPaymentParamKey.transactionId: "YOUR_TRANSACTION_ID",
    PayUPaymentParamKey.amount: "TRANSACTION_AMOUNT",
    PayUPaymentParamKey.productInfo: "PRODUCT_INFO",
    PayUPaymentParamKey.firstName: "CUSTOMER_FIRST_NAME",
    PayUPaymentParamKey.email: "CUSTOMER_EMAIL",
    PayUPaymentParamKey.phone: "CUSTOMER_PHONE",
    PayUPaymentParamKey.ios_surl: "iOS_SUCCESS_URL",
    PayUPaymentParamKey.ios_furl: "iOS_FAILURE_URL",
    PayUPaymentParamKey.android_surl: "ANDROID_SUCCESS_URL",
    PayUPaymentParamKey.android_furl: "ANDROID_FAILURE_URL",
    PayUPaymentParamKey.environment: "1", // "0" for Production, "1" for Test
    // Add more parameters as required
  };

  @override
  void initState() {
    super.initState();
    _checkoutPro = PayUCheckoutProFlutter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayU Checkout Pro Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _initiatePayment,
          child: Text('Initiate Payment'),
        ),
      ),
    );
  }

  void _initiatePayment() {
    _checkoutPro.openCheckoutScreen(payUPaymentParams: payUPaymentParams, payUCheckoutProConfig: {});
  }

  @override
  generateHash(Map response) {
    // TODO: implement generateHash
    print("Started");
  }

  @override
  onError(Map? response) {
    // TODO: implement onError
    print("Started");
  }

  @override
  onPaymentCancel(Map? response) {
    // TODO: implement onPaymentCancel
    print("Started");
  }

  @override
  onPaymentFailure(response) {
    // TODO: implement onPaymentFailure
    print("Started");
  }

  @override
  onPaymentSuccess(response) {
    // TODO: implement onPaymentSuccess
    print("Started");
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PayUCheckoutPage(),
    );
  }
}
