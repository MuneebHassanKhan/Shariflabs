import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../main.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

void main() => runApp(Booking());

class Booking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatientBooking(),
    );
  }
}

class PatientBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PatientBookingState();
}

class PatientBookingState extends State<PatientBooking> {
  final TextEditingController patient_name = TextEditingController();
  final TextEditingController patient_email = TextEditingController();
  final TextEditingController patient_cellno = TextEditingController();
  final TextEditingController services = TextEditingController();
  final TextEditingController reservation_date = TextEditingController();
  final TextEditingController message = TextEditingController();
  Future<String> _bookingList;
  final _formkey = GlobalKey<FormState>();

  StreamSubscription<DataConnectionStatus> listener;
  @override
  void initState() {
    super.initState();
  }

  checkInternetConnection() async {
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum value instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  Future<String> _bookPatient(
    String patient_name,
    String patient_email,
    String patient_cellno,
    String services,
    String reservation_date,
    String message,
  ) async {
    final response = await http.post(
      Uri.https("shariflabs.pk", "api/setdata.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'patient_name': patient_name,
          'patient_email': patient_email,
          'patient_cellno': patient_cellno,
          'reservation_date': reservation_date,
          'services': services,
          'message': message,
        },
      ),
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed;
    } else
      throw Exception("Unable to get record");
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            "Booking",
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
            child: Form(
              key: _formkey,
              child: ListView(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: (_bookingList == null)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: patient_name,
                                decoration: InputDecoration(
                                    labelText: "Patient Name",
                                    hintText: "Patient Name",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: patient_email,
                                decoration: InputDecoration(
                                    labelText: "Patient Email",
                                    hintText: "Patient Email",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                validator: (String value) {
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return "Use valid email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: patient_cellno,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Patient Cell Number",
                                  hintText: "Patient Cell Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DateTimePicker(
                                decoration: InputDecoration(
                                  labelText: "Reserved Date",
                                  hintText: "Reserve Date",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                controller: reservation_date,
                                initialDate:
                                    DateTime.now().add(Duration(days: 1)),
                                firstDate:
                                    DateTime.now().add(Duration(days: 1)),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Date',
                                onChanged: (value) => print(value),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                onSaved: (value) => print(value),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                child: DropdownSearch<String>(
                                  dropdownSearchDecoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  searchBoxController: services,
                                  mode: Mode.MENU,
                                  showSelectedItem: true,
                                  items: [
                                    "Covid-19 Test",
                                    "Pathology",
                                    "Radiology",
                                    "ECG/UltraSound",
                                    "DexaScan"
                                  ],
                                  label: "Services",
                                  hint: "Services",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: print,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: message,
                                decoration: InputDecoration(
                                  labelText: "Message",
                                  hintText: "Message",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              height: 50,
                              child: ElevatedButton.icon(
                                label: Text('Book Appointment'),
                                icon: Icon(Icons.circle_notifications_outlined),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF025a9a),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    DataConnectionStatus status =
                                        await checkInternetConnection();
                                    if (status ==
                                        DataConnectionStatus.connected) {
                                      setState(
                                        () {
                                          _bookingList = _bookPatient(
                                            patient_name.text,
                                            patient_email.text,
                                            patient_cellno.text,
                                            reservation_date.text,
                                            services.text,
                                            message.text,
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("No Internet"),
                                          content: Text("Check your Internet"),
                                          actions: [
                                            FlatButton(
                                              onPressed: () => Navigator.pop(
                                                  context,
                                                  true), // passing true
                                              child: Text('Exit'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      : FutureBuilder<String>(
                          future: _bookingList,
                          builder: (context, snapshot) {
                            print(snapshot);
                            if (snapshot.hasData)
                              return AlertDialog(
                                content: Text("${snapshot.data}",
                                    style: TextStyle(color: Colors.black)),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MainBody(),
                                        ),
                                        (route) => false,
                                      );
                                    }, // passing true
                                    child: Text('Exit'),
                                  ),
                                ],
                              );
                            // else if (snapshot.hasError)
                            //   return _buildErrorPage(snapshot.error);
                            else
                              return CircularProgressIndicator();
                          },
                        ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  // Widget _buildBody(String status) => Container(
  //       height: MediaQuery.of(context).size.height * 0.3,
  //       child: AlertDialog(
  //         content: Text("$status", style: TextStyle(color: Colors.black)),
  //         actions: [
  //           FlatButton(
  //             onPressed: () => Navigator.pop(context, true), // passing true
  //             child: Text('Exit'),
  //           ),
  //         ],
  //       ),
  //     );

  // Widget _buildErrorPage(error) => Material(
  //       child: AlertDialog(
  //         title: Text("No Internet"),
  //         content: Text("Check your Internet"),
  //         actions: [
  //           FlatButton(
  //             onPressed: () => Navigator.pop(context, true), // passing true
  //             child: Text('Exit'),
  //           ),
  //         ],
  //       ),
  //     );

  // Widget _buildLoadingPage() => Material(
  //       child: Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //     );
}

class BookingModel {
  String test_record;

  BookingModel({
    this.test_record,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    test_record = json['test_record'];
  }
}
