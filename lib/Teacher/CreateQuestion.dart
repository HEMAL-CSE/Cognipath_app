import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherCreateQuestion extends StatefulWidget {
  const TeacherCreateQuestion({super.key});

  @override
  State<TeacherCreateQuestion> createState() => _TeacherCreateQuestionState();
}

class _TeacherCreateQuestionState extends State<TeacherCreateQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Create Question',),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/create_mcq_question');
              //   },
              //   child: Card(
              //     color: Color(0xff01013f),
              //     elevation: 5,
              //     margin: EdgeInsets.all(21),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     child: Container(
              //       height: 150,
              //       width: 230,
              //       child: Center(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Icon(Icons.note_alt, color: Colors.white, size: 30,),
              //             SizedBox(width: 10,),
              //             Text('MCQ', style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white,
              //               fontSize: 26
              //             ),)
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/create_blooms_question');
                },
                child: Card(
                  color: Color(0xff01013f),
                  elevation: 5,
                  margin: EdgeInsets.all(21),
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
                          Icon(Icons.note_alt, color: Colors.white, size: 30,),
                          SizedBox(width: 10,),
                          Text('BLOOMS', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 26
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/create_chapter');
              //   },
              //   child: Card(
              //     color: Color(0xff01013f),
              //     elevation: 5,
              //     margin: EdgeInsets.all(21),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     child: Container(
              //       height: 150,
              //       width: 230,
              //       child: Center(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Icon(Icons.note_alt, color: Colors.white, size: 30,),
              //             SizedBox(width: 10,),
              //             Text('Create Chapter', style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white,
              //                 fontSize: 20
              //             ),)
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
