import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoHoriAdmin extends StatelessWidget {
  const LogoHoriAdmin({Key? key, this.isColored = false}) : super(key: key);

  final bool isColored;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add desired padding here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isColored ? 'assets/logo_hori.png' : 'assets/logo_hori.png',
          ),
          const SizedBox(height: 2.2,),
          Text(
            'CLIENT SUPPORT',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isColored ? Color.fromARGB(255, 37, 37, 37) : Colors.white,
            ),
          ),
          Text(
            'ADMIN',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isColored ? Color.fromARGB(255, 37, 37, 37) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
