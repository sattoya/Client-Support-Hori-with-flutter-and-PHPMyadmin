import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cssupport/services/user.dart';

class EditAdmin extends StatefulWidget {
  final Map ListData;
  const EditAdmin({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditAdmin> createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  final formKey = GlobalKey<FormState>();

  TextEditingController No = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController c_date = TextEditingController();
  String Bagian = 'Accounting';
  TextEditingController c_desc = TextEditingController();
  TextEditingController Cause = TextEditingController();
  TextEditingController Action = TextEditingController();
  String Req = ' ';

  TextEditingController f_date = TextEditingController();
  TextEditingController Waktu_perbaikan = TextEditingController();
  String Status = 'OK';

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    c_date.text = formattedDate;
    f_date.text = formattedDate;
    Bagian = widget.ListData['bagian'];
    Status = widget.ListData['Status'];
    Req = widget.ListData['Req'];
  }

  Future _update() async {
    final response = await http.post(
      Uri.parse("http://36.88.137.170:8080/csphp/editadmin.php"),
      body: {
        'No': No.text,
        'nama': nama.text,
        'c_date': c_date.text,
        'bagian': Bagian,
        'c_desc': c_desc.text,
        'Cause': Cause.text,
        'Action': Action.text ,
        'Req': Req,
        'f_date': f_date.text,
        'Waktu_perbaikan': Waktu_perbaikan.text,
        'Status': Status,
      },
    );
    var data = json.decode(response.body);
    if (data == "Error") {
      Navigator.pushReplacementNamed(context, 'EditData');
      showRegisterSuccessSnackBar1();
    } else {
      await User.setsignin(true);
      Navigator.pushReplacementNamed(context, 'EditAdminScreen');
      showRegisterSuccessSnackBar();
    }
  }

  void showRegisterSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('kirim berhasil!'),
      ),
    );
  }

  void showRegisterSuccessSnackBar1() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('kirim gagal'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    No.text = widget.ListData['No'];
    nama.text = widget.ListData['nama'];
    c_desc.text = widget.ListData['c_desc'];
    Cause.text = widget.ListData['Cause'];
    Action.text = widget.ListData['Action'];
    Waktu_perbaikan.text = widget.ListData['Waktu_perbaikan'];

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Edit Data',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tanggal : DD/MM/YY',
                      ),
                      controller: c_date,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama',
                      ),
                      controller: nama,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<String>(
                      value: Bagian,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bagian',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          Bagian = newValue!;
                        });
                      },
                      items: [
                        'Accounting',
                        'PIP',
                        'HORI',
                        'EMS',
                        'PrintingPainting',
                        'KWH',
                        'HRD',
                        'MIS',
                        'Warehouse',
                        'Purchase',
                        'Epte',
                        'Marketing',
                        'Sisdur',
                        'PD',
                        'OLED',
                        'kawai',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<String>(
                      value: Req,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Req',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          Req = newValue!;
                        });
                      },
                      items: [' ', 'HDW', 'SFW', 'LAN'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<String>(
                      value: Status,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Status',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          Status = newValue!;
                        });
                      },
                      items: ['NG', 'OK'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Trouble',
                      ),
                      controller: c_desc,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cause',
                      ),
                      controller: Cause,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Action',
                      ),
                      controller: Action,
                    ),
                  ),
                  
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Finish Date',
                      ),
                      controller: f_date,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Waktu perbaikan',
                      ),
                      controller: Waktu_perbaikan,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 0, 114, 180),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        bool pass = formKey.currentState!.validate();

                        if (pass) {
                          _update();
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
