import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class TeacherDeshboard extends StatefulWidget {
  const TeacherDeshboard({super.key});

  @override
  State<TeacherDeshboard> createState() => _TeacherDeshboardState();
}

class _TeacherDeshboardState extends State<TeacherDeshboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Teacher Dashboard', ),

      body: SingleChildScrollView(
          primary: false,
          child:
          Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/requestedList');
                  },
                  child: Card(
                    color: Color(0xff01013f),
                    elevation: 5,
                    margin: EdgeInsets.all(21),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(96.0),
                    ),
                    child: Container(
                      height: 190,
                      width: 190,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Create Question',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.5, color: Colors.white),),
                            SizedBox(height: 12,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Icons.question_answer_outlined, )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/acceptedList');
                  },
                  child: Card(
                    color: Color(0xff01013f),
                    elevation: 5,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(96.0),
                    ),
                    child: Container(
                      height: 190,
                      width: 190,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Set Exam',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                            SizedBox(height: 12,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Icons.question_answer_outlined)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/acceptedList');
                  },
                  child: Card(
                    color: Color(0xff01013f),
                    elevation: 5,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(96.0),
                    ),
                    child: Container(
                      height: 190,
                      width: 190,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Give Marks',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                            SizedBox(height: 12,),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Icon(Icons.note_alt)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )

      ),


    );
  }
}
