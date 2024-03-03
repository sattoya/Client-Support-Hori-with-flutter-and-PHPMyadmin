import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cssupport/screens/input_data.dart';
import 'package:cssupport/screens/output_data.dart';
import 'package:cssupport/widget/logo_hori_User.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0x95484848),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const LogoHoriUser(isColored: true),
            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => InputDataScreen()),
                );
              },
              child: const Text('Masukan Data'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 114, 180),
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                minimumSize: const Size(280.0, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                textStyle: GoogleFonts.poppins(fontSize: 20.0),
                side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            const SizedBox(height: 10.0),
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => OutputDataScreen()),
                );
              },
              child: const Text('Lihat Data'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 114, 180),
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                minimumSize: const Size(280.0, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                textStyle: GoogleFonts.poppins(fontSize: 20.0),
                side: const BorderSide(color: Color.fromARGB(255, 253, 253, 253)),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
            const Spacer(), 
          ],
        ),
      ),
    );
  }
}
