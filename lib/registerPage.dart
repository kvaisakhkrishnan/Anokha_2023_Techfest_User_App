import 'dart:convert';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otpValidation.dart';
import 'package:crypto/crypto.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final __url = serverUrl().url;
List<Map<String, dynamic>> collegeData = [

{'collegeId': 38377, 'collegeName': "My College is not listed"},{'collegeId': 626, 'collegeName': 'Amrita Centre for Nanomedical Sciences, Kochi (Id: C-7027)'}, {'collegeId': 627, 'collegeName': 'Amrita College of Nursing, Kochi (Id: C-7028)'}, {'collegeId': 628, 'collegeName': 'Amrita School of Arts and Sciences, Amritapuri, Kollam (Id: C-7031)'}, {'collegeId': 629, 'collegeName': 'Amrita School of Arts and Sciences, Kochi (Id: C-7030)'}, {'collegeId': 630, 'collegeName': 'Amrita School of Arts and Sciences, Mysore (Id: C-7035)'}, {'collegeId': 631, 'collegeName': 'Amrita School of Ayurveda, Amritapuri, Kollam (Id: C-7026)'}, {'collegeId': 632, 'collegeName': 'Amrita School of Biotechnology, Amritapuri, Kollam (Id: C-7025)'}, {'collegeId': 633, 'collegeName': 'Amrita School of Business, Coimbatore (Id: C-7023)'}, {'collegeId': 634, 'collegeName': 'Amrita School of Dentistry, Kochi (Id: C-7019)'}, {'collegeId': 635, 'collegeName': 'Amrita School of Education, Mysore (Id: C-7032)'}, {'collegeId': 636, 'collegeName': 'Amrita School of Engineering, Amritapuri, Kollam (Id: C-7036)'}, {'collegeId': 637, 'collegeName': 'Amrita School of Engineering, Bangalore (Id: C-7034)'}, {'collegeId': 638, 'collegeName': 'Amrita School of Engineering, Coimbatore (Id: C-7021)'}, {'collegeId': 639, 'collegeName': 'Amrita School of Medicine, Kochi (Id: C-7017)'}, {'collegeId': 640, 'collegeName': 'Amrita School of Pharmacy, Kochi (Id: C-7018)'}, {'collegeId': 641, 'collegeName': 'Department of Communication, Coimbatore (Id: C-7024)'}, {'collegeId': 642, 'collegeName': 'Department of Management, Amritapuri, Kollam (Id: C-7020)'}, {'collegeId': 645, 'collegeName': 'Department of Social Work, Coimbatore (Id: C-7033)'}, {'collegeId': 988, 'collegeName': 'Adithya Institute of Technology (Id: C-37053)'}, {'collegeId': 992, 'collegeName': 'AJK Institute of Management (Id: C-37098)'}, {'collegeId': 993, 'collegeName': 'Akshaya College of Engineering and Technology (Id: C-36985)'}, {'collegeId': 994, 'collegeName': 'AKSHAYA INSTITUTE OF MANAGEMENT STUDIES, COIMBATORE (Id: C-46582)'}, {'collegeId': 1030, 'collegeName': 'ARULMURUGA TECHNICAL CAMPUS (Id: C-48254)'}, {'collegeId': 1034, 'collegeName': 'ASL Pauls College of Engineering and Technology (Id: C-37009)'}, {'collegeId': 1059, 'collegeName': 'CHERAN COLLEGE OF ENGINEERING (Id: C-48255)'}, {'collegeId': 1060, 'collegeName': 'CHERAN SCHOOL OF ARCHITECTURE (Id: C-48256)'}, {'collegeId': 1063, 'collegeName': 'Christ The King Engineering College (Id: C-36941)'}, {'collegeId': 1066, 'collegeName': 'CMS College of Engineering and Technology (Id: C-37075)'}, {'collegeId': 1067, 'collegeName': 'Coimbatore Institute of Engineering and Technology (Id: C-36942)'}, {'collegeId': 1068, 'collegeName': 'Coimbatore Institute of Technology (Id: C-36969)'}, {'collegeId': 1078, 'collegeName': 'Dhanalakshmi Srinivasan College of Engineering (Id: C-37103)'}, {'collegeId': 1088, 'collegeName': 'Dr.Mahalingam College of Engineering and Technology (Id: C-37050)'}, {'collegeId': 1092, 'collegeName': 'Dr N.G.P. Institute of Technology (Id: C-36929)'}, {'collegeId': 1095, 'collegeName': 'Easa College of Engineering & Technology (Id: C-36991)'}, {'collegeId': 1126, 'collegeName': 'Government College of Technology (Id: C-36975)'}, {'collegeId': 1129, 'collegeName': 'Happy Valley Business School (Id: C-36939)'}, {'collegeId': 1130, 'collegeName': 'Hindusthan College of Engineering and Technology (Id: C-37063)'}, {'collegeId': 1131, 'collegeName': 'Hindusthan Institute of Technology (Id: C-37046)'}, {'collegeId': 1134, 'collegeName': 'HOSUR INSTITUTE OF TECHNOLOGY AND SCIENCE (Id: C-48257)'}, {'collegeId': 1143, 'collegeName': 'Indus College of Engineering (Id: C-36934)'}, {'collegeId': 1146, 'collegeName': 'Info Institute of Engineering (Id: C-37031)'}, {'collegeId': 1150, 'collegeName': 'Jansons Institute of Technology (Id: C-37021)'}, {'collegeId': 1152, 'collegeName': 'Jawaharlal Institute of Technology (Id: C-37090)'}, {'collegeId': 1162, 'collegeName': 'JCT College of Engineering and Technology (Id: C-37055)'}, {'collegeId': 1175, 'collegeName': 'Kalaignar Karunanidhi Institute of Technology (Id: C-37070)'}, {'collegeId': 1176, 'collegeName': 'Kalaivani College of Technology (Id: C-37042)'}, {'collegeId': 1183, 'collegeName': 'Karpagam College of Engineering (Id: C-37044)'}, {'collegeId': 1184, 'collegeName': 'Karpagam Institute of Technology (Id: C-37035)'}, {'collegeId': 1188, 'collegeName': 'Kathir College of Engineering (Id: C-36988)'}, {'collegeId': 1190, 'collegeName': 'KGiSL Institute of Technology (Id: C-36989)'}, {'collegeId': 1204, 'collegeName': 'KPR Institute of Engineering and Technology (Id: C-36999)'}, {'collegeId': 1205, 'collegeName': 'KPR School of Business (Id: C-37079)'}, {'collegeId': 1214, 'collegeName': 'KTVR Knowledge Park for Engineering & Technology (Id: C-36931)'}, {'collegeId': 1215, 'collegeName': 'Kumaraguru college of Technology (Id: C-36926)'}, {'collegeId': 1218, 'collegeName': 'KV Institute of Management and Information Studies (Id: C-36946)'}, {'collegeId': 1239, 'collegeName': 'Maharaja Institute of Technology (Id: C-37007)'}, {'collegeId': 1290, 'collegeName': 'Nehru Institute of Engineering and Technology (Id: C-37025)'}, {'collegeId': 1291, 'collegeName': 'Nehru Institute of Information Technology and Management (Id: C-37037)'}, {'collegeId': 1292, 'collegeName': 'Nehru Institute of Management Studies (Id: C-36962)'}, {'collegeId': 1294, 'collegeName': 'NIGHTINGALE INSTITUTE OF TECHNOLOGY (Id: C-48258)'}, {'collegeId': 1296, 'collegeName': 'N.R. SCHOOL OF ARCHITECTURE, COIMBATORE (Id: C-45286)'}, {'collegeId': 1306, 'collegeName': 'P.A.College of Engineering and Technology (Id: C-37041)'}, {'collegeId': 1314, 'collegeName': 'Park College of Engineering and Technology (Id: C-37015)'}, {'collegeId': 1315, 'collegeName': 'Park College of Technology (Id: C-37049)'}, {'collegeId': 1325, 'collegeName': 'POLLACHI INSTITUTE OF ENGINEERING AND TECHNOLOGY (Id: C-48259)'}, {'collegeId': 1328, 'collegeName': 'PPG Business School (Id: C-37014)'}, {'collegeId': 1329, 'collegeName': 'PPG Institute of Technology (Id: C-37043)'}, {'collegeId': 1330, 'collegeName': 'Prahar School of Architecture (Id: C-37072)'}, {'collegeId': 1338, 'collegeName': 'PSG College of Technology (Id: C-37013)'}, {'collegeId': 1353, 'collegeName': 'Ranganathan Architecture College (Id: C-37093)'}, {'collegeId': 1354, 'collegeName': 'Ranganathan Engineering College (Id: C-36972)'}, {'collegeId': 1356, 'collegeName': 'RATHINAM TECHNICAL CAMPUS, COIMBATORE (Id: C-45287)'}, {'collegeId': 1367, 'collegeName': 'RVS College of Computer Application (Id: C-36973)'}, {'collegeId': 1368, 'collegeName': 'RVS College of Engineering and Technology (Id: C-36938)'}, {'collegeId': 1370, 'collegeName': "RVS Educational Trust's Group of Institutions (Id: C-37001)"}, {'collegeId': 1371, 'collegeName': 'RVS Institute of Management Studies (Id: C-37086)'}, {'collegeId': 1375, 'collegeName': 'R.V.S. School of Architecture (Id: C-37082)'}, {'collegeId': 1383, 'collegeName': 'Sakthi Institute of Information and Management Studies (Id: C-37067)'}, {'collegeId': 1387, 'collegeName': 'SAN International Business School (Id: C-37102)'}, {'collegeId': 1388, 'collegeName': 'SAN International Info School (Id: C-37081)'}, {'collegeId': 1394, 'collegeName': 'SASI CREATIVE SCHOOL OF ARCHITECTURE (Id: C-48260)'}, {'collegeId': 1395, 'collegeName': 'Sasi Creative School of Business (Id: C-37066)'}, {'collegeId': 1396, 'collegeName': 'Sasurie Academy of Engineering (Id: C-36977)'}, {'collegeId': 1403, 'collegeName': 'SCAD INSTITUTE OF TECHNOLOGY (Id: C-48261)'}, {'collegeId': 1430, 'collegeName': 'SNS College of Engineering (Id: C-37036)'}, {'collegeId': 1431, 'collegeName': 'SNS College of Technology (Id: C-36947)'}, {'collegeId': 1432, 'collegeName': 'SNT Global Academy of Management Studies and Technology (Id: C-36964)'}, {'collegeId': 1435, 'collegeName': 'Sree Narayana Guru Institute of Management Studies (Id: C-37085)'}, {'collegeId': 1436, 'collegeName': 'Sree Sakthi Engineering College (Id: C-36956)'}, {'collegeId': 1445, 'collegeName': 'Sri Eshwar College of Engineering (Id: C-37057)'}, {'collegeId': 1447, 'collegeName': 'Sriguru Institute Of Technology (Id: C-36994)'}, {'collegeId': 1449, 'collegeName': 'Sri Krishna College of Engineering and Technology (Id: C-36995)'}, {'collegeId': 1450, 'collegeName': 'Sri Krishna College of Technology (Id: C-37064)'}, {'collegeId': 1452, 'collegeName': 'Sri Krishna Institute of Management (Id: C-37008)'}, {'collegeId': 1461, 'collegeName': 'Sri Ramakrishna Engineering College (Id: C-37089)'}, {'collegeId': 1462, 'collegeName': 'Sri Ramakrishna Institute of Technology (Id: C-37032)'}, {'collegeId': 1467, 'collegeName': 'SRI RANGANATHAR INSTITUTE OF ENGINEERING AND TECHNOLOGY, COIMBATORE (Id: C-45288)'}, {'collegeId': 1471, 'collegeName': 'Sri Shakthi Institute of Engineering and Technology (Id: C-37080)'}, {'collegeId': 1477, 'collegeName': 'Sri Venkateswara College of Computer Applications and Management (Id: C-37100)'}, {'collegeId': 1480, 'collegeName': 'Sri Venkateswara Institute of Information Technology and Management (Id: C-37024)'}, {'collegeId': 1499, 'collegeName': 'SUGUNA COLLEGE OF ENGINEERING (Id: C-48263)'}, {'collegeId': 1506, 'collegeName': 'SVS College Of Engineering (Id: C-37084)'}, {'collegeId': 1507, 'collegeName': 'SVS Institute of Computer Applications (Id: C-37060)'}, {'collegeId': 1508, 'collegeName': 'SVS Institute of Management Studies (Id: C-36968)'}, {'collegeId': 1509, 'collegeName': 'SVS School of Architecture (Id: C-37078)'}, {'collegeId': 1513, 'collegeName': 'Tamilnadu College of Engineering (Id: C-37010)'}, {'collegeId': 1514, 'collegeName': 'Tamilnadu School of Architecture (Id: C-37030)'}, {'collegeId': 1516, 'collegeName': 'Tejaa Shakthi Institute of Technology for Women (Id: C-37012)'}, {'collegeId': 1535, 'collegeName': 'United Institute of Technology (Id: C-36990)'}, {'collegeId': 1567, 'collegeName': 'VIVEKANANDA INSTITUTE OF MANAGEMENT STUDIES (Id: C-48267)'}, {'collegeId': 1579, 'collegeName': 'V.S.B COLLEGE OF ENGINEERING TECHNICAL CAMPUS (Id: C-48266)'}, {'collegeId': 3294, 'collegeName': 'Air Force Administrative College (Id: C-41053)'}, {'collegeId': 3295, 'collegeName': 'AJK College of Arts and Science (Id: C-41080)'}, {'collegeId': 3296, 'collegeName': 'Angappa College of Arts and Science (Id: C-41070)'}, {'collegeId': 3297, 'collegeName': 'Ayyan Thiruvalluvar College of Arts and Science (Id: C-41062)'}, {'collegeId': 3298, 'collegeName': 'Bharathiar University Arts and science College (Id: C-41114)'}, {'collegeId': 3304, 'collegeName': 'Bishop Ambrose College (Id: C-41136)'}, {'collegeId': 3305, 'collegeName': 'Bishop Appasamy College of Arts and Science (Id: C-41075)'}, {'collegeId': 3307, 'collegeName': 'CBM College (Id: C-41095)'}, {'collegeId': 3312, 'collegeName': 'CMS Academy of Management and Technology (Id: C-41132)'}, {'collegeId': 3313, 'collegeName': 'CMS College of Science and Commerce (Id: C-41096)'}, {'collegeId': 3314, 'collegeName': 'CMS Institute of Management Studies (Id: C-41065)'}, {'collegeId': 3315, 'collegeName': 'Coimbatore Institute of Management and Technology (Id: C-41090)'}, {'collegeId': 3316, 'collegeName': 'D.J.Academy for Managerial Excellence (Id: C-41107)'}, {'collegeId': 3317, 'collegeName': 'Dr.G.R.Damodaran College of Science (Id: C-41044)'}, {'collegeId': 3318, 'collegeName': 'Dr.N.G.P. Arts and Science College (Id: C-41054)'}, {'collegeId': 3320, 'collegeName': 'Dr.R.V.Arts and Science College (Id: C-41099)'}, {'collegeId': 3321, 'collegeName': 'Dr.S.N.S.Rajalakshmi College of Arts and Science (Id: C-41042)'}, {'collegeId': 3326, 'collegeName': 'Government Arts College, Coimbatore (Id: C-41035)'}, {'collegeId': 3329, 'collegeName': 'G.R.Damodaran Academy of Management (Id: C-41088)'}, {'collegeId': 3330, 'collegeName': 'Guruvayurappan Institute of Management (Id: C-41103)'}, {'collegeId': 3331, 'collegeName': 'Hindusthan College of Arts and Science (Id: C-41049)'}, {'collegeId': 3335, 'collegeName': 'Kamban College of Arts and Science (Id: C-41047)'}, {'collegeId': 3338, 'collegeName': 'K.G. College of Arts and Science (Id: C-41125)'}, {'collegeId': 3339, 'collegeName': 'KGISL Institute of Information Management (Id: C-41127)'}, {'collegeId': 3341, 'collegeName': 'Kongunadu Arts and Science College (Id: C-41106)'}, {'collegeId': 3342, 'collegeName': 'Kovai Kalaimagal College of Arts and Science (Id: C-41034)'}, {'collegeId': 3343, 'collegeName': 'K.S.G. College of Arts and Science (Id: C-41058)'}, {'collegeId': 3344, 'collegeName': 'Lakshmi Narayana Visalakshi College of Arts and Science (Id: C-41108)'}, {'collegeId': 3346, 'collegeName': 'Maharaja Arts and Science College (Id: C-41118)'}, {'collegeId': 3349, 'collegeName': 'Michael Job College of Arts and Science for Women (Id: C-41123)'}, {'collegeId': 3352, 'collegeName': 'Nehru Arts and Science College (Id: C-41133)'}, {'collegeId': 3353, 'collegeName': 'Nehru College of Management (Id: C-41105)'}, {'collegeId': 3354, 'collegeName': 'N G M College (Id: C-41073)'}, {'collegeId': 3357, 'collegeName': 'Nirmala College for Women (Id: C-41069)'}, {'collegeId': 3359, 'collegeName': 'Pioneer College of Arts and Science (Id: C-41112)'}, {'collegeId': 3362, 'collegeName': 'PSG College of Arts and Science (Id: C-41124)'}, {'collegeId': 3363, 'collegeName': 'PSGR Krishnammal College for Women (Id: C-41046)'}, {'collegeId': 3364, 'collegeName': 'Rathinam College of Arts and Science (Id: C-41134)'}, {'collegeId': 3365, 'collegeName': 'Rathinavel Subramaniam College (Id: C-41037)'}, {'collegeId': 3366, 'collegeName': 'SAN INTERNATIONAL COLLEGE OF ARTS AND SCIENCE, COIMBATORE (Id: C-46608)'}, {'collegeId': 3367, 'collegeName': 'Sankara College of Science and Commerce (Id: C-41064)'}, {'collegeId': 3370, 'collegeName': 'Shiri Kumaran College of Arts and Science (Id: C-41121)'}, {'collegeId': 3371, 'collegeName': 'S.M.S. College of Arts and Science (Id: C-41078)'}, {'collegeId': 3372, 'collegeName': 'S N R Sons College (Id: C-41100)'}, {'collegeId': 3374, 'collegeName': 'Sree Narayana Guru College (Id: C-41130)'}, {'collegeId': 3375, 'collegeName': 'Sree Ramu College of Arts and Science (Id: C-41079)'}, {'collegeId': 3376, 'collegeName': 'Sree Saraswathi Thiagaraja College (Id: C-41097)'}, {'collegeId': 3377, 'collegeName': 'Sri Gee College of Arts and Science (Id: C-41129)'}, {'collegeId': 3379, 'collegeName': 'Sri Jeyandra Saraswathy Maha Vidyalaya College of Arts & Science (Id: C-41082)'}, {'collegeId': 3380, 'collegeName': 'Sri Krishna Arts and Science College (Id: C-41126)'}, {'collegeId': 3381, 'collegeName': 'Sri Nehru Maha Vidyalaya College of Arts and Science (Id: C-41040)'}, {'collegeId': 3382, 'collegeName': 'Sri Ramakrishna College of Arts and Science for Women (Id: C-41059)'}, {'collegeId': 3383, 'collegeName': 'Sri Ramalinga Sowdambigai College of Science and Commerce (Id: C-41115)'}, {'collegeId': 3384, 'collegeName': 'Sri Subash Arts and Science College (Id: C-41045)'}, {'collegeId': 3386, 'collegeName': 'SRMV College of Arts and Science (Id: C-41077)'}, {'collegeId': 3388, 'collegeName': 'St. Pauls College of Arts and Science for Women (Id: C-41101)'}, {'collegeId': 3390, 'collegeName': 'Texcity Arts and Science College (Id: C-41085)'}, {'collegeId': 3391, 'collegeName': 'Thavathiru Santhalinga Adigalar Arts, Science and Tamil College (Id: C-41076)'}, {'collegeId': 3396, 'collegeName': 'VLB Janaki Ammal College of Arts and Science (Id: C-41083)'}, {'collegeId': 3397, 'collegeName': 'V.N.Krishnasamy Naidu College of Arts and Science for Women (Id: C-41094)'}, {'collegeId': 3398, 'collegeName': 'Wisdom School of Management (Id: C-41038)'}, {'collegeId': 9332, 'collegeName': 'Institute of Forest Genetics & Tree Breeding (Id: C-44356)'}, {'collegeId': 13491, 'collegeName': 'Amrita Sai Institute of Science & Technology, Amrita Sai Nagar, Paritala (PO), Kanchikacherla (MD), PIN-521180 (CC-AJ) (Id: C-17907)'}

];


