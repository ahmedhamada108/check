import 'package:flutter/material.dart';

class Record extends StatelessWidget {
  const Record({Key? key, required this.diseaseName, required this.subDiseaseName, required this.date, required this.image, required this.pdfUrl}) : super(key: key);

  final String diseaseName;
  final String subDiseaseName;
  final String date;
  final String image;
  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children:  [
        Text(diseaseName),
        Text(subDiseaseName),
        Text(date),
        Text(image),
        Text(pdfUrl),
      ],
    );
  }
}
