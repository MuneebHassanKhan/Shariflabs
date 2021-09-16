import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  void customlaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      throw 'Could not launch $command';
    }
  }

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
                                    builder: (BuildContext context) =>
                                        MainBody(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Image.asset('images/back.png')),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Contact Us",
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
                Center(
                  child: SizedBox(
                    width: 340,
                    height: 75,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 25),
                      onPressed: () async {
                        customlaunch('tel:+92512120967');
                      },
                      color: Color(0xFFeeeeee),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Call",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF025a9a)),
                          ),
                          Text(
                            "+92512120967",
                            style: TextStyle(color: Color(0xFF025a9a)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 340,
                    height: 75,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 25),
                      onPressed: () async {
                        customlaunch(
                            'mailto:shariflabsanddiagnostics@gmail.com');
                      },
                      color: Color(0xFFeeeeee),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF025a9a)),
                          ),
                          Text(
                            "Shariflabsanddiagnostics@gmail.com",
                            style: TextStyle(color: Color(0xFF025a9a)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 340,
                    height: 80,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 25),
                      onPressed: () async {},
                      color: Color(0xFF025a9a),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Office No. 6,Ground Floor Feroz Centre,Fazle Haq Road,Blue Area,Islamabad,Pakistan",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
