import 'package:cssupport/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cssupport/screens/Welcome_User.dart';
import 'package:cssupport/widget/logo_hori.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
            const LogoHori(isColored: true),
            const Spacer(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => WelcomeUser()),
                );
              },
              child: const Text('Login User'),
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


            const SizedBox(height: 15.0),
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Login Admin'),
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
