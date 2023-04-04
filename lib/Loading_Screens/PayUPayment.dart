import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PayUExample(),
    );
  }
}

class PayUExample extends StatefulWidget {
  @override
  _PayUExampleState createState() => _PayUExampleState();
}

class _PayUExampleState extends State<PayUExample> {
  final String key = 'gtKFFx';
  final String salt = '4R38IvwiV57FwVpsgOvTXBdLE4tHUXFW';

  String generateHash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha512.convert(bytes);
    return digest.toString();
  }


  String getPaymentUrl({
    required String txnid,
    required String amount,
    required String productInfo,
    required String name,
    required String email,
    required String phone,
    required String successUrl,
    required String failureUrl,
  }) {
    String hashSequence = '$key|$txnid|$amount|$productInfo|$name|$email|||||||||||$salt';
    String hash = generateHash(hashSequence);

    String encodedData = Uri.encodeQueryComponent(jsonEncode({
      'key': key,
      'txnid': txnid,
      'amount': amount,
      'productinfo': productInfo,
      'firstname': name,
      'email': email,
      'phone': phone,
      'surl': successUrl,
      'furl': failureUrl,
      'hash': hash,
      'service_provider': 'payu_paisa',
    }));

    return encodedData;
  }



  Future<String> initiatePayment({
    required String txnid,
    required String amount,
    required String productInfo,
    required String name,
    required String email,
    required String phone,
    required String successUrl,
    required String failureUrl,
  }) async {
    String hashSequence = '$key|$txnid|$amount|$productInfo|$name|$email|||||||||||$salt';
    String hash = generateHash(hashSequence);

    var response = await http.post(
      Uri.parse('https://sandboxsecure.payu.in/_payment'),
      body: {
        'key': key,
        'txnid': txnid,
        'amount': amount,
        'productinfo': productInfo,
        'firstname': name,
        'email': email,
        'phone': phone,
        'surl': successUrl,
        'furl': failureUrl,
        'hash': hash,
        'service_provider': 'payu_paisa',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to initiate payment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayU Payment Gateway Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            String formData = getPaymentUrl(
              txnid: 'i2wdb1wx0812re807g2387g128gd91297egb91hw9udsn12gxfd12ghwdhn9u12de3',
              amount: '10.00',
              productInfo: 'Sample Product',
              name: 'John Doe',
              email: 'john.doe@example.com',
              phone: '1234567890',
              successUrl: 'https://example.com/success',
              failureUrl: 'https://example.com/failure',
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentWebView(formData: formData),
              ),
            );
          },

          child: Text('Pay Now'),
        ),
      ),
    );
  }
}




class PaymentWebView extends StatefulWidget {
  final String formData;

  PaymentWebView({required this.formData});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Payment'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://sandboxsecure.payu.in/_payment')),
        onWebViewCreated: (InAppWebViewController webViewController) {
          _webViewController = webViewController;
        },
        onLoadStart: (InAppWebViewController controller, Uri? url) {
          if (url!.toString().contains('_payment')) {
            controller.evaluateJavascript(source: '''
              (function() {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '${url.toString()}', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onload = function() {
                  if (xhr.status === 200) {
                    document.open();
                    document.write(xhr.responseText);
                    document.close();
                  }
                };
                xhr.send('${widget.formData}');
              })();
            ''');
          }
        },
      ),
    );
  }
}
