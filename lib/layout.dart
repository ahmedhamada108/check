import 'package:flutter/material.dart';
import 'package:untitled1/dio/dio.dart';
import 'package:untitled1/models/mr.dart';
import 'package:untitled1/models/patient_history.dart';
import 'package:untitled1/screens/History.dart';
import 'package:untitled1/screens/Home.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {

  getRecords() {
    setState(() {
      // records =  getPatientHistory() as List<PatientHistory>?;

    });

    // print(records);
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historyt'),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
  ];

  late List screens = [
    Home(),
    const History(),
    // TestHistory(records: records),
    Container(
        padding: const EdgeInsets.all(1.0),
        //WebDataTable(
        //               header: const Text(' Previous Checks',style:TextStyle(color:Colors.blue,fontWeight: FontWeight.bold)),
        //               actions: [
        //                 if (_selectedRowKeys.isNotEmpty)
        //                   SizedBox(
        //                     height: 40,
        //                     width: 100,
        //                     child: MaterialButton(
        //                       color: Colors.red,
        //                       child: const Text(
        //                         'Delete',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                       onPressed: () {
        //                         print('Delete!');
        //                         setState(() {
        //                           _selectedRowKeys.clear();
        //                         });
        //                       },
        //                     ),
        //                   ),
        //
        //               ],
        //               source: WebDataTableSource(
        //                 sortColumnName: _sortColumnName,
        //                 sortAscending: _sortAscending,
        //                 filterTexts: _filterTexts,
        //                 columns: [
        //                   WebDataColumn(
        //                     name: 'categoryName',
        //                     label: const Text('Category Name',style:TextStyle(color:Colors.lightBlueAccent,fontWeight: FontWeight.bold)),
        //                     dataCell: (value) => DataCell(Text('$value')),
        //                   ),
        //                   WebDataColumn(
        //                     name: 'diseaseName',
        //                     label: const Text(' Disease Name',style:TextStyle(color:Colors.lightBlueAccent,fontWeight: FontWeight.bold)),
        //                     dataCell: (value) => DataCell(Text('$value')),
        //                   ),
        //
        //                   WebDataColumn(
        //                       name: 'dateTime',
        //                       label: const Text('DateTime',style:TextStyle(color:Colors.lightBlueAccent,fontWeight: FontWeight.bold)),
        //                       dataCell: (value) {
        //                         if (value is DateTime) {
        //                           final text =
        //                               '${value.year}/${value.month}/${value.day} ${value.hour}:${value.minute}:${value.second}';
        //                           return DataCell(Text(text));
        //                         }
        //                         return DataCell(Text(value.toString()));
        //                       },
        //                       filterText: (value) {
        //                         if (value is DateTime) {
        //                           return '${value.year}/${value.month}/${value.day} ${value.hour}:${value.minute}:${value.second}';
        //                         }
        //                         return value.toString();
        //                       }),
        //                   WebDataColumn(
        //                       name: 'xrayImage',
        //                       label: const Text('X-Ray Image',style:TextStyle(color:Colors.lightBlueAccent,fontWeight: FontWeight.bold)),
        //                       dataCell: (value) {
        //
        //                         return DataCell(value);
        //                       },
        //                       filterText: (value) {
        //                         if (value is DateTime) {
        //                           return '${value.year}/${value.month}/${value.day} ${value.hour}:${value.minute}:${value.second}';
        //                         }
        //                         return value.toString();
        //                       }),
        //                 ],
        //                 rows: SampleData().data,
        //                 selectedRowKeys: _selectedRowKeys,
        //                 onTapRow: (rows, index) {
        //                   print('onTapRow(): index = $index, row = ${rows[index]}');
        //                 },
        //                 onSelectRows: (keys) {
        //                   print('onSelectRows(): count = ${keys.length} keys = $keys');
        //                   setState(() {
        //                     _selectedRowKeys = keys;
        //                   });
        //                 },
        //                 primaryKeyName: 'categoryName',
        //               ),
        //               horizontalMargin: 100,
        //               onPageChanged: (offset) {
        //                 print('onPageChanged(): offset = $offset');
        //               },
        //               onSort: (columnName, ascending) {
        //                 print(
        //                     'onSort(): columnName = $columnName, ascending = $ascending');
        //                 setState(() {
        //                   _sortColumnName = columnName;
        //                   _sortAscending = ascending;
        //                 });
        //               },
        //               onRowsPerPageChanged: (rowsPerPage) {
        //                 print('onRowsPerPageChanged(): rowsPerPage = $rowsPerPage');
        //                 setState(() {
        //                   if (rowsPerPage != null) {
        //                     _rowsPerPage = rowsPerPage;
        //                   }
        //                 });
        //               },
        //               rowsPerPage: _rowsPerPage,
        //             ),
        // child: FutureBuilder<List<PatientHistory>>(
        //
        //     future: getPatientHistory(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         if (snapshot.hasData) {
        //           records = snapshot.data ?? [];
        //           return RefreshIndicator(
        //             onRefresh: getPatientHistory,
        //             child: ListView.separated(
        //                 itemBuilder: (context, index) =>
        //                     MedicalRecord(
        //                       subDiseaseName: records![index].subDiseaseName!,
        //                       diseaseName: records![index].diseaseName!,
        //                       image: records![index].image!,
        //                       checkRecordDate: records![index].checkRecordDate!,
        //                     ),
        //                 separatorBuilder: (context, index) =>
        //                 const SizedBox(height: 5),
        //                 itemCount: records!.length),
        //           );
        //         } else {
        //           return Text("Try Again..");
        //         }
        //       }
        //
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     })),
    // History(records: medicalRecords),
    )];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: bottomNavigationBarItems,
          currentIndex: currentIndex,
          iconSize: 40,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          }),
    );
  }
}
//      bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedItem,
//           onTap: (value) {
//             print(value);
//             setState(() {
//               selectedItem = value;
//             });
//           },
//           iconSize: 40,
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home),label: 'Home'),
//           BottomNavigationBarItem(
//               icon:Icon(Icons.history), label: 'History'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle), label: 'Account')
//         ],
//       ),
