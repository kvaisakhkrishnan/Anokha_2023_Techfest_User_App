import 'package:anokha_home/payments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


//Buy passport page
class PassportBuy extends StatefulWidget {
  var data;
  PassportBuy({Key? key, required this.data}) : super(key: key);

  @override
  State<PassportBuy> createState() => _PassportBuyState();
}

class _PassportBuyState extends State<PassportBuy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff002845),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xff002845),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 20, bottom: 30),
            child: Text(
              "Passport - Your Visa into Anokha",
              style: GoogleFonts.dmSans(textStyle: TextStyle(
                  color: Color(0xffbeb7a4),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.15),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.width * 0.70 * 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage("Images/passport.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.03,
                left: MediaQuery.of(context).size.width * 0.27,
                right: MediaQuery.of(context).size.width * 0.27),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PayU(
                              data: widget.data,
                              event_data: null,
                              isPassport: true,
                            )));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  "BUY PASSPORT",
                  style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.black)),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffbeb7a4), elevation: 0 // Background color
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "The Anokha passport is the exclusive entry ticket that provides access to the Anokha tech fest. All except Amrita Vishwa Vidyapeetham Coimbatore campus students must purchase a passport before registering for events and workshops. Students of the Coimbatore campus need not purchase a passport as long as they register for events and workshops using their registered Amrita email-id. The passport is priced at ₹500 (including GST) and only guarantees entry to the tech fest. The events and workshops all have separate registration fees. Physical copies of the passport will not be provided instead, the QR code that will be provided on purchase of the passport must be produced to gain access to the events and workshops on all three days of the tech fest.",
              style: GoogleFonts.dmSans(textStyle:  TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          )
        ],
      ),
    );
  }
}
