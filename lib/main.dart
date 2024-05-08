import 'package:cognipath/Home.dart';
import 'package:cognipath/Login.dart';
import 'package:cognipath/StudentsDeshboard.dart';
import 'package:cognipath/TeacherDeshboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/':(context) => Login(),
        '/studentDeshboard': (context) => StudentDeshboard(),
        '/teacherDeshboard': (context) => TeacherDeshboard(),
        '/home' : (context) => Home(),

      },

    );
  }
}


