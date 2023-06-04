import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_data_table/web_data_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio/dio.dart';
import '../models/patient_history.dart';
import '../services/sample.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late String _sortColumnName;
  late bool _sortAscending;
  List<String>? _filterTexts;
  bool _willSearch = true;
  Timer? _timer;
  int? _latestTick;
  List<String> _selectedRowKeys = [];
  int _rowsPerPage = 10;
  List<PatientHistory> _patientHistory = [];

  @override
  void initState() {
    super.initState();
    _sortColumnName = 'diseaseName';
    _sortAscending = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_willSearch) {
        if (_latestTick != null && timer.tick > _latestTick!) {
          _willSearch = true;
        }
      }
      if (_willSearch) {
        _willSearch = false;
        _latestTick = null;
        setState(() {
          if (_filterTexts != null && _filterTexts!.isNotEmpty) {
            _filterTexts = _filterTexts;
            print('filterTexts = $_filterTexts');
          }
        });
      }
    });
    _fetchPatientHistory();
    print(_fetchPatientHistory());
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _fetchPatientHistory() async {
    try {
      List<PatientHistory> patientHistory = await getPatientHistory();
      setState(() {
        _patientHistory = patientHistory;
      });
      for (var record in _patientHistory) {
        print('Category Name: ${record.categoryName}');
        print('Disease Name: ${record.diseaseName}');
        print('DateTime: ${record.dateTime}');
        print('X-Ray Image: ${record.xrayImage}');
        print('---------------------');
      }
    } catch (error) {
      print('Error fetching patient history: $error');
    }
  }

  Future<List<PatientHistory>> getPatientHistory() async {
    Response response;
    SharedPreferences prefs = await sharedPrefs;
    dio.options.headers["Authorization"] =
    "Bearer ${prefs.getString('token')}";
    response = await dio.get(
      'https://project.projects-app.xyz/api/PatientHistory',
      options: Options(headers: {
        "Accept": "application/json",
        "Accept-Language": "en",
      }),
    );
    if (response.data['status'] == true) {
      print(response.data["Patient History"]);
      List<PatientHistory> records =
      (response.data["Patient History"] as List)
          .map((e) => PatientHistory.fromJson(e))
          .toList();
      for (var record in records) {
        print(record.diseaseName);
      }
      return records; // Assign retrieved records to the 'records' variable
    }
    return []; // Return an empty list in case of an error or no records
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(color: Colors.lightBlueAccent),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(1.0),

          child: _patientHistory.isEmpty
              ? Center(
            child: CircularProgressIndicator(),
          )
              : WebDataTable(
            header: const Text(
              'Previous Checks',
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            actions: [
              if (_selectedRowKeys.isNotEmpty)
                SizedBox(
                  height: 40,
                  width: 100,
                  child: MaterialButton(
                    color: Colors.red,
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      print('Delete!');
                      setState(() {
                        _selectedRowKeys.clear();
                      });
                    },
                  ),
                ),
            ],
            source: WebDataTableSource(
              sortColumnName: _sortColumnName,
              sortAscending: _sortAscending,
              filterTexts: _filterTexts,
              columns: [
                WebDataColumn(
                  name: 'categoryName',
                  label: const Text(
                    'Category Name',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  dataCell: (value) => DataCell(Text('$value')),
                ),
                WebDataColumn(
                  name: 'diseaseName',
                  label: const Text(
                    ' Disease Name',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  dataCell: (value) => DataCell(Text('$value')),
                ),
                WebDataColumn(
                  name: 'dateTime',
                  label: const Text(
                    'DateTime',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  dataCell: (value) {
                    if (value is DateTime) {
                      final text =
                          '${value.year}/${value.month}/${value.day} ${value.hour}:${value.minute}:${value.second}';
                      return DataCell(Text(text));
                    }
                    return DataCell(Text(value.toString()));
                  },
                  filterText: (value) {
                    if (value is DateTime) {
                      return '${value.year}/${value.month}/${value.day} ${value.hour}:${value.minute}:${value.second}';
                    }
                    return value.toString();
                  },
                ),
                WebDataColumn(
                  name: 'xrayImage',
                  label: const Text(
                    'X-Ray Image',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  dataCell: (value) {
                    // Replace with the widget to display the X-Ray Image
                    return DataCell(value);
                  },
                  filterText: (value) {
                    if (value is DateTime) {
                      return '${value.year}/${value.month}/${value.day} ${value.hour}:${value.minute}:${value.second}';
                    }
                    return value.toString();
                  },
                ),
              ],
              rows: _patientHistory.map((records) {
                return {
                  'categoryName': records.categoryName,
                  'diseaseName': records.diseaseName,
                  'dateTime': records.dateTime,
                  'xrayImage': records.xrayImage,
                };
              }).toList(),
              selectedRowKeys: _selectedRowKeys,
              onTapRow: (rows, index) {
                print('onTapRow(): index = $index, row = ${rows[index]}');
              },
              onSelectRows: (keys) {
                print('onSelectRows(): count = ${keys.length} keys = $keys');
                setState(() {
                  _selectedRowKeys = keys;
                });
              },
              primaryKeyName: 'categoryName',
            ),
            horizontalMargin: 100,
            onPageChanged: (offset) {
              print('onPageChanged(): offset = $offset');
            },
            onSort: (columnName, ascending) {
              print(
                  'onSort(): columnName = $columnName, ascending = $ascending');
              setState(() {
                _sortColumnName = columnName;
                _sortAscending = ascending;
              });
            },
            onRowsPerPageChanged: (rowsPerPage) {
              print('onRowsPerPageChanged(): rowsPerPage = $rowsPerPage');
              setState(() {
                if (rowsPerPage != null) {
                  _rowsPerPage = rowsPerPage;
                }
              });
            },
            rowsPerPage: _rowsPerPage,
          ),
        ),
      ),
    );
  }
}

class PatientHistory {
  final String categoryName;
  final String diseaseName;
  final DateTime dateTime;
  final String xrayImage;

  PatientHistory({
    required this.categoryName,
    required this.diseaseName,
    required this.dateTime,
    required this.xrayImage,
  });

  factory PatientHistory.fromJson(Map<String, dynamic> json) {
    return PatientHistory(
      categoryName: json['categoryName'],
      diseaseName: json['diseaseName'],
      dateTime: DateTime.parse(json['dateTime']),
      xrayImage: json['xrayImage'],
    );
  }

  String get getCategoryName => categoryName;
  String get getDiseaseName => diseaseName;
  DateTime get getDateTime => dateTime;
  String get getXrayImage => xrayImage;
}
