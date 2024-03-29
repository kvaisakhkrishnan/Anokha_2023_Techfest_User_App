import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/credit_card.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:platform/platform.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

import 'SessionExpired/sessionExpired.dart';
import 'homeBody.dart';


//Once the registration form is filled, the user will be taken to this page for payment.

late String trans_token;
late String name,
    phoneNumber,
    productId,
    userEmail,
    address,
    city,
    state,
    country,
    zipcode;
var user_data;
var event_details;

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _emailController = TextEditingController();
final _addressController = TextEditingController();
final _cityController = TextEditingController();
final _stateController = TextEditingController();
final _countryController = TextEditingController();
final _zipController = TextEditingController();

var eventdata;
var star_data;
var isPassport;

class PayU extends StatelessWidget {
  var data;
  var event_data;
  var isPassport;
  PayU({super.key, required this.data, this.event_data, this.isPassport}) {
    user_data = data;
    eventdata = this.event_data;
    isPassport = this.isPassport;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF193d57), Color(0xFF001422)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: MyCardWidget()),
    );
  }
}

class MyCardWidget extends StatefulWidget {
  const MyCardWidget({super.key});

  @override
  State<MyCardWidget> createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends State<MyCardWidget> {
  @override
  Widget build(BuildContext context) {
    Future<String> trans_token;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Stack(
          children: [
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()..rotateZ(-0.4),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.25,
                margin:
                    EdgeInsets.only(top: 0, left: 30, right: 40, bottom: 60),
                child: CreditCard(
                  frontTextColor: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.25,
                  cardNumber: '2323 4343 5353 6363',
                  cardExpiry: '10/25',
                  cardHolderName: 'Name 0 ',
                  bankName: 'Axis Bank',
                  cardType: CardType.masterCard,
                  frontBackground: CardBackgrounds.white,
                  backBackground: CardBackgrounds.black,
                  horizontalMargin: 20.0,
                  showShadow: true,
                ),
              ),
            ),
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()..rotateZ(0.25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.28,
                margin: EdgeInsets.only(top: 70, left: 50, bottom: 0),
                child: CreditCard(
                  frontTextColor: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.28,
                  cardNumber: '2323 4343 **** ****',
                  cardExpiry: '10/25',
                  cardHolderName: 'Name 0 ',
                  bankName: 'Axis Bank',
                  cardType: CardType.masterCard,
                  frontBackground: CardBackgrounds.white,
                  backBackground: CardBackgrounds.black,
                  showShadow: true,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TRANSFER",
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 38,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "YOUR",
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 40,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "MONEY",
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 40,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "EASILY",
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 40,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => {collectTransToken()},
          child: Text("Get Started",
              style: GoogleFonts.roboto(
                  color: Color(0xFF002845),
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          style: ElevatedButton.styleFrom(
              elevation: 30,
              padding: EdgeInsets.all(10),
              fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.height * 0.07),
              shape: StadiumBorder(),
              backgroundColor: Colors.white),
        )
      ],
    );
  }

  void collectTransToken() async {

    String url =
        "https://anokha.amrita.edu/api/userApp/transaction/moveToTransaction";
    String user_token = user_data.SECRET_TOKEN;

    final response = await http
        .post(Uri.parse(url), headers: {'authorization': 'Bearer $user_token'});

    var json_response = json.decode(response.body);
    if(response.statusCode == 401)
      {
        trans_token = "TOKENEXPIRATIONERROR";

      }
    else {
      trans_token = json_response["TRANSACTION_SECRET_TOKEN"];

    }
    showAlertDialog();
  }

  showAlertDialog() async {


    if(trans_token == "TOKENEXPIRATIONERROR")
      {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SessionExpired()),
              (Route<dynamic> route) => false,
        );
      }
    else{
      final myController = TextEditingController();
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return FutureBuilder(
                future: Future.delayed(Duration(seconds: 2)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the future is loading, show a loading screen
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return AlertDialog(
                      title: Text(
                        "Provide your details",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      content: UserForm(),
                      actions: [
                        ElevatedButton(
                          onPressed: () => {Navigator.pop(context)},
                          // ignore: sort_child_properties_last
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              backgroundColor: Colors.white,
                              // ignore: prefer_const_constructors
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: Color(0xFFd3d3d3), width: 1))),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => PaymentPage())))
                            /*PaymentPage(
                      transact_token: transaction_token,
                    )*/
                          },
                          child: Text(
                            "Proceed to pay",
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              backgroundColor: Color(0xFF002845),
                              shape: StadiumBorder()),
                        ),
                      ],
                    );
                  }
                });
          });
    }
  }
}