class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  String? customPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length > 25) {
      return 'Password cant exceed 25 characters';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }
    return null;
  }

  String errorMessage = "";


  bool _showCollegeError = false;

  bool _isCollegeValid = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _collegeController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final _formKey = GlobalKey<FormState>();

  String? customEmailValidator(String? value) {
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    if (!value.endsWith('@cb.students.amrita.edu') &&
        !value.endsWith('@av.amrita.edu') &&
        !value.endsWith('@cb.amrita.edu') &&
        !value.endsWith('@av.students.amrita.edu')) {
      try {
        int collegeId = int.parse(_collegeController.text.split("-")[0].trim());
        print(collegeId);
        if (collegeId == 633 || collegeId == 638 || collegeId == 641 ||
            collegeId == 645 || collegeId == 38378) {
          return 'You are an Amrita student\nplease register with your college email address';
        }
      } catch (e) {
        setState(() {
          _showCollegeError = true;
          _showCollegeError = true;
        });
        return null;
      }
    }
    setState(() {
      _showCollegeError = false;
    });
    return null;
  }


  Future<void> _sendDataToBackend() async {
    try {
      var bytes = utf8.encode(_passwordController.text);
      var digest = sha512.convert(bytes);
      final response = await http.post(
        Uri.parse(__url + "userApp/registerUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fullName': _fullNameController.text,
          'userEmail': _emailController.text,
          'phoneNumber': _mobileNumberController.text,
          'password': digest.toString(),
          'collegeId': int.parse(_collegeController.text.split("-")[0].trim()),
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Extract the token from the response body
        final responseBody = jsonDecode(response.body);
        final String token = responseBody['SECRET_TOKEN'];

        // Navigate to the new page and pass the token
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OTPVerify(token: token, email: _emailController.text),
          ),
        );
      } else if (response.statusCode == 409) {
        print("in");
        setState(() {
          errorMessage = "You have already registered";
        });
        // Show an error below the register button
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You have already registered'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        // Show a generic error message
        setState(() {
          errorMessage = "You have already registered";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
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
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      constraints: BoxConstraints.expand(
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.19),
                      child: Image(
                        image: const AssetImage('Images/logo.png'),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      "Register",
                      style:GoogleFonts.dmSans(textStyle: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFF002845),
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: const Color(0xffF3F2F7),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 40.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _fullNameController,
                                      decoration: const InputDecoration(
                                        hintText: "Full Name",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your full name';
                                        }
                                        if (value.length > 25) {
                                          return 'Full name should be at most 25 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: "Email Address",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: customEmailValidator,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _mobileNumberController,
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        hintText: "Mobile Number",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your mobile number';
                                        }
                                        if (value.length != 10) {
                                          return 'Mobile number should be 10 digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                              !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: customPasswordValidator,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _confirmPasswordController,
                                      obscureText: _obscureConfirmPassword,
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureConfirmPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureConfirmPassword =
                                              !_obscureConfirmPassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please confirm your password';
                                        }
                                        if (_passwordController.text != value) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: DropDownField(
                                      controller: _collegeController,
                                      hintText: "Select a College",
                                      enabled: true,
                                      items: collegeData.map((college) {
                                        return "${college['collegeId']} - ${college['collegeName']} (${college['state']}, ${college['district']})";
                                      }).toList(),
                                      onValueChanged: (value) {
                                        setState(() {
                                          _isCollegeValid =
                                              value != null && value.isNotEmpty;
                                        });
                                      },
                                    ),
                                  ),
                                  if (_showCollegeError)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 0, 0, 8),
                                      child: Text(
                                        'Please select a college',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),


                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 30.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        if (_formKey.currentState != null &&
                                            _formKey.currentState!.validate() &&
                                            _isCollegeValid) {
                                          // Proceed with sending data to the backend
                                          _sendDataToBackend();
                                        } else if (!_isCollegeValid) {
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     content: Text('Please select a college.'),
                                          //   ),
                                          // );
                                          print("Enter College Name");
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFFFF7F11),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 13.0,
                                            horizontal: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.3),
                                      ),
                                      child:Text(
                                        "REGISTER",
                                        style: GoogleFonts.dmSans(textStyle:  TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0)),
                                      ),
                                    ),
                                  ),
                                  if(errorMessage != "")
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(errorMessage,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.red),),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Already Registered?",
                                      style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 17.0)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1.0),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "LOGIN",
                                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                                              color: Color(0xFFFF7F11))),
                                        )),
                                  )
                                ],
                              ),
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
}

