import 'package:flutter/material.dart';

class MedicalRecord extends StatelessWidget {
   MedicalRecord({Key? key, required this.diseaseName, required this.subDiseaseName, required this.checkRecordDate, required this.image}) : super(key: key);

   final String image;
   final String diseaseName;
   final String subDiseaseName;
   final String checkRecordDate;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(image: NetworkImage(image),width: 50),
        Column(
          children: [
            Text(diseaseName),
            const SizedBox(height: 20),
            Text(subDiseaseName),
            const SizedBox(height: 20),
            Text(checkRecordDate),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
