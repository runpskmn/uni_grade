import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_grade/pages/home_page/home_page.dart';
import 'package:uni_grade/pages/login_page/login_page.dart';
import 'package:uni_grade/pages/register_page/reister_info_page.dart';
import 'package:uni_grade/pages/register_page/reister_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.kanit().fontFamily,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 30.0),
          bodyText2: TextStyle(fontSize: 18.0),
        ),
        primarySwatch: Colors.red,
      ),
      initialRoute: '/login',
      routes: {
        LoginPage.routeName : (context) => LoginPage(),
        RegisterPage.routeName : (context) => RegisterPage(),
        RegisterInfoPage.routeName : (context) => RegisterInfoPage(),
        HomePage.routeName : (context) => HomePage(),
      },
    );
  }
}