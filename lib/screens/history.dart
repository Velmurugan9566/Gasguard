import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedMonth = "All"; // Default filter
  List<String> months = ["All", "January", "February", "March", "April"];
  int page = 0;
  int itemsPerPage = 10;

  Stream<List<Map<String, dynamic>>> fetchHistoricalData() {
    return FirebaseFirestore.instance
        .collection('sensorData')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      var data = doc.data();
      DateTime dateTime = (data['timestamp'] as Timestamp).toDate();
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
      String formattedMonth = DateFormat('MMMM').format(dateTime);
      return {
        'sno': snapshot.docs.indexOf(doc) + 1,
        'value': data['value'],
        'date': formattedDate,
        'time': formattedTime,
        'month': formattedMonth,
      };
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historical Data")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              value: selectedMonth,
              items: months.map((String month) {
                return DropdownMenuItem(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMonth = value!;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: fetchHistoricalData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Map<String, dynamic>> records = snapshot.data!;
                if (selectedMonth != "All") {
                  records = records.where((record) => record['month'] == selectedMonth).toList();
                }

                int startIndex = page * itemsPerPage;
                int endIndex = startIndex + itemsPerPage;
                List<Map<String, dynamic>> paginatedRecords =
                records.sublist(startIndex, endIndex > records.length ? records.length : endIndex);

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text("S.No")),
                            DataColumn(label: Text("Sensor Value")),
                            DataColumn(label: Text("Date")),
                            DataColumn(label: Text("Time")),
                            DataColumn(label: Text("Month")),
                          ],
                          rows: paginatedRecords.map((record) {
                            return DataRow(cells: [
                              DataCell(Text(record['sno'].toString())),
                              DataCell(Text(record['value'].toString())),
                              DataCell(Text(record['date'])),
                              DataCell(Text(record['time'])),
                              DataCell(Text(record['month'])),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: page > 0
                              ? () {
                            setState(() {
                              page--;
                            });
                          }
                              : null,
                        ),
                        Text("Page ${page + 1}"),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: endIndex < records.length
                              ? () {
                            setState(() {
                              page++;
                            });
                          }
                              : null,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
