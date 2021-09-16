import 'package:flutter/material.dart';

import '../main.dart';

class OurServices extends StatefulWidget {
  const OurServices({Key key}) : super(key: key);

  @override
  _OurServicesState createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
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
                                  builder: (BuildContext context) => MainBody(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Image.asset('images/back.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 75,
                      ),
                      Text(
                        "Services",
                        style: TextStyle(
                          color: Color(0xFF025a9a),
                          fontSize: 45,
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
                      "Our lab provide wide range of services in every\nsituation to accommodate customers. Following\nfacilities provided by us:-",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "DEXA Scan \nLab Investigations \nX-Ray CR \nECG \nUltrasound/ Color Doppler \nOverseas Medical",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "School Health Service",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Millions of people Pakistan die every year due to\nHepatitis B infection. Hepatitis B is an infection of your\nliver and detection of disease at early stage can help\nto prevent arising from it.It can cause your liver failure,\ncancer at later stage and can be fatal if it is not treated\nHepatitis B spread because of blood exchange,open\nsores, or body fluids of someone.According to health\nofficial reports,hepatitis B and C virus spreading in the\ncountry and affecting 1.45 million people. ",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Pathology",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "In medical science, examination of surgically removed\norgans,tissues,bodily fluids,and in some cases the\nwhole body (autopsy) called Pathology.Pathologists\nspecialized including cancer and vastmajority of\ncancerdiagnoses are made by pathologists.Micros-\ncopehelp to study cellular pattern of tissue and\ndetermine if a sample is cancerous or non-cancerous\nGenetic studies and gene markers are also studied\nby Pathologists nassessment of various diseases.",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Radiology",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        "The Radiology department at Sharif Labs and \nDiagnostics is flourishing and expanding academic\nstandards.We by using state of art technology\nproviding highest standards of care with qualified \nmedical and technical staff. Lab has a number of\nX-Ray,Ultrasound, Doppler and ECG facilities."),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Ultrasound ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        "Sound wave technology is used in ultrasound to\nproduce pictures of inside body organs.Causes\nof pain,swelling and infection in the body internal\norgans, examination of baby in pregnant women\nit is most commonly used."),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "ECG",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        "Heart diseases are common health challenge to our\ntime.With increased research in this field,cardiac\ndiseases has led to new and effective treatments,\noffering fresh hope to many patients."),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "DEXA Scan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        "Dexa scan is most precise,fast and convenient way to\ndetermine a woman’s risk of developing osteoporosis.\nForthorough history and risk assessment,this also help\nto evaluate the measurement of height and weight."),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Color Doppler Scan ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        "Doppler scan is used to monitor the blood flow in\nblood vessels and to measure the blood\ncirculation in various organs.Relative velocity of\nblood can be obtained through color Doppler."),
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