class PaymentPage extends StatefulWidget {
  PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Future<Map<String, dynamic>> getHash() async {
    print("hello");
    String url =
        "https://anokha.amrita.edu/api/userApp/transaction/initiateTransaction";
    /*var productId = (eventdata == null)
        ? "E${event_details["eventId"]}"
        : "E${event_details.eventId}";*/

    var productId;
    //var productId = (eventdata == true) ? "P" : "E${eventdata.eventId}";
    if (eventdata == null) {
      productId = "P";
    } else {
      productId = "E${eventdata.eventId}";
    }
    Map<String, String> body = {
      "productId": productId,
      "firstName": _nameController.text,
      "userEmail": user_data.userEmail,
      "address": _addressController.text,
      "city": _cityController.text,
      "state": _stateController.text,
      "country": _countryController.text,
      "zipcode": _zipController.text,
      "phoneNumber": _phoneController.text
    };

    var json_body = jsonEncode(body);
    print(trans_token);
    final response = await http.post(Uri.parse(url),
        headers: {
          'authorization': 'Bearer ${trans_token}',
          'Content-Type': 'application/json'
        },
        body: json_body);
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: getHash(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            return Nextpage(trans_map: snapshot.data);
          } else {
            return Center(
                child: Text("Server is taking too long to respond..."));
          }
        }),
      ),
    );
  }
}

//page where payu screens are going to be shown
class Nextpage extends StatefulWidget {
  Map<String, dynamic>? trans_map;
  Nextpage({super.key, required this.trans_map});

  @override
  State<Nextpage> createState() => _NextpageState();
}

class _NextpageState extends State<Nextpage> {
  late Map<String, String> postbody;
  late String encodedBody;
  var url = "https://payu-nodejs-demo.herokuapp.com/response.html?page=ejs";
  /*var info = (eventdata != null)
      ? "E${event_details.eventId}"
      : "E${event_details["eventId"]}";*/

  @override
  void initState() {
    var info;
    if (eventdata == null) {
      info = "PASSPORT";
    } else {
      info = "E${eventdata.eventId}";
    }
    postbody = {
      "productInfo": info,
      "txnid": widget.trans_map?["txid"],
      "amount": "${widget.trans_map?["amount"]}",
      "firstname": user_data.fullName,
      "Lastname": user_data.fullName,
      "email": user_data.userEmail,
      "phone": phoneNumber,
      "address1": address,
      "address2": "",
      "city": city,
      "state": state,
      "country": country,
      "Zipcode": zipcode,
      "hash": widget.trans_map?["hash"],
      "surl": "https://anokha.amrita.edu/",
      "furl": "https://anokha.amrita.edu/events",
      "curl": "",
      "key": "ypfBaj"
    };

    encodedBody = postbody.keys
        .map((key) =>
            '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(postbody[key]!)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InAppWebView(
          /*initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              disableDefaultErrorPage: false,
              // useHybridComposition: true,
              supportMultipleWindows: false,
              cacheMode: AndroidCacheMode.LOAD_DEFAULT,
            ),
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
              // debuggingEnabled: true,
            ),
          ),*/
          initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
            disableDefaultErrorPage: false,
            // useHybridComposition: true,
            supportMultipleWindows: false,
            cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
          )),
          initialUrlRequest: URLRequest(
              url: Uri.parse("https://secure.payu.in/_payment"),
              method: 'POST',
              body: Uint8List.fromList(utf8.encode(encodedBody)),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
          /*initialUrl: 'https://test.payu.in/_payment',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
              _loadHtmlFromAssets();
            }*/

          onLoadStart: (InAppWebViewController controller, url) {
            // controller.clearCache();
            setState(() {
              this.url = url.toString();
            });
            if (url.toString().startsWith("upi://")) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UPI_Pay(upi_url: url.toString())));
            }
            if (url.toString() == "https://anokha.amrita.edu/") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Success(txid: widget.trans_map?["txid"])));
            } else if (url.toString() == "https://anokha.amrita.edu/events") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Failure(txid: widget.trans_map?["txid"]),
                  ));
            }
          },
        ),
      ),
    );
  }

  /* _loadHtmlFromAssets() async {
    final url = Uri.parse("https://test.payu.in/_payment");

    //final headers = {'Content-Type': 'text/html'};

    if (postbody != null) {
      final encodedBody = postbody.keys
          .map((key) =>
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(postbody[key]!)}')
          .join('&');
    }*/
  //print(encodedBody);
  // print(Uri(queryParameters: postbody).query);

  /*await _controller.postUrl(url,
        body: postbody,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});*/
}

