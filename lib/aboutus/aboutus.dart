import 'package:flutter/material.dart';
import '../main.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/bggg.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainBody(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Image.asset('images/back.png')),
                        ),
                      ),
                      // SizedBox(
                      //   width: 70,
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "About Us",
                          style: TextStyle(
                            color: Color(0xFF025a9a),
                            fontSize: 45,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 200),
          child: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "About us",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Sharif Labs and Diagnostics offers outstanding\nservices in areas of Hematology, Endocrinology,\nClinical Pathology, Microbiology,Molecular Biology\nand Histopathology with its state-of art technology\n.Further to our diagnostic services,our respected\nclients enjoy our luxurious customer’s\nservices having an easy accessto the reports via\nonline free urgent reporting,SMS reporting\nservices and Whatsapp reporting.Addition\nto previously said services, we also provide\n“Free” home sample collection services.To enjoy\nour constantly evolving innovative services,\nstayconnected with us.",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "100% gurantee",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Sharif Labs and Diagnostics with latest use of \ntechnology and best human resources provide you \nwith accurate lab tests results.",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Qualified Team",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "A team of highly qualified doctors and specialist, \nSharif Labs and Diagnostics provides excellent \nfacilities to the people.",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Service with care",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Client with an easy access to the web,enjoyed our \nesteemed and luxurious customer services by \ngetting their reports.",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Our experience",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Our technical staff are certified scientific and highly\nskilled with extensive experience in clinical \nlab.",
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
