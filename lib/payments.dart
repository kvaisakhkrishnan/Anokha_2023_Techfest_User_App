import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/credit_card.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

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
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF193d57), Color(0xFF001422)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: MyCardWidget()),
      ),
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
          height: 30,
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
                  height: MediaQuery.of(context).size.height * 0.22,
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
                height: MediaQuery.of(context).size.height * 0.25,
                margin: EdgeInsets.only(top: 70, left: 50, bottom: 0),
                child: CreditCard(
                  frontTextColor: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.22,
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
              fixedSize: Size(350, 60),
              shape: StadiumBorder(),
              backgroundColor: Colors.white),
        )
      ],
    );
  }

  void collectTransToken() async {
    showAlertDialog();
    String url =
        "http://52.66.236.118:3000/userApp/transaction/moveToTransaction";
    String user_token =
        "v4.public.eyJ1c2VyRW1haWwiOiJjYi5lbi51NGNzZTIwMDEwQGNiLnN0dWRlbnRzLmFtcml0YS5lZHUiLCJmdWxsTmFtZSI6IkZJUlNUTkFNRTAgTEFTVE5BTUUwIiwiY29sbGVnZU5hbWUiOiJBYXphZCBDb2xsZWdlIG9mIEVkdWNhdGlvbiAoSWQ6IEMtMzkyMzApIiwiZGlzdHJpY3QiOiJQcmFrYXNhbSIsImNvdW50cnkiOiJJTkRJQSIsInJvbGUiOiJVU0VSIiwic2VjcmV0X2tleSI6IkUpSEBNY1FmVGpXblpyNHU3eCFBJUQqRy1KYU5kUmdVa1hwMnM1djh5L0I_RShIK01iUGVTaFZtWXEzdDZ3OXokQyZGKUpATmNSZlRqV25acjR1N3ghQSVEKkctS2FQZFNnVmtYcDJzNXY4eS9CP0UoSCtNYlFlVGhXbVpxM3Q2dzl6JEMmRilKQE5jUmZValhuMnI1dTd4IUElRCpHLUthUGRTZ1ZrWXAzczZ2OXkkQj9FKEgrTWJRZVRoV21acTR0N3cheiVDKkYpSkBOY1JmVWpYbjJyNXU4eC9BP0QoRytLYVBkU2dWa1lwM3M2djl5JEImRSlIQE1jUWVUaFdtWnE0dDd3IXolQypGLUphTmRSZ1VqWG4ycjV1OHgvQT9EKEcrS2JQZVNoVm1ZcDNzNnY5eSRCJkUpSEBNY1FmVGpXblpyNHQ3dyF6JUMqRi1KYU5kUmdVa1hwMnM1djh4L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXokQiZFKUhATWNRZlRqV25acjR1N3ghQSVEKkYtSmFOZFJnVWtYcDJzNXY4eS9CP0UoSCtLYlBlU2hWbVlxM3Q2dzl6JEMmRilKQE5jUWZUalduWnI0dTd4IUElRCpHLUthUGRTZ1VrWHAyczV2OHkvQj9FKEgrTWJRZVRoV21ZcTN0Nnc5eiRDJEImRShIK01iUWVUaFdtWnE0dDd3IXolQypGLUpATmNSZlVqWG4ycjV1OHgvQT9EKEcrS2JQZFNnVmtZcDNzNnY5eSRCJkUpSEBNY1FmVGhXbVpxNHQ3dyF6JUMqRi1KYU5kUmdVa1huMnI1dTh4L0E_RChHK0tiUGVTaFZtWXEzczZ2OXkkQiZFKUhATWNRZlRqV25acjR1N3cheiVDKkYtSmFOZFJnVWtYcDJzNXY4eS9BP0QoRytLYlBlU2hWbVlxM3Q2dzl6JEMmRSlIQE1jUWZUalduWnI0dTd4IUElRCpHLUphTmRSZ1VrWHAyczV2OHkvQj9FKEgrTWJQZVNoVm1ZcTN0Nnc5eiRDJkYpSkBOY1JmVGpXblpyNHU3eCFBJUQqRy1LYVBkU2dWa1lwMnM1djh5L0I_RShIK01iUWVUaFdtWnE0dDZ3OXokQyZGKUpATmNSZlVqWG4ycjV1OHghQSVEKkctS2FQZFNnVmtZcDNzNnY5eSRCP0UoSCtNYlFlVGhXbVpxNHQ3dyF6JUMqRilKQE5jUmZValhuMnI1dTh4L0E_RChHK0thUGRTZ1ZrWXAzczZ2OXkkQiZFKUhATWNRZVRoV21acTR0N3cheiVDKkYtSmFOZFJnVWpYbjJyNXU4eC9BP0QoRytLYlBlU2hWbVlwM3M2djl2OHkvQj9FKEcrS2JQZVNoVm1ZcTN0Nnc5eiRDJkYpSkBNY1FmVGpXblpyNHU3eCFBJUQqRy1LYVBkUmdVa1hwMnM1djh5L0I_RShIK01iUWVUaFZtWXEzdDZ3OXokQyZGKUpATmNSZlVqWG5acjR1N3ghQSVEKkctS2FQZFNnVmtZcDNzNXY4eS9CP0UoSCtNYlFlVGhXbVpxNHQ3dzl6JEMmRilKQE5jUmZValhuMnI1dTh4L0ElRCpHLUthUGRTZ1ZrWXAzczZ2OXkkQiZFKEgrTWJRZVRoV21acTR0N3cheiVDKkYtSkBOY1JmVWpYbjJyNXU4eC9BP0QoRytLYlBkU2dWa1lwM3M2djl5JEImRSlIQE1jUWZUaFdtWnE0dDd3IXolQypGLUphTmRSZ1VrWG4ycjV1OHgvQT9EKEcrS2JQZVNoVm1ZcTNzNnY5eSRCJkUpSEBNY1FmVGpXblpyNHU3dyF6JUMqRi1KYU5kUmdVa1hwMnM1djh5L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXokQyZFKUhATWNRZlRqV25acjR1N3ghQSVEKkctS2FOZFJnVWtYcDJzNXY4eS9CP0UoSCtNYlFlU2hWbVlxM3Q2dzl6JEMmRilKQE5jUmZValduWnI0dTd4IUElRCpHLUthUGRTZ1ZrWXAyczJyNXU4eC9BP0QoRy1LYVBkU2dWa1lwM3M2djl5JEImRSlIQE1iUWVUaFdtWnE0dDd3IXolQypGLUphTmRSZlVqWG4ycjV1OHgvQT9EKEcrS2JQZVNoVmtZcDNzNnY5eSRCJkUpSEBNY1FmVGpXblpxNHQ3dyF6JUMqRi1KYU5kUmdVa1hwMnM1dTh4L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXkkQiZFKUhATWNRZlRqV25acjR1N3ghQSVDKkYtSmFOZFJnVWtYcDJzNXY4eS9CP0UoRytLYlBlU2hWbVlxM3Q2dzl6JEMmRilKQE1jUWZUalduWnI0dTd4IUElRCpHLUthUGRSZ1VrWHAyczV2OHkvQj9FKEgrTWJRZVRoVm1ZcTN0Nnc5eiRDJkYpSkBOY1JmVWpYblpyNHU3eCFBJUQqRy1LYVBkU2dWa1lwM3M1djh5L0I_RShIK01iUWVUaFdtWnE0dDd3OXokQyZGKUpATmNSZlVqWG4ycjV1OHgvQSVEKkctS2FQZFNnVmtZcDNzNnY5eSRCJkUoSCtNYlFlVGhXbVpxNHQ3dyF6JUMqRi1KQE5jUmZValhuMnI1dTh4L0E_RChHK0tiUGRTZ1ZrWXAzczZ2OXkkQiZFKUhATWNRZlRoV21acTR0N3cheiVDKkYtSmFOZFJnVWtYaXdoamRqd2lkanFzcW93YmR4aGpXblpyNHU3eCFBJUQqRi1KYU5kUmdVa1hwMnM1djh5L0I_RShIK0tiUGVTaFZtWXEzdDZ3OXokQyZGKUpATmNRZlRqV25acjR1N3ghQSVEKkctS2FQZFNnVWtYcDJzNXY4eS9CP0UoSCtNYlFlVGhXbVlxM3Q2dzl6JEMmRilKQE5jUmZValhuMnI1dTd4IUElRCpHLUthUGRTZ1ZrWXAzczZ2OXkvQj9FKEgrTWJRZVRoV21acTR0N3cheiVDJkYpSkBOY1JmVWpYbjJyNXU4eC9BP0QoRy1LYVBkU2dWa1lwM3M2djl5JEImRSlIQE1iUWVUaFdtWnE0dDd3IXolQypGLUphTmRSZlVqWG4ycjV1OHgvQT9EKEcrS2JQZVNoVmtZcDNzNnY5eSRCJkUpSEBNY1FmVGpXblpxNHQ3dyF6JUMqRi1KYU5kUmdVa1hwMnM1dTh4L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXkkQiZFKUhATWNRZlRqV25acjR1N3ghQSVDKkYtSmFOZFJnVWtYcDJzNXY4dyIsImlhdCI6IjIwMjMtMDQtMDlUMTQ6NTM6MDguOTUxWiIsImV4cCI6IjIwMjMtMDQtMDlUMTU6NTM6MDguOTUxWiJ9akjiABQxihjCSgQtuz8vDwof5zaG0OpD3sajvZv9JztaXUMKNvyUb6xnMZvgal_XtLjosFog0hW_CrJBkMwWAw";

    final response = await http
        .post(Uri.parse(url), headers: {'authorization': 'Bearer $user_token'});

    var json_response = json.decode(response.body);
    print(json_response["TRANSACTION_SECRET_TOKEN"]);
    trans_token = json_response["TRANSACTION_SECRET_TOKEN"];
  }

  void showAlertDialog() async {
    final myController = TextEditingController();

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Provide your details",
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20),
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
                        side: BorderSide(color: Color(0xFFd3d3d3), width: 1))),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => PaymentPage())))
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
        });
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
        "http://52.66.236.118:3000/userApp/transaction/initiateTransaction";
    Map<String, String> body = {
      "productId": "E1",
      "firstName": "FIRSTNAME0",
      "userEmail": "cb.en.u4cse20010@cb.students.amrita.edu",
      "address": "ADDRESS0",
      "city": "CITY0",
      "state": "STATE0",
      "country": "COUNTRY0",
      "zipcode": "123",
      "phoneNumber": "1234567890"
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
              child: Text("Error Occurred"),
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
  @override
  void initState() {
    postbody = {
      "productInfo": "E1",
      "txnid": widget.trans_map?["txid"],
      "amount": "${widget.trans_map?["amount"]}",
      "firstname": "FIRSTNAME0",
      "Lastname": "LASTNAME0",
      "email": "cb.en.u4cse20010@cb.students.amrita.edu",
      "phone": phoneNumber,
      "address1": address,
      "address2": "",
      "city": city,
      "state": state,
      "country": country,
      "Zipcode": zipcode,
      "hash": widget.trans_map?["hash"],
      "surl": "https://payu-nodejs-demo.herokuapp.com/response.html?page=ejs",
      "furl": "https://payu-nodejs-demo.herokuapp.com/response.html?page=ejs",
      "curl": "https://payu-nodejs-demo.herokuapp.com/response.html?page=ejs",
      "key": "Pz9v2c"
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
          initialUrlRequest: URLRequest(
              url: Uri.parse("https://test.payu.in/_payment"),
              method: 'POST',
              body: Uint8List.fromList(utf8.encode(encodedBody)),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
          /*initialUrl: 'https://test.payu.in/_payment',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
              _loadHtmlFromAssets();
            }*/
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    final url = Uri.parse("https://test.payu.in/_payment");

    final headers = {'Content-Type': 'text/html'};
    final encodedBody = postbody.keys
        .map((key) =>
            '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(postbody[key]!)}')
        .join('&');
    //print(encodedBody);
    print(Uri(queryParameters: postbody).query);

    /*await _controller.postUrl(url,
        body: postbody,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});*/
  }
}

class UserForm extends StatefulWidget {
  UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = "Sharath";
    _phoneController.text = "9597197934";
    _emailController.text = "cb.en.u4cse20010@cb.students.amrita.edu";
    _addressController.text = "address0";
    _cityController.text = "city0";
    _stateController.text = "state0";
    _zipController.text = "123";
    _countryController.text = "India";

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
          width: 320,
          height: 550,
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
                  height: 20,
                ),
                TextFormField(
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
                  height: 20,
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
                  height: 20,
                ),
                TextFormField(
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
                  height: 20,
                ),
                TextFormField(
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
                  height: 20,
                ),
                TextFormField(
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
                  height: 20,
                ),
                TextFormField(
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
