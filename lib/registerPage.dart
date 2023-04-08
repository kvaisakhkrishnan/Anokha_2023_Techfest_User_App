import 'dart:convert';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'Loading_Screens/events_loading.dart';

class College {
  final int collegeId;
  final String universityName;
  final String collegeName;
  final String district;
  final String state;
  final String country;

  College({
    required this.collegeId,
    required this.universityName,
    required this.collegeName,
    required this.district,
    required this.state,
    required this.country,
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      collegeId: json['collegeId'],
      universityName: json['universityName'],
      collegeName: json['collegeName'],
      district: json['district'],
      state: json['state'],
      country: json['country'],
    );
  }
}

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final __url = serverUrl().url;
var collegeData = '';

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  List<College> parseColleges(String jsonData) {
    final List parsedJson = jsonDecode(jsonData);
    return parsedJson.map((college) => College.fromJson(college)).toList();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController collegeNameController = TextEditingController();
  College? _selectedCollege;

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse(__url + 'userApp/getCollegeData'));

      if (response.statusCode == 200) {
        collegeData = response
            .body; // Store the JSON string instead of decoded JSON object
        print(collegeData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    if (collegeData.isNotEmpty) {
      List<College> colleges = parseColleges(collegeData);
      _selectedCollege = colleges.first;
      collegeNameController.text = _selectedCollege!.collegeName;
    }
  }

  Future<void> registerUser() async {
    String url = __url + 'userApp/register';
    print(fullNameController.text);
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "fullName": fullNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text,
        "collegeName": collegeNameController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Registration successful
      // Navigate to another page or show success message
    } else {
      // Registration failed
      // Show error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        List<College> colleges = parseColleges(collegeData);
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('./Images/logo.png'),
                                fit: BoxFit.contain,
                                alignment: Alignment.bottomCenter),
                          ),
                          constraints: BoxConstraints.expand(
                              height: MediaQuery.of(context).size.width * 0.2),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          color: Color(0xffF3F2F7),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 40.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: TextField(
                                        controller: fullNameController,
                                        decoration: InputDecoration(
                                          hintText: "Full Name",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F2F7)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: TextField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          hintText: "Email Address",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F2F7)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: TextField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F2F7)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: TextField(
                                        controller: confirmPasswordController,
                                        decoration: InputDecoration(
                                          hintText: "Confirm Password",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F2F7)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Autocomplete<College>(
                                        optionsBuilder: (TextEditingValue
                                            textEditingValue) {
                                          if (textEditingValue.text == '') {
                                            return const Iterable<
                                                College>.empty();
                                          }
                                          return colleges
                                              .where((College college) {
                                            return college.collegeName
                                                .toLowerCase()
                                                .contains(textEditingValue.text
                                                    .toLowerCase());
                                          });
                                        },
                                        onSelected: (College newValue) {
                                          setState(() {
                                            _selectedCollege = newValue;
                                            collegeNameController.text =
                                                _selectedCollege!.collegeName;
                                          });
                                        },
                                        displayStringForOption: (College
                                                option) =>
                                            '${option.collegeName}, ${option.district}, ${option.state}',
                                        fieldViewBuilder: (BuildContext context,
                                            TextEditingController
                                                fieldTextEditingController,
                                            FocusNode fieldFocusNode,
                                            VoidCallback onFieldSubmitted) {
                                          return TextField(
                                            controller:
                                                fieldTextEditingController,
                                            focusNode: fieldFocusNode,
                                            decoration: InputDecoration(
                                              hintText: "College Name",
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xffF3F2F7)),
                                              ),
                                            ),
                                          );
                                        },
                                        optionsViewBuilder:
                                            (BuildContext context,
                                                AutocompleteOnSelected<College>
                                                    onSelected,
                                                Iterable<College> options) {
                                          return Align(
                                            alignment: Alignment.topLeft,
                                            child: Material(
                                              elevation: 4.0,
                                              child: SizedBox(
                                                height: 200,
                                                child: ListView.builder(
                                                  itemCount: options.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final College option =
                                                        options
                                                            .elementAt(index);
                                                    return ListTile(
                                                      title: Text(
                                                        '${option.collegeName}, ${option.district}, ${option.state}',
                                                      ),
                                                      onTap: () {
                                                        onSelected(option);
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.0),
                                      child: OutlinedButton(
                                        onPressed: registerUser,
                                        child: Text(
                                          "REGISTER",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Color(0xFFFF7F11),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 13.0,
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        "Already Registered?",
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 1.0),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                color: Color(0xFFFF7F11)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      }
      else{
        return Scaffold(body: Events_Loading_screen(),);
      }
    });
  }
}
