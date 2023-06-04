import 'package:flutter/material.dart';
import 'package:untitled1/models/patient_history.dart';

class SampleData {
  List<Map<String, dynamic>> get data =>
      sampleDataRows.map((row) => row.values).toList();
  final List<SampleDataRow> sampleDataRows = [
    SampleDataRow.fromList([
      'OCT',
      'Normal',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text("Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'Brain Stroke',
      'Stroke',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text("Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'Chest',
      'PNEUMONIA',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text("Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'Al-Zhimers',
      'Moderate',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text("Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'OCT',
      'DME',
      '2020-10-10 13:20:30',
    ],MaterialButton(onPressed: (){},child: Text("Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'Brain Stroke',
      'Normal',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text("Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'Chest',
      'Covid-19',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text("Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'Brain Stroke',
      'Stroke',
      '2020-10-20 13:00:30',
    ],MaterialButton(onPressed: (){},child: Text(" Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),

    SampleDataRow.fromList([
      'Al-zhimers',
      'Mild',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text(" Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'Chest',
      'Normal',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text(" Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
    SampleDataRow.fromList([
      'OCT',
      'DRUSEN',
      '2020-10-10 13:30:30',
    ],MaterialButton(onPressed: (){},child: Text(" Display",style: TextStyle(color:Colors.white),),color: Colors.blue,)),
  ];
}

class SampleDataRow {
  SampleDataRow._({
    required this.categoryName,
    required this.diseaseName,
    required this.dateTime,
    required this.xrayImage,
  });

  factory SampleDataRow.fromList(List<String> values,Widget child) {
    return SampleDataRow._(
      categoryName: values[0],
      diseaseName: values[1],
      dateTime: DateTime.parse(values[2]),
      xrayImage: child,
    );
  }

  final String categoryName;
  final String diseaseName;
  final Widget xrayImage;
  final DateTime dateTime;

  Map<String, dynamic> get values {
    return {
      'categoryName': categoryName,
      'diseaseName': diseaseName,
      'dateTime': dateTime,
      'xrayImage': xrayImage,
    };
  }
}