import 'package:flutter/material.dart';
import 'package:iot_project/pages/loginPage.dart';
import 'homeApp.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // runApp(const MyApp());
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData (
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),

      home: const LoginPage(),
    );
  }
}


