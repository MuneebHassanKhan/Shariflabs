import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shareeflabs/viewreport/viewreport.dart';

import '../main.dart';
import 'labreportmodel.dart';

class LabReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatientLabReport(),
    );
  }
}

class PatientLabReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PatientLabReportState();
}

class PatientLabReportState extends State<PatientLabReport> {
  Future<PatientModel> _patientData;
  final TextEditingController id = TextEditingController();
  final TextEditingController gettest_id = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<PatientModel> _getPatient(Map<String, Object> obj) async {
    final response = await http.post(
      Uri.https("shariflabs.pk", "api/track.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(obj),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final jsonBody = json.decode(response.body);
      return new PatientModel.fromJson(jsonBody);
    } else
      throw Exception("Unable to get Patient list");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                          width: 50,
                        ),
                        Text(
                          "Lab Report",
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
            padding: const EdgeInsets.only(top: 130.0),
            child: Center(
              child: (_patientData == null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          controller: gettest_id,
                          decoration: InputDecoration(
                            labelText:
                                "Search record by TrackingID/Passport/CNIC",
                            hintText:
                                "Search record by TrackingID/Passport/CNIC",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton.icon(
                              label: Text('Search'),
                              icon: Icon(Icons.search),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF025a9a),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    var data = {
                                      "test_id": 0,
                                      "id": gettest_id.text
                                    };
                                    print(jsonEncode(data));
                                    _patientData = _getPatient(data);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : FutureBuilder<PatientModel>(
                      future: _patientData,
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: ListView.builder(
                                itemCount: snapshot.data.tests.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 75,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF025a9a),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                              snapshot
                                                  .data.tests[index].testName,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Text(
                                              snapshot
                                                  .data.tests[index].details,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              String ptn = snapshot.data.ptn;
                                              String patientName =
                                                  snapshot.data.patientName;
                                              String gender =
                                                  snapshot.data.gender;
                                              String patientDob =
                                                  snapshot.data.patientDob;
                                              String passportNo =
                                                  snapshot.data.passportNo;
                                              String ticketPnrNo =
                                                  snapshot.data.ticketPnrNo;
                                              String sampleDate =
                                                  snapshot.data.sampleDate;
                                              String sampleTime =
                                                  snapshot.data.sampleTime;
                                              String testName = snapshot
                                                  .data.tests[index].testName;
                                              String testId = snapshot
                                                  .data.tests[index].testId;
                                              String testResult = snapshot
                                                  .data.tests[index].testResult;
                                              String details = snapshot
                                                  .data.tests[index].details;

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewReport(
                                                    ptn: ptn,
                                                    patientName: patientName,
                                                    gender: gender,
                                                    patientDob: patientDob,
                                                    passportNo: passportNo,
                                                    ticketPnrNo: ticketPnrNo,
                                                    sampleDate: sampleDate,
                                                    sampleTime: sampleTime,
                                                    testName: testName,
                                                    testId: testId,
                                                    testResult: testResult,
                                                    details: details,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else if (snapshot.hasError)
                          return Center(
                            child: Text("Record Not Found"),
                          );
                        else
                          return CircularProgressIndicator();
                      },
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
