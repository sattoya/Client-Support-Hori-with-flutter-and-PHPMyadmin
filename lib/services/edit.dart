import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cssupport/services/user.dart';

class EditData extends StatefulWidget {
  final Map ListData;
  const EditData({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formKey = GlobalKey<FormState>();

  TextEditingController No = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController c_date = TextEditingController();
  String selectedBagian = 'Accounting';
  TextEditingController c_desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    c_date.text = formattedDate;
    selectedBagian = widget.ListData['bagian']; // Set selected value from widget data
  }

  Future _update() async {
    final response = await http.post(
      Uri.parse("http://36.88.137.170:8080/csphp/edituser.php"),
      body: {
        'No': No.text,
        'nama': nama.text,
        'c_date': c_date.text,
        'bagian': selectedBagian,
        'c_desc': c_desc.text,
      },
    );
    var data = json.decode(response.body);
    if (data == "Error") {
      Navigator.pushReplacementNamed(context, 'EditData');
      showRegisterSuccessSnackBar1();
    } else {
      await User.setsignin(true);
      Navigator.pushReplacementNamed(context, 'WelcomeUser');
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
                      value: selectedBagian,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bagian',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedBagian = newValue!;
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
