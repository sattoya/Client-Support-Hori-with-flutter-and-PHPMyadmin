import 'package:cssupport/screens/Welcome_Admin.dart';
import 'package:cssupport/screens/Welcome_User.dart';
import 'package:cssupport/screens/edit_admin.dart';
import 'package:cssupport/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cssupport/screens/Welcome_screen.dart';
import 'package:cssupport/screens/register_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
      routes: {
        'WelcomeScreen':(context) => WelcomeScreen(),
        'WelcomeAdmin':(context) => WelcomeAdmin(),
        'WelcomeUser':(context) => WelcomeUser(),
        'RegisterScreen':(context) => RegisterScreen(),
        'LoginScreen':(context) => LoginScreen(),
        'EditAdminScreen':(context) => EditAdminScreen(),
      },
    );
  }
}
