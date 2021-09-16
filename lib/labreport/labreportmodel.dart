// import 'dart:convert';

// PatientModel patientModelFromJson(String str) =>
//     PatientModel.fromJson(json.decode(str));

// String patientModel(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  PatientModel({
    this.ptn,
    this.patientName,
    this.gender,
    this.patientDob,
    this.passportNo,
    this.ticketPnrNo,
    this.sampleDate,
    this.sampleTime,
    this.tests,
  });

  String ptn;
  String patientName;
  String gender;
  String patientDob;
  String passportNo;
  String ticketPnrNo;
  String sampleDate;
  String sampleTime;
  List<Test> tests;

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    var list = json['tests'] as List;
    List<Test> testList = list.map((i) => Test.fromJson(i)).toList();
    return PatientModel(
        ptn: json["ptn"],
        patientName: json["patient_name"],
        gender: json["gender"],
        patientDob: json["patient_dob"],
        passportNo: json["passport_no"],
        ticketPnrNo: json["ticket_pnr_no"],
        sampleDate: json["sample_date"],
        sampleTime: json["sample_time"],
        tests: testList);
    // tests: (json['tests']).map((i) => new Test.fromJson(i)).toList());
  }
  Map<String, dynamic> toJson() => {
        "ptn": ptn,
        "patient_name": patientName,
        "gender": gender,
        "patient_dob": patientDob,
        "passport_no": passportNo,
        "ticket_pnr_no": ticketPnrNo,
        "sample_date": sampleDate,
        "sample_time": sampleTime,
        "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
      };
}

class Test {
  Test({
    this.testName,
    this.testId,
    this.testResult,
    this.details,
  });

  String testName;
  String testId;
  String testResult;
  String details;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        testName: json["test_name"],
        testId: json["test_id"],
        testResult: json["test_result"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "test_name": testName,
        "test_id": testId,
        "test_result": testResult,
        "details": details,
      };
}
