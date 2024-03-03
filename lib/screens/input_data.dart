import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cssupport/services/user.dart';

class InputDataScreen extends StatefulWidget {
  const InputDataScreen({Key? key}) : super(key: key);

  @override
  State<InputDataScreen> createState() => _InputDataScreenState();
}

class _InputDataScreenState extends State<InputDataScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nama = TextEditingController();
  TextEditingController c_date = TextEditingController();
  String selectedBagian = 'Accounting';
  TextEditingController c_desc = TextEditingController();
  TextEditingController Cause = TextEditingController();
  TextEditingController Action = TextEditingController();
  TextEditingController Req = TextEditingController();
  TextEditingController f_date = TextEditingController();
  TextEditingController Waktu_perbaikan = TextEditingController();
  TextEditingController Status = TextEditingController();
  String isDataCorrect = 'Tidak';

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";
    c_date.text = formattedDate;
  }

  Future request() async {
    if (isDataCorrect == 'Ya') {
      String url = "http://36.88.137.170:8080/csphp/inputuser.php";
      final response = await http.post(Uri.parse(url), body: {
        'nama': nama.text,
        'c_date': c_date.text,
        'bagian': selectedBagian,
        'c_desc': c_desc.text,
        'Cause': Cause.text = ' ',
        'Action': Action.text = ' ',
        'Req': Req.text = ' ',
        'f_date': f_date.text = ' ',
        'Waktu_perbaikan': Waktu_perbaikan.text = ' ',
        'Status': Status.text = 'NG',
      });
      var data = json.decode(response.body);
      if (data == "Error") {
        Navigator.pushReplacementNamed(context, 'RequestStockScreen');
        showRegisterSuccessSnackBar1();
      } else {
        await User.setsignin(true);
        Navigator.pushReplacementNamed(context, 'WelcomeUser');
        showRegisterSuccessSnackBar();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pilih Ya jika data sudah benar.'),
        ),
      );
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
                    'Isi Data',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
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
                    child: DropdownButtonFormField<String>(
                      value: isDataCorrect,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Apakah data sudah benar?',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          isDataCorrect = newValue!;
                        });
                      },
                      items: [
                        'Ya',
                        'Tidak',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 0, 114, 180),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        bool pass = formKey.currentState!.validate();
                        if (pass) {
                          request();
                        }
                      },
                      child: const Text(
                        'Kirim',
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
