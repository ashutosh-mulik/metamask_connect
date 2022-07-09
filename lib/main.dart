import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metamask_connect/main_screen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.signikaTextTheme(),
      ),
      home: const MainScreen(),
    );
  }
}
