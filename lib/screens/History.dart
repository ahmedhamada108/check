
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_data_table/web_data_table.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio/dio.dart';
import '../layout.dart';
import '../models/patient_history.dart';
import '../services/sample.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late String? _sortColumnName;
  late bool _sortAscending;
  List<String>? _filterTexts;
  bool _willSearch = true;
  Timer? _timer;
  int? _latestTick;
  List<String> _selectedRowKeys = [];
  int _rowsPerPage = 10;
  List<PatientHistory> _patientHistory = [];
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _sortColumnName = 'sub_disease_name';
    _sortAscending = false;
    _fetchPatientHistory(); // Call the API when the page is opened
    getPatientHistory();
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

      // Print the records in the terminal
      for (var record in _patientHistory) {
        print('Category Name: ${record.disease_name}');
        print('Disease Name: ${record.sub_disease_name}');
        print('DateTime: ${record.dateTime}');
        print('X-Ray Image: ${record.xrayImage}');
        print('---------------------');
      }
    } catch (error) {
      print('Error fetching patient history: $error');
      throw Exception('Error fetching patient history');
    }
  }

  Future<List<PatientHistory>> getPatientHistory() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
    response = await dio.get(
      'https://project.projects-app.xyz/api/PatientHistory',
      options: Options(headers: {
        "Accept": "application/json",
        "Accept-Language": "en",
      }),
    );
    if (response.data['status'] != null && response.data['status'] == true) {
      print(response.data["Patient History"]);
      List<PatientHistory> records =
      (response.data["Patient History"] as List)
          .map((e) => PatientHistory.fromJson(e))
          .toList();
      for (var record in records) {
        print(record.sub_disease_name);
      }
      return records; // Assign retrieved records to the 'records' variable
    }
    return []; // Return an empty list in case of an error or no records
  }

  Future<void> deletePatientHistory(List<String> ids) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
    try {
      response = await dio.delete(
        'https://project.projects-app.xyz/api/DeleteHistory',
        data: {'IDs': ids},
        options: Options(headers: {
          "Accept": "application/json",
          "Accept-Language": "en",
          "Content-Type": "application/json", // Set the content-type to JSON

        }),
      );
      if(response.data['status'] == true) {
        print('Records with IDs $ids deleted successfully');
        _selectedRowKeys.clear();
        Fluttertoast.showToast(
          msg: response.data['msg'].toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }else{
        print(response);
        print(ids);
      }
    } catch (error) {
      print('Error deleting records with IDs $ids: $error');
    }
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
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
                    onPressed: () async {
                      print(_selectedRowKeys);
                      await deletePatientHistory(_selectedRowKeys);
                      await _fetchPatientHistory(); // Retrieve the updated data
                      await getPatientHistory();
                      print('done');
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
                  name: 'id',
                  label: const Text(
                    'ID',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  dataCell: (value) => DataCell(Text('$value')),
                ),
                WebDataColumn(
                  name: 'disease_name',
                  label: const Text(
                    'Category Name',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  dataCell: (value) => DataCell(Text('$value')),
                ),
                WebDataColumn(
                  name: 'sub_disease_name',
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dataCell: (value) {
                    return DataCell(
                      Padding(
                        padding: const EdgeInsets.all(8.0), // Adjust the padding values as needed
                        child: Image.network(
                          '$value', // Assuming the value is the URL of the image
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                        ),
                      ),
                    );
                  },
                ),
                WebDataColumn(
                  name: 'PDF',
                  label: const Text(
                    'Download PDF',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dataCell: (value) {
                    return DataCell(
                      ElevatedButton(
                        onPressed: () async {
                          String url = value; // Replace with the actual URL of the PDF file
                          print(url);
                          await launch(url);
                        },
                        child: Text(
                          'Open PDF',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  filterText: (value) => '',
                ),
              ],
              rows: _patientHistory.map((records) {
                return {
                  'id': records.id,
                  'disease_name': records.disease_name,
                  'sub_disease_name': records.sub_disease_name,
                  'dateTime': records.dateTime,
                  'xrayImage': records.xrayImage,
                  'PDF': records.PDF,
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
              primaryKeyName: 'id',
            ),
            horizontalMargin: 100,
            onPageChanged: (offset) {
              print('onPageChanged(): offset = $offset');
            },
            onSort: (columnName, ascending) {
              print('onSort(): columnName = $columnName, ascending = $ascending');
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
  final int? history_id;
  final String? disease_name;
  final String? sub_disease_name;
  final String? dateTime;
  final String? xrayImage;
  final String? PDF;

  PatientHistory({
    required this.history_id,
    required this.disease_name,
    required this.sub_disease_name,
    required this.dateTime,
    required this.xrayImage,
    required this.PDF,

  });

  factory PatientHistory.fromJson(Map<String, dynamic> json) {
    return PatientHistory(
      history_id: json['id'] ?? 0,
      disease_name: json['disease_name'] ?? '',
      sub_disease_name: json['sub_disease_name'] ?? '',
      dateTime: json['check_date'] ?? '',
      xrayImage: json['image'] ?? '',
      PDF: json['PDF_URL'] ?? '',

    );
  }
  int? get id => history_id;
  String? get getdisease_name => disease_name;
  String? get getsub_disease_name => sub_disease_name;
  String? get getDateTime => dateTime;
  String? get getXrayImage => xrayImage;
  String? get PDF_URL => PDF;

}
