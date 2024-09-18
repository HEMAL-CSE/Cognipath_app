import 'package:cognipath/Employee/employee.dart';
import 'package:cognipath/Home.dart';
import 'package:cognipath/Login.dart';
import 'package:cognipath/Register.dart';
import 'package:cognipath/StudentPages/CareerPath.dart';
import 'package:cognipath/StudentPages/CheckMarks.dart';
import 'package:cognipath/StudentPages/GiveExamBlooms.dart';
import 'package:cognipath/StudentPages/GiveExamMCQ.dart';
import 'package:cognipath/StudentPages/StudentPage.dart';
import 'package:cognipath/Student/StudentsDeshboard.dart';
import 'package:cognipath/Teacher/TeacherDeshboard.dart';
import 'package:cognipath/Student/StudentsDeshboard.dart';
import 'package:cognipath/Teacher/CreateBloomsQuestion.dart';
import 'package:cognipath/Teacher/CreateChapter.dart';
import 'package:cognipath/Teacher/CreateMcqQuestion.dart';
import 'package:cognipath/Teacher/CreateQuestion.dart';
import 'package:cognipath/Teacher/GiveMarks.dart';
import 'package:cognipath/Teacher/SetExam.dart';
import 'package:cognipath/Teacher/TeacherDeshboard.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // // // Initialize Firebase SDK
  // await Firebase.initializeApp();
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
        '/register': (context) => Register(),
        '/studentpage' : (context) => StudentPage(),
        '/giveExammcq' : (context) => GiveExamMcq(),
        '/create_question': (context) => TeacherCreateQuestion(),
        '/create_mcq_question': (context) => CreateMcqQuestion(),
        '/create_blooms_question': (context) => CreateBloomsQuestion(),
        '/create_chapter': (context) => CreateChapter(),
        '/set_exam': (context) => SetExam(),

        '/giveExamblooms': (context) => GiveExamBlooms(),

        '/give_marks': (context) => GiveMarks(),
        '/checkmarks': (context) => CheckMarks(),
        '/career_path': (context) => CareerPath(),

        '/employee': (context) => Employee(),
      },

    );
  }
}


