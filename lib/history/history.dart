import 'package:flutter/material.dart';
import 'package:untitled1/dio/dio.dart';
import 'package:untitled1/models/mr.dart';
import 'package:untitled1/models/patient_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late String diseaseName;
  late String subDiseaseName;
  late String checkRecordDate;
  late String pdfUrl;
  late String image;
  late Future<List<PatientHistory>> records;
  var record = MedicalRecord(
      diseaseName: "", subDiseaseName: "", checkRecordDate: "", image: "");

  getRecords() {
    setState(() {
      // records = getPatientHistory();
      print(records);
      records.then((value) {
        diseaseName = value.iterator.current.diseaseName!;
        subDiseaseName = value.iterator.current.subDiseaseName!;
        checkRecordDate = value.iterator.current.checkRecordDate!;
        image = value.iterator.current.image!;
        record = MedicalRecord(
          diseaseName: diseaseName,
          subDiseaseName: subDiseaseName,
          checkRecordDate: checkRecordDate,
          image: image,
        );
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getRecords();
    // getPatientHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MedicalRecord(diseaseName: "test",checkRecordDate: "date", subDiseaseName: "test", image: "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg"),
      body: Center(
        child: const CircularProgressIndicator(),
      ),
      // body: ListView.separated(
      //     itemBuilder: (context, index) => record,
      //     separatorBuilder: (context, index) => const SizedBox(height: 5),
      //     itemCount: 2),
    );
  }
}
