import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

void main() => runApp(TestRate());

class TestRate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatientTestRate(),
    );
  }
}

class PatientTestRate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PatientTestRateState();
}

class PatientTestRateState extends State<PatientTestRate> {
  Future<List<PatientModel>> _patientList;
  Future<List<PatientModel>> _searchpatientList;

  @override
  void initState() {
    _patientList = _getPatient(0);
    _searchpatientList = _patientList;
    super.initState();
  }

  Future<List<PatientModel>> _getPatient(int id) async {
    final response = await http.post(
      Uri.https("shariflabs.pk", "api/fetchtests.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, int>{
          'id': id,
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final jsonBody = json.decode(response.body) as List;
      return jsonBody.map((data) => new PatientModel.fromJson(data)).toList();
    } else
      throw Exception("Unable to get Patient list");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PatientModel>>(
      future: _searchpatientList,
      builder: (context, snapshot) {
        // print(snapshot);
        if (snapshot.hasData)
          return _buildBody(snapshot.data);
        else if (snapshot.hasError)
          return _buildErrorPage(snapshot.error);
        else
          return _buildLoadingPage();
      },
    );
  }

  Widget _buildBody(List<PatientModel> patientList) => Scaffold(
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(children: [
            Stack(children: <Widget>[
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
                              width: 70,
                            ),
                            Text(
                              "Test Rate",
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
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 210,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Test Name",
                    hintText: "Test Name",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (string) {
                    setState(() {
                      _searchpatientList = _patientList.then((value) {
                        var completer = new Completer<List<PatientModel>>();
                        completer.complete(value
                            .where((test) => test.test_name
                                .toLowerCase()
                                .contains(string.toLowerCase()))
                            .toList());
                        return completer.future;
                      });
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 240),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: patientList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                              color: Color(0xFF025a9a),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  title: Text(
                                    patientList[index].test_name,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    patientList[index].test_fee,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ]),
        ),
      );

  Widget _buildErrorPage(error) => Material(
        child: AlertDialog(
          title: Text("No Internet"),
          content: Text("Check your Internet"),
          actions: [
            FlatButton(
              onPressed: () => {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MainBody(),
                  ),
                  (route) => false,
                )
              }, // passing true
              child: Text('Exit'),
            ),
          ],
        ),
      );

  Widget _buildLoadingPage() => Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}

class PatientModel {
  String test_id;
  String test_name;
  String test_desc;
  String test_fee;

  PatientModel({
    this.test_id,
    this.test_name,
    this.test_desc,
    this.test_fee,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    test_id = json['test_id'];
    test_name = json['test_name'];
    test_desc = json['test_desc'];
    test_fee = json['test_fee'];
  }
}
