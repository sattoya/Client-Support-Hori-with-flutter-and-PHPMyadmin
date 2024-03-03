import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OutputDataScreen extends StatefulWidget {
  @override
  _OutputDataScreenState createState() => _OutputDataScreenState();
}

class _OutputDataScreenState extends State<OutputDataScreen> {
  List _data_table = [];

  Future<void> _getdata() async {
    var url = Uri.parse("http://36.88.137.170:8080/csphp/getdata.php");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _data_table = jsonDecode(response.body);
      });
    } else {
      print("Failed to fetch data");
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  SingleChildScrollView _tableuser() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text("Tanggal")),
            DataColumn(label: Text("Nama")),
            DataColumn(label: Text("Bagian")),
            DataColumn(label: Text("Trouble")),
            DataColumn(label: Text("Cause")),
            DataColumn(label: Text("Action")),
            DataColumn(label: Text("Req")),
            DataColumn(label: Text("f_date")),
            DataColumn(label: Text("Waktu_perbaikan")),
            DataColumn(label: Text("Status")),
          ],
          rows: _data_table
              .map((e) => DataRow(cells: <DataCell>[
                    DataCell(Text(e["c_date"])),
                    DataCell(Text(e["nama"])),
                    DataCell(Text(e["bagian"])),
                    DataCell(Text(e["c_desc"])),
                    DataCell(Text(e["Cause"])),
                    DataCell(Text(e["Action"])),
                    DataCell(Text(e["Req"])),
                    DataCell(Text(e["f_date"])),
                    DataCell(Text(e["Waktu_perbaikan"])),
                    DataCell(Text( e["Status"],style: TextStyle(color:e["Status"] == "OK" ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ]))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datatable"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Text(
              "Data Client Support",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            _tableuser(),
          ],
        ),
      ),
    );
  }
}
