import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cssupport/services/editadmin.dart';
import 'package:http/http.dart' as http;

class EditAdminScreen extends StatefulWidget {
  const EditAdminScreen({Key? key}) : super(key: key);

  @override
  State<EditAdminScreen> createState() => _EditAdminScreenState();
}

class _EditAdminScreenState extends State<EditAdminScreen> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(Uri.parse('http://36.88.137.170:8080/csphp/edit.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deletedata(String No, int index) async {
    try {
      final response = await http.post(Uri.parse('http://36.88.137.170:8080/csphp/delete.php'), body: {
        'nama': No,
      });
      if (response.statusCode == 200) {
        setState(() {
          _listdata.removeAt(index);
        });
        final snackBar = SnackBar(
          content: const Text("Data berhasil dihapus"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: const Text("Data gagal dihapus"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Data")),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => EditAdmin(
                            ListData: {
                              "No": _listdata[index]['No'],
                              "c_date": _listdata[index]['c_date'],
                              "nama": _listdata[index]['nama'],
                              "bagian": _listdata[index]['bagian'],
                              "c_desc": _listdata[index]['c_desc'],
                              "Cause": _listdata[index]['Cause'],
                              "Action": _listdata[index]['Action'],
                              "Req": _listdata[index]['Req'],
                              "f_date": _listdata[index]['f_date'],
                              "Waktu_perbaikan": _listdata[index]['Waktu_perbaikan'],
                              "Status": _listdata[index]['Status'],
                            },
                          )),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Nama : ${_listdata[index]["nama"]}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tanggal : ${_listdata[index]["c_date"]}"),
                          Text("Bagian : ${_listdata[index]["bagian"]}"),
                          Text("Trouble : ${_listdata[index]["c_desc"]}"),
                          Text("Cause : ${_listdata[index]["Cause"]}"),
                          Text("Action : ${_listdata[index]["Action"]}"),
                          Text("Req : ${_listdata[index]["Req"]}"),
                          Text("f_date : ${_listdata[index]["f_date"]}"),
                          Text("Waktu_perbaikan : ${_listdata[index]["Waktu_perbaikan"]}"),
                          Text("Status : ${_listdata[index]["Status"]}"),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Yakin hapus data??"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _deletedata(_listdata[index]['nama'], index);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Ya"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Tidak"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
