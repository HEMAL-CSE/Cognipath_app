import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Give Exam',),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/giveExammcq');
                },
                child: Card(
                  color: Color(0xff01013f),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    height: 150,
                    width: 230,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_alt, color: Colors.white, size: 29,),
                          SizedBox(width: 10,),
                          Text('MCQ', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/create_blooms_question');
                },
                child: Card(
                  color: Color(0xff01013f),
                  elevation: 5,
                  margin: EdgeInsets.all(06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    height: 150,
                    width: 230,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_alt, color: Colors.white, size: 29,),
                          SizedBox(width: 10,),
                          Text('BLOOMS', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
