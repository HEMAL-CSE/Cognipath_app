import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiveMarks extends StatefulWidget {
  const GiveMarks({super.key});

  @override
  State<GiveMarks> createState() => _GiveMarksState();
}

class _GiveMarksState extends State<GiveMarks> {


  List questions = [];
  List students = [];
  bool loading = false;


  String? category;
  List categories = [
    {'name':'blooms'}, {'name':'mcq'}
  ];

  String? exam_id;

  List exams = [];

  void get_exams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? class_id = prefs.getString('class_id');
    String? teacher_role = prefs.getString('teacher_role');
    String? subject_id = prefs.getString('subject_id');
    String? course_id = prefs.getString('course_id');

    var courseorclassid = teacher_role == 'Up to HSC' ? 'class_id=${class_id}&subject_id=${subject_id}' : teacher_role == 'Undergraduate' ? 'course_id=${course_id}' : '';

    final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/exam_name/?${courseorclassid}');

    Response res = await get(url);

    setState(() {
      exams = jsonDecode(res.body);
    });
  }

  getStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? class_id = prefs.getString('class_id');
    String? teacher_role = prefs.getString('teacher_role');
    String? subject_id = prefs.getString('subject_id');
    String? course_id = prefs.getString('course_id');

      var courseorclassid = teacher_role == 'Up to HSC' ? 'class_id=${class_id}&subject_id=${subject_id}&exam_id=${exam_id}' : teacher_role == 'Undergraduate' ? 'course_id=${course_id}&exam_id=${exam_id}' : '';

      final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/answers?${courseorclassid}');

      Response res = await get(url);
      print(url);

      var resbody = jsonDecode(res.body);
      List result = resbody
          .fold({}, (previousValue, element) {
        Map val = previousValue as Map;
        // print(val);
        var id = element['stem_id'];
        if (!val.containsKey(id)) {
          val[id] = [];
        }
        element.remove('stem_id');
        element['loading'] = false;
        element['given_marks'] = TextEditingController(text: element['marks'] != null ? element['marks'] : '');
        val[id]?.add(element);
        return val;
      })
          .entries
          .map((e) => {e.key: e.value})
          .toList();

      print(result);

    setState(() {
      students = result;
    });
  }

  addMarks() async {

      // Map data = {'exam_id': };
      for(var i in students){
        for(var k in i[i.keys.toList()[0]]){
          print(k);
          final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/marks/add?id=${k['answer_id']}');
          Map data = {'marks': k['given_marks'].text};
          if(k['given_marks'].text != ''){
            Response res = await put(url, body: data);
          }
        }
      }
      Fluttertoast.showToast(
          msg: "Submitted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0

      );


  }


  // getExam() async {
  //   final url = Uri.parse('http://68.178.163.174:5001/exam/${category}?chapter_id=${chapter}');
  //
  //   Response res = await get(url);
  //   print(url);
  //
  //   var resbody = jsonDecode(res.body);
  //   List result = resbody
  //       .fold({}, (previousValue, element) {
  //     Map val = previousValue as Map;
  //     // print(val);
  //     var id = element['stem_id'];
  //     if (!val.containsKey(id)) {
  //       val[id] = [];
  //     }
  //     element.remove('stem_id');
  //     element['marks'] = TextEditingController();
  //     val[id]?.add(element);
  //     return val;
  //   })
  //       .entries
  //       .map((e) => {e.key: e.value})
  //       .toList();
  //
  //   print(result);
  //
  //   // return result;
  //   setState(() {
  //     questions = result;
  //   });
  // }

  void generateMarks(correct_answer, answer, k, ques_desc, i) async {
    print(students[i][students[i].keys.toList()[0]][k]);
    var copystudents = students;
    copystudents[i][copystudents[i].keys.toList()[0]][k]['loading'] = true;
    setState(() {
      students = copystudents;
    });

    final url = Uri.parse('http://68.178.163.174:5501/evaluate');

    List data = [{
      "answer_1": correct_answer,
      "answer_2": correct_answer,
      "answer_3": correct_answer,
      "answer_4": correct_answer,
      "question": ques_desc,
      "student_answer": answer
    }];

    Response res = await post(url, body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    var resbody = jsonDecode(res.body);


    copystudents[i][copystudents[i].keys.toList()[0]][k]['given_marks'].text = resbody['results'][0]['mark'].toString();
    copystudents[i][copystudents[i].keys.toList()[0]][k]['loading'] = false;
    setState(() {
      students = copystudents;
      loading = false;
    });




  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    get_exams();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Give Marks',),
      body: SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(height: 10,),

            CustomDropdown(value: exam_id, data: exams, onChanged: (value){
              setState(() {
                exam_id = value;
              });
            }, fieldNames: ['exam_name', 'exam_id'], hint: 'Exam Name',),

            ElevatedButton(onPressed: () {
              getStudents();
            }, child: Text('Search')),

            SizedBox(height: 20,),

            for(var i in students)
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Text('Name: ${i[i.keys.toList()[0]][0]['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text('Ques:  ${students.indexOf(i) +1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Wrap(
                          children: [
                            for(var k in i[i.keys.toList()[0]])
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Text('${k['ques_point']}.', style: TextStyle(fontWeight: FontWeight.w800),),
                                  SizedBox(width: 5,),
                                  Flexible(child: Text('${k['answer']}')),
                                  SizedBox(width: 5,),
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: 90,
                                      child: CustomTextField(controller: k['given_marks'], hintText: 'marks', obscureText: false, textinputtypephone: false)),
                                  Text('[${k['ques_marks']}]'),
                                  // k['loading'] == true ?
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                  //   child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator()),
                                  // ) :
                                  // GestureDetector(
                                  //   onTap: () {
                                  //       generateMarks(k['correct_answer'], k['answer'], i[i.keys.toList()[0]].indexOf(k), k['ques_desc'], students.indexOf(i));
                                  //   },
                                  //   child: Container(
                                  //     margin: EdgeInsets.symmetric(horizontal: 2),
                                  //     padding: EdgeInsets.all(4),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey,
                                  //       borderRadius: BorderRadius.circular(4)
                                  //     ),
                                  //     child: Icon(CupertinoIcons.sparkles, size: 20,
                                  //     ),
                                  //   ),
                                  // )

                                ],
                              ),
                          ],
                        ),

                    ],
                  ),
                ),
              ),

            ElevatedButton(onPressed: () {
              addMarks();
            }, child: Text('Submit'))

          ],
        ),
      ),
    );
  }
}