class Failure extends StatefulWidget {
  var txid;
  Failure({super.key, required this.txid});

  @override
  State<Failure> createState() => _FailureState();
}

class _FailureState extends State<Failure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF002845),
        body: Center(
          child: Column(children: [
            Lottie.asset("assets/warning.json", repeat: false),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Transaction Unsuccessful",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text("", style: TextStyle(color: Colors.white, fontSize: 18))),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Transaction ID : ${widget.txid}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..pop()
                  ..pop();
              },
              child: Text(
                "Go Back",
                style: TextStyle(color: Color(0xff002845)),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, padding: EdgeInsets.all(8)),
            )
          ]),
        ));
  }
}

class UPI_Pay extends StatefulWidget {
  String upi_url;
  UPI_Pay({super.key, required this.upi_url});

  @override
  State<UPI_Pay> createState() => _UPI_PayState();
}

class _UPI_PayState extends State<UPI_Pay> {
  void _launchUPIPayment(String upiUrl) async {
    // Launch UPI payment intent
    final uri = Uri.parse(upiUrl);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  void initState() {
    super.initState();
    _launchUPIPayment(widget.upi_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}

class Success extends StatefulWidget {
  var txid;
  Success({super.key, required this.txid});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF002845),
        body: Center(
          child: Column(children: [
            Lottie.asset("assets/success.json", repeat: false),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Transaction Successful",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text("Your Payment will be reflected in 5-10",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            Center(
              child: Text(
                "Transaction ID : ${widget.txid}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..pop()
                  ..pop();
              },
              child: Text(
                "Go Back",
                style: TextStyle(color: Color(0xff002845)),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, padding: EdgeInsets.all(8)),
            )
          ]),
        ));
    ;
  }
}

class UserForm extends StatefulWidget {
  UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = user_data.fullName;
    // _phoneController.text = "9597197934";
    _emailController.text = user_data.userEmail;
    /*_addressController.text = "address0";
    _cityController.text = "city0";
    _stateController.text = "state0";
    _zipController.text = "123";
    _countryController.text = "India";*/

    name = _nameController.text;
    phoneNumber = _phoneController.text;
    userEmail = _emailController.text;
    address = _addressController.text;
    city = _cityController.text;
    state = _stateController.text;
    country = _countryController.text;
    zipcode = _zipController.text;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.77,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  enabled: false,
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Color(0xFF002845)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF002845))),
                      label: Text("Full Name"),
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color: Color(0xFF002845),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your phone number";
                      } else if (value.length != 10) {
                        return "Phone Number invalid";
                      }

                      return null;
                    },
                    controller: _phoneController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xFF002845)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 157, 173, 184))),
                        label: Text("Phone Number"),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color(0xFF002845),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                    enabled: false,
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xFF002845)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color(0xFF002845))),
                        label: Text("Email"),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xFF002845),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your address";
                      }
                      return null;
                    },
                    controller: _addressController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xFF002845)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color(0xFF002845))),
                        label: Text("Address Line 1"),
                        prefixIcon: Icon(
                          Icons.home_outlined,
                          color: Color(0xFF002845),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your city";
                      }
                      return null;
                    },
                    controller: _cityController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xFF002845)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color(0xFF002845))),
                        label: Text("City"),
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Color(0xFF002845),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your state";
                      }
                      return null;
                    },
                    controller: _stateController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xFF002845)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color(0xFF002845))),
                        label: Text("State"),
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Color(0xFF002845),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your country";
                      }
                      return null;
                    },
                    controller: _countryController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Color(0xFF002845)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color(0xFF002845))),
                        label: Text("Country"),
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Color(0xFF002845),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
              ]))),
    );
  }
}
