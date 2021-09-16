import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ViewReport extends StatefulWidget {
  var ptn;
  var patientName;
  var gender;
  var patientDob;
  var passportNo;
  var ticketPnrNo;
  var sampleDate;
  var sampleTime;
  var testName;
  var testId;
  var testResult;
  var details;

  ViewReport({
    Key key,
    this.ptn,
    this.patientName,
    this.gender,
    this.patientDob,
    this.passportNo,
    this.ticketPnrNo,
    this.sampleDate,
    this.sampleTime,
    this.testName,
    this.testId,
    this.testResult,
    this.details,
  }) : super(key: key);
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  ProgressDialog pr;
  String progress;
  var downloadUrl = "";
  var dio = Dio();

//get mobile download path
  void initState() {
    downloadUrl =
        "https://shariflabs.pk/Pdfgenerator/${widget.ptn}/${widget.testId}";
    super.initState();
  }

//Download progress bar
  void showDownloadProgress(received, total) {
    if (total != -1) {
      progress = ((received / total * 100).toStringAsFixed(0) + "%");
      print(progress);
      pr.update(message: "Please wait .. $progress");
    }
  }

//Download Function
  Future download2(
      BuildContext context, Dio dio, String url, String savePath) async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      message: "Downloading Report ...",
    );
    try {
      await pr.show();

      //get pdf from link
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      //write in download folder
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      pr.hide();
      Fluttertoast.showToast(
          msg: "Download Complete\n Please check your Downloads",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF025a9a),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("error");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final status = await Permission.storage.request();
          if (status.isGranted) {
            print(downloadUrl);
            var path = await ExtStorage.getExternalStoragePublicDirectory(
                ExtStorage.DIRECTORY_DOWNLOADS);
            String fullPath = "$path/report.pdf";
            download2(context, dio, downloadUrl, fullPath);
          } else {
            print("Permission deined");
            Fluttertoast.showToast(
                msg: "Please grant storage permission",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Color(0xFF025a9a),
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Icon(Icons.download),
        backgroundColor: Color(0xFF025a9a),
        splashColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("6/18/2021"),
                      Text("Sharif Labs and Diagnotics-Islamabad")
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset("images/logo.png", scale: 1.7),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: [
                                      Text(
                                        "Test ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(widget.ptn ?? 'Default Value')
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Name : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          widget.patientName ?? 'Default Value')
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Gender : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(widget.gender ?? 'Default Value')
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Date of Birth : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(widget.patientDob ?? 'Default Value')
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Passport No. : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(widget.passportNo ?? 'Default Value')
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Ticker Pnr No. : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          widget.ticketPnrNo ?? 'Default Value')
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Sample Date: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(widget.sampleDate ?? 'Default Value')
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Sample Time: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(widget.sampleTime ?? 'Default Value')
                                    ])
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Table(
                          defaultColumnWidth: FixedColumnWidth(115.0),
                          border: TableBorder.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1),
                          children: [
                            TableRow(children: [
                              Column(children: [
                                Text('S/N',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                              Column(children: [
                                Text('Test Tile',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                              Column(children: [
                                Text('Result',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                            ]),
                            TableRow(children: [
                              Column(children: [
                                Text(widget.testId ?? 'No Value Found')
                              ]),
                              Column(children: [
                                Text(widget.testName ?? 'No Value Found')
                              ]),
                              Column(children: [
                                Text(widget.testResult ?? 'No Value Found')
                              ]),
                            ]),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: Column(
                            children: [
                              Text(widget.details ?? 'No Value Found'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 5),
                          child: Row(children: <Widget>[
                            Text(
                              "Comments/Recommendations:",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                  "1. A negative result must be interpreted along with clinical observation, patient history and epidemiological information.",
                                  textAlign: TextAlign.left),
                              new Text(
                                  "2. A single negative result might not exclude the possibility of corona virus infection. A repeat test may be required if symbtoms persist",
                                  textAlign: TextAlign.left),
                              new Text(
                                  "3. In case of positive result, it is strongly advised that patient should stay at home under self-qurantine and maintain social distancing along with additional testing as deemed necessary by treating physician",
                                  textAlign: TextAlign.left),
                              new Text(
                                  "4. In case the patient develops shortness of breath he/she should immediately seek medical advice",
                                  textAlign: TextAlign.left),
                              new Text(
                                  "5. Results of PCR studies performed in one laboratory should not be compared with those performed in another laboratory as the kits/methodologies used in different laboratories may not have the same sensitivty and specifcity",
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 5),
                          child: Column(children: <Widget>[
                            Text(
                              "This report can be verfied at :\n$downloadUrl",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "This is digitally verified report and does not require any Signature",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Sharif Labs and Diagnostics",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Dr. Attiya Rasool Qureshi",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "MBBS, M.Phil Microbiology",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Color(0xFF025a9a),
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 80.0),
                              child: Text(
                                "Office #6, Ground Floor, Feroze Center, Fazle Haq Road, Blue Area, Islamabad, Contact: +92-512120966-67 | 0302-5490413, 0333-5537268 | www.shariflabs.com",
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
